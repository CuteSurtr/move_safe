import SwiftUI

struct ResultFilters: Equatable {
    var riskLevels: Set<RiskLevel> = []
    var highRiskOnly: Bool = false
    var staleOnly: Bool = false
}

struct FilterBar: View {
    @Binding var filters: ResultFilters

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Risk-level chips.
            VStack(alignment: .leading, spacing: 8) {
                Text(L.t("RISK"))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .tracking(0.6)
                    .foregroundStyle(.secondary)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(RiskLevel.displayOrder) { level in
                            let active = filters.riskLevels.contains(level)
                            Button {
                                toggle(level)
                            } label: {
                                Text(L.t(level.label))
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        active ? Color.accentColor.opacity(0.15) : Color(.systemBackground),
                                        in: Capsule()
                                    )
                                    .overlay(
                                        Capsule().strokeBorder(
                                            active ? Color.accentColor : Color(.separator),
                                            lineWidth: 1
                                        )
                                    )
                                    .foregroundStyle(active ? Color.accentColor : .primary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityAddTraits(active ? [.isSelected] : [])
                        }
                    }
                }
            }

            // Toggles.
            VStack(alignment: .leading, spacing: 8) {
                Toggle(L.t("High-risk only"), isOn: $filters.highRiskOnly)
                Toggle(L.t("Stale or placeholder sources only"), isOn: $filters.staleOnly)
            }
            .font(.subheadline)
            .toggleStyle(.switch)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        )
    }

    private func toggle(_ level: RiskLevel) {
        if filters.riskLevels.contains(level) {
            filters.riskLevels.remove(level)
        } else {
            filters.riskLevels.insert(level)
        }
    }
}
