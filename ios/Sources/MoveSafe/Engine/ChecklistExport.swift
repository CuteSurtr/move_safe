import Foundation

/// Renders a checklist into plain text suitable for sharing via the iOS share
/// sheet. The output mirrors the structure of the on-screen results: header,
/// disclaimer, warnings, then category groups with each item's title, what to
/// verify, and source URLs (when not placeholders).
///
/// Honors the current effective app language at the moment the share is tapped.
enum ChecklistExport {
    static func plainText(
        from result: GenerateChecklistOutput,
        completed: Set<String> = []
    ) -> String {
        var out: [String] = []
        out.append(L.t("MoveSafe checklist"))
        out.append(String(format: L.t("Moving from %1$@ to %2$@"), result.originState.name, result.destinationState.name))
        out.append(String(format: L.t("Purpose: %@"), L.t(result.purpose.name)))
        out.append(String(format: L.t("Total topics to verify: %d"), result.totalItems))
        out.append("")
        out.append(L.t(Disclaimers.short))
        out.append("")

        if !result.warnings.isEmpty {
            out.append(L.t("Notes:"))
            for w in result.warnings { out.append("- \(L.t(w))") }
            out.append("")
        }

        for (catId, items) in result.groupedItems {
            guard let cat = Categories.byId[catId] else { continue }
            out.append("== \(L.t(cat.name)) ==")
            for entry in items {
                let mark = completed.contains(entry.item.id) ? "[x]" : "[ ]"
                out.append("\(mark) \(L.t(entry.item.title))  (\(L.t(entry.item.riskLevel.label)))")
                if !entry.item.whatToVerify.isEmpty {
                    out.append("  " + L.t("What to verify:"))
                    for v in entry.item.whatToVerify { out.append("    - \(L.t(v))") }
                }
                let officialUrls = entry.sources
                    .filter { !$0.computedStatus.isPlaceholderOrMissing && $0.resolvedUrl != "#" && !$0.resolvedUrl.isEmpty }
                    .map { "    - \(L.t($0.source.title)): \($0.resolvedUrl)" }
                if !officialUrls.isEmpty {
                    out.append("  " + L.t("Sources:"))
                    for line in officialUrls { out.append(line) }
                } else if !entry.sources.isEmpty {
                    out.append("  " + L.t("Sources: placeholder - verify with the relevant official agency."))
                }
                out.append("")
            }
        }

        out.append("---")
        out.append(L.t(Disclaimers.main))
        return out.joined(separator: "\n")
    }
}
