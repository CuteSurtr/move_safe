import Foundation

/// Renders a checklist into plain text suitable for sharing via the iOS share
/// sheet. The output mirrors the structure of the on-screen results: header,
/// disclaimer, warnings, then category groups with each item's title, what to
/// verify, and source URLs (when not placeholders).
enum ChecklistExport {
    static func plainText(
        from result: GenerateChecklistOutput,
        completed: Set<String> = []
    ) -> String {
        var out: [String] = []
        out.append("MoveSafe checklist")
        out.append("Moving from \(result.originState.name) to \(result.destinationState.name)")
        out.append("Purpose: \(result.purpose.name)")
        out.append("Total topics to verify: \(result.totalItems)")
        out.append("")
        out.append(Disclaimers.short)
        out.append("")

        if !result.warnings.isEmpty {
            out.append("Notes:")
            for w in result.warnings { out.append("- \(w)") }
            out.append("")
        }

        for (catId, items) in result.groupedItems {
            guard let cat = Categories.byId[catId] else { continue }
            out.append("== \(cat.name) ==")
            for entry in items {
                let mark = completed.contains(entry.item.id) ? "[x]" : "[ ]"
                out.append("\(mark) \(entry.item.title)  (\(entry.item.riskLevel.label))")
                if !entry.item.whatToVerify.isEmpty {
                    out.append("  What to verify:")
                    for v in entry.item.whatToVerify { out.append("    - \(v)") }
                }
                let officialUrls = entry.sources
                    .filter { !$0.computedStatus.isPlaceholderOrMissing && $0.resolvedUrl != "#" && !$0.resolvedUrl.isEmpty }
                    .map { "    - \($0.source.title): \($0.resolvedUrl)" }
                if !officialUrls.isEmpty {
                    out.append("  Sources:")
                    for line in officialUrls { out.append(line) }
                } else if !entry.sources.isEmpty {
                    out.append("  Sources: placeholder - verify with the relevant official agency.")
                }
                out.append("")
            }
        }

        out.append("---")
        out.append(Disclaimers.main)
        return out.joined(separator: "\n")
    }
}
