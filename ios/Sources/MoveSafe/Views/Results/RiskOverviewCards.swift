import SwiftUI

struct RiskOverviewCards: View {
    let counts: [RiskLevel: Int]

    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(RiskLevel.displayOrder) { level in
                RiskOverviewCard(level: level, count: counts[level] ?? 0)
            }
        }
    }
}

private struct RiskOverviewCard: View {
    let level: RiskLevel
    let count: Int

    private var accent: Color {
        switch level {
        case .low: return .secondary
        case .medium: return .blue
        case .high: return .orange
        case .verifySeparately: return .red
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(count)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(accent)
                .monospacedDigit()
            Text(level.label)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(level.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(accent.opacity(0.30), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(level.label): \(count) topics")
    }
}
