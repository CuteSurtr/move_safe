import SwiftUI

/// Wrapping horizontal layout. Children are placed left-to-right; when one
/// would exceed the proposed width, it starts a new row. Used for badge
/// groups on checklist cards.
struct FlowLayout: Layout {
    var hSpacing: CGFloat = 6
    var vSpacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        let rows = arrange(subviews: subviews, maxWidth: maxWidth)
        let height = rows.reduce(0) { $0 + $1.height } + CGFloat(max(0, rows.count - 1)) * vSpacing
        let width = rows.map(\.width).max() ?? 0
        return CGSize(width: min(width, maxWidth), height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = arrange(subviews: subviews, maxWidth: bounds.width)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            for entry in row.entries {
                let size = entry.size
                subviews[entry.index].place(
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading,
                    proposal: ProposedViewSize(size)
                )
                x += size.width + hSpacing
            }
            y += row.height + vSpacing
        }
    }

    private struct RowEntry { let index: Int; let size: CGSize }
    private struct Row { var entries: [RowEntry]; var width: CGFloat; var height: CGFloat }

    private func arrange(subviews: Subviews, maxWidth: CGFloat) -> [Row] {
        var rows: [Row] = []
        var current = Row(entries: [], width: 0, height: 0)
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            let extra = current.entries.isEmpty ? 0 : hSpacing
            if current.width + extra + size.width > maxWidth, !current.entries.isEmpty {
                rows.append(current)
                current = Row(entries: [], width: 0, height: 0)
            }
            let pad = current.entries.isEmpty ? 0 : hSpacing
            current.entries.append(RowEntry(index: index, size: size))
            current.width += pad + size.width
            current.height = max(current.height, size.height)
        }
        if !current.entries.isEmpty { rows.append(current) }
        return rows
    }
}
