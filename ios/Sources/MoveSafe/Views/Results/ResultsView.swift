import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var input: BuilderInputStore
    @EnvironmentObject private var progress: ProgressStore
    @Binding var path: [Route]

    @State private var filters = ResultFilters()
    @State private var isSharePresented = false

    private var output: Result<GenerateChecklistOutput, Error> {
        Result { try ChecklistEngine.generate(input: input.snapshot()) }
    }

    var body: some View {
        ScrollView {
            content
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(L.t("Checklist"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if case .success = output {
                    Button {
                        isSharePresented = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .accessibilityLabel(L.t("Share checklist"))
                }
            }
        }
        .sheet(isPresented: $isSharePresented) {
            if case .success(let result) = output {
                ShareSheet(items: [
                    ChecklistExport.plainText(from: result, completed: progress.completedItemIds)
                ])
            }
        }
    }

    @ViewBuilder private var content: some View {
        switch output {
        case .failure(let err):
            EmptyState(
                title: L.t("Could not generate checklist"),
                description: err.localizedDescription
            ) {
                Button(L.t("Back to builder")) { path.removeLast() }
                    .buttonStyle(.borderedProminent)
            }
        case .success(let result):
            resultsBody(result)
        }
    }

    @ViewBuilder
    private func resultsBody(_ result: GenerateChecklistOutput) -> some View {
        let filteredGrouped = applyFilters(to: result.groupedItems)
        let visibleItems = filteredGrouped.flatMap { $0.items }
        let uniqueSources = ChecklistEngine.uniqueSources(from: filteredGrouped)
        let hasHighRisk = visibleItems.contains { $0.item.riskLevel == .verifySeparately || $0.item.isHighRisk }
        let visibleItemIds = visibleItems.map { $0.item.id }
        let visibleCompletedCount = visibleItemIds.reduce(0) { $0 + (progress.isCompleted($1) ? 1 : 0) }

        VStack(alignment: .leading, spacing: 16) {
            ResultsSummary(
                origin: result.originState,
                destination: result.destinationState,
                purpose: result.purpose,
                totalItems: result.totalItems
            )

            DisclaimerBanner(variant: .short)

            // Notes / warnings.
            VStack(alignment: .leading, spacing: 8) {
                Text(L.t(Disclaimers.resultsIntro))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(result.warnings, id: \.self) { w in
                        HStack(alignment: .top, spacing: 6) {
                            Text("•")
                            Text(L.t(w))
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                        Text(L.t(Disclaimers.coverageCaveat))
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }

            RiskOverviewCards(counts: result.riskCounts)

            if !visibleItemIds.isEmpty {
                progressBar(completed: visibleCompletedCount, total: visibleItemIds.count, visibleIds: visibleItemIds)
            }

            if hasHighRisk { HighRiskWarning() }

            FilterBar(filters: $filters)

            if filteredGrouped.isEmpty {
                EmptyState(
                    title: L.t("No items match your filters"),
                    description: L.t("Try clearing risk filters or the high-risk / stale-source toggles.")
                )
            } else {
                VStack(spacing: 18) {
                    ForEach(filteredGrouped, id: \.categoryId) { entry in
                        ChecklistGroup(categoryId: entry.categoryId, items: entry.items)
                    }
                }
            }

            sourcesSection(uniqueSources)

            HStack(spacing: 10) {
                Button {
                    path.removeLast()
                } label: {
                    Text(L.t("Edit selections"))
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)

                Button {
                    path.removeAll()
                } label: {
                    Text(L.t("Back to home"))
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
            }

            DisclaimerBanner(variant: .full, tone: .subtle)
        }
    }

    @ViewBuilder
    private func progressBar(completed: Int, total: Int, visibleIds: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(String(format: L.t("Verified: %1$d of %2$d"), completed, total))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                if completed > 0 {
                    Button(L.t("Reset progress")) {
                        progress.clear(itemIds: visibleIds)
                    }
                    .font(.caption)
                    .accessibilityHint(L.t("Clears the verified state on items currently shown."))
                }
            }
            ProgressView(value: total == 0 ? 0 : Double(completed) / Double(total))
                .tint(.green)
                .accessibilityLabel(L.t("Verification progress"))
                .accessibilityValue(String(format: L.t("%1$d of %2$d items verified"), completed, total))
        }
        .padding(12)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        )
    }

    @ViewBuilder
    private func sourcesSection(_ uniqueSources: [SourceWithStatus]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(L.t("Sources referenced in this checklist"))
                .font(.headline)
            Text(L.t("MoveSafe prefers official agency sources. Placeholder entries should be replaced with verified URLs before production use."))
                .font(.caption)
                .foregroundStyle(.secondary)
            if uniqueSources.isEmpty {
                Text(L.t("No sources are attached to the items in this view."))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 8) {
                    ForEach(uniqueSources) { source in
                        SourceLink(source: source)
                    }
                }
            }
        }
    }

    // Applies the UI filters on top of the engine's grouped result.
    private func applyFilters(
        to grouped: [(categoryId: String, items: [ChecklistItemWithSources])]
    ) -> [(categoryId: String, items: [ChecklistItemWithSources])] {
        var out: [(categoryId: String, items: [ChecklistItemWithSources])] = []
        for entry in grouped {
            let filtered = entry.items.filter { ci in
                if !filters.riskLevels.isEmpty, !filters.riskLevels.contains(ci.item.riskLevel) {
                    return false
                }
                if filters.highRiskOnly, !ci.item.isHighRisk, ci.item.riskLevel != .verifySeparately {
                    return false
                }
                if filters.staleOnly {
                    if ci.sources.isEmpty { return true }
                    let hasStale = ci.sources.contains { $0.computedStatus.isStale || $0.computedStatus.isPlaceholderOrMissing }
                    if !hasStale { return false }
                }
                return true
            }
            if !filtered.isEmpty {
                out.append((categoryId: entry.categoryId, items: filtered))
            }
        }
        return out
    }
}
