import SwiftUI

// MARK: - RiskBadge

struct RiskBadge: View {
    let level: RiskLevel

    private var dotColor: Color {
        switch level {
        case .low: return .secondary
        case .medium: return .blue
        case .high: return .orange
        case .verifySeparately: return .red
        }
    }

    private var background: Color {
        switch level {
        case .low: return Color(.secondarySystemBackground)
        case .medium: return Color.blue.opacity(0.10)
        case .high: return Color.orange.opacity(0.12)
        case .verifySeparately: return Color.red.opacity(0.10)
        }
    }

    private var foreground: Color {
        switch level {
        case .low: return .secondary
        case .medium: return .blue
        case .high: return .orange
        case .verifySeparately: return .red
        }
    }

    private var border: Color { foreground.opacity(0.30) }

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(dotColor)
                .frame(width: 6, height: 6)
            Text(level.label)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(background, in: Capsule())
        .overlay(Capsule().strokeBorder(border, lineWidth: 1))
        .foregroundStyle(foreground)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Risk level: \(level.label)")
    }
}

// MARK: - JurisdictionBadge

struct JurisdictionBadge: View {
    let type: JurisdictionType

    var body: some View {
        Text(type.label)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color(.systemBackground), in: Capsule())
            .overlay(Capsule().strokeBorder(Color(.separator), lineWidth: 1))
            .foregroundStyle(.secondary)
            .accessibilityLabel("Jurisdiction: \(type.label)")
    }
}

// MARK: - SourceStatusBadge

struct SourceStatusBadge: View {
    let status: SourceStatus

    private var color: Color {
        switch status {
        case .current: return .green
        case .reviewRecommended: return Color.yellow
        case .possiblyOutdated: return .orange
        case .stale: return .red
        case .placeholder, .missing: return .secondary
        }
    }

    private var isDashed: Bool {
        status == .placeholder || status == .missing
    }

    var body: some View {
        Text(status.label)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.10), in: Capsule())
            .overlay(
                Capsule().strokeBorder(
                    color.opacity(0.45),
                    style: StrokeStyle(lineWidth: 1, dash: isDashed ? [3, 3] : [])
                )
            )
            .foregroundStyle(color)
            .accessibilityLabel("Source status: \(status.label)")
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        HStack { ForEach(RiskLevel.displayOrder) { RiskBadge(level: $0) } }
        HStack {
            JurisdictionBadge(type: .stateLaw)
            JurisdictionBadge(type: .agencyRule)
        }
        VStack(alignment: .leading) {
            SourceStatusBadge(status: .current)
            SourceStatusBadge(status: .reviewRecommended)
            SourceStatusBadge(status: .possiblyOutdated)
            SourceStatusBadge(status: .stale)
            SourceStatusBadge(status: .placeholder)
            SourceStatusBadge(status: .missing)
        }
    }
    .padding()
}
