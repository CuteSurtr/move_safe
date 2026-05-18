import Foundation

enum ChecklistEngineError: Error, LocalizedError {
    case unknownOriginState(String)
    case unknownDestinationState(String)
    case unknownPurpose(String)

    var errorDescription: String? {
        switch self {
        case .unknownOriginState(let id): return "Unknown origin state: \(id)"
        case .unknownDestinationState(let id): return "Unknown destination state: \(id)"
        case .unknownPurpose(let id): return "Unknown purpose: \(id)"
        }
    }
}

enum ChecklistEngine {
    static func generate(
        input: GenerateChecklistInput,
        reference: Date = Date()
    ) throws -> GenerateChecklistOutput {
        guard let originState = States.byId[input.originStateId] else {
            throw ChecklistEngineError.unknownOriginState(input.originStateId)
        }
        guard let destinationState = States.byId[input.destinationStateId] else {
            throw ChecklistEngineError.unknownDestinationState(input.destinationStateId)
        }
        guard let purpose = Purposes.byId[input.purposeId] else {
            throw ChecklistEngineError.unknownPurpose(input.purposeId)
        }

        let selectedCategories = Set(input.selectedCategoryIds)
        let selectedFlags = Set(input.selectedProfileFlags)

        let filtered = ChecklistItems.all.filter { item in
            guard selectedCategories.contains(item.categoryId) else { return false }

            // Purpose match (or item applies to all purposes when list is empty).
            if !item.appliesToPurposes.isEmpty,
               !item.appliesToPurposes.contains(input.purposeId) {
                return false
            }

            // Profile-flag match: if item declares flags, at least one must
            // match, unless the user selected no flags at all (then we keep
            // flag-tagged items in to avoid empty results).
            if !item.appliesToProfileFlags.isEmpty, !selectedFlags.isEmpty {
                let anyMatch = item.appliesToProfileFlags.contains { selectedFlags.contains($0) }
                if !anyMatch { return false }
            }

            // State-specific items (none in MVP seed, but enforced for future data).
            if let originId = item.originStateId, originId != input.originStateId {
                return false
            }
            if let destId = item.destinationStateId, destId != input.destinationStateId {
                return false
            }

            return true
        }

        // Attach sources with computed staleness, resolving any state-bound URLs
        // against the origin / destination states. When a binding resolves to a
        // real state URL (i.e. the state had a non-placeholder value for that
        // field), upgrade the source status to CURRENT — it was verified during
        // the research run that populated those URLs.
        let withSources: [ChecklistItemWithSources] = filtered.map { item in
            let attached = item.sourceIds
                .compactMap { Sources.byId[$0] }
                .map { src -> SourceWithStatus in
                    let resolved = resolveUrl(for: src, origin: originState, destination: destinationState)
                    let baseStatus = SourceStatusEngine.compute(for: src, reference: reference)
                    let didResolveAgainstState = src.stateUrlBinding != nil && resolved != src.url
                    let status: SourceStatus = didResolveAgainstState ? .current : baseStatus
                    return SourceWithStatus(
                        source: src,
                        computedStatus: status,
                        resolvedUrl: resolved
                    )
                }
            return ChecklistItemWithSources(item: item, sources: attached)
        }

        // Group by category. Sort items within each group by display risk order.
        let riskOrderIndex = Dictionary(
            uniqueKeysWithValues: RiskLevel.displayOrder.enumerated().map { ($1, $0) }
        )

        var groupedByCategory: [String: [ChecklistItemWithSources]] = [:]
        for entry in withSources {
            groupedByCategory[entry.item.categoryId, default: []].append(entry)
        }
        for key in groupedByCategory.keys {
            groupedByCategory[key]?.sort { a, b in
                (riskOrderIndex[a.item.riskLevel] ?? 0) < (riskOrderIndex[b.item.riskLevel] ?? 0)
            }
        }

        // Order group keys by category.sortOrder.
        let ordered: [(categoryId: String, items: [ChecklistItemWithSources])] =
            Categories.all
                .compactMap { cat in
                    guard let items = groupedByCategory[cat.id], !items.isEmpty else { return nil }
                    return (cat.id, items)
                }

        // Risk counts across visible items.
        var riskCounts: [RiskLevel: Int] = [
            .verifySeparately: 0, .high: 0, .medium: 0, .low: 0
        ]
        for entry in withSources {
            riskCounts[entry.item.riskLevel, default: 0] += 1
        }

        // Warnings derived from the result set.
        var warnings: [String] = []

        let hasPlaceholder = withSources.contains { entry in
            entry.sources.contains { $0.computedStatus.isPlaceholderOrMissing }
        }
        if hasPlaceholder {
            warnings.append("Some checklist items use placeholder sources. Replace with official sources before relying on them.")
        }

        let hasStale = withSources.contains { entry in
            entry.sources.contains { $0.computedStatus.isStale }
        }
        if hasStale {
            warnings.append("Some sources have not been verified recently. Check the official website before relying on them.")
        }

        if (riskCounts[.verifySeparately] ?? 0) > 0 {
            warnings.append("High-risk categories require separate verification. MoveSafe does not determine whether possession, transportation, or use of regulated items is lawful.")
        }

        warnings.append("This checklist is not a legal conclusion. Verify with official sources and consult a licensed professional where appropriate.")

        if input.originStateId == input.destinationStateId {
            warnings.insert(
                "Origin and destination are the same. MoveSafe is designed for state-to-state moves — some items may not apply.",
                at: 0
            )
        }

        return GenerateChecklistOutput(
            originState: originState,
            destinationState: destinationState,
            purpose: purpose,
            groupedItems: ordered,
            riskCounts: riskCounts,
            warnings: warnings,
            totalItems: withSources.count
        )
    }

    /// Resolves a source's display URL. If the source has a state-binding, pulls
    /// from the relevant state's matching agency URL; falls back to the source's
    /// literal `url` (typically `"#"` for placeholders) when the state has no
    /// value for that field.
    private static func resolveUrl(for source: Source, origin: USState, destination: USState) -> String {
        guard let binding = source.stateUrlBinding else { return source.url }
        let state = (binding.role == .destination) ? destination : origin
        return state.url(for: binding.field) ?? source.url
    }

    /// Unique sources across the grouped output, preserving first-seen order.
    static func uniqueSources(
        from grouped: [(categoryId: String, items: [ChecklistItemWithSources])]
    ) -> [SourceWithStatus] {
        var seen = Set<String>()
        var ordered: [SourceWithStatus] = []
        for (_, items) in grouped {
            for entry in items {
                for s in entry.sources where !seen.contains(s.source.id) {
                    seen.insert(s.source.id)
                    ordered.append(s)
                }
            }
        }
        return ordered
    }
}
