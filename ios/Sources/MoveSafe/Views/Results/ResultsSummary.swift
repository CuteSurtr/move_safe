import SwiftUI

struct ResultsSummary: View {
    let origin: USState
    let destination: USState
    let purpose: Purpose
    let totalItems: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(L.t("YOUR CHECKLIST"))
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.tint)
            Text(String(format: L.t("Moving from %1$@ to %2$@"), origin.name, destination.name))
                .font(.title2)
                .fontWeight(.semibold)
            HStack(spacing: 4) {
                Text(L.t("Purpose:"))
                Text(L.t(purpose.name)).fontWeight(.medium).foregroundStyle(.primary)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Text(
                String(
                    format: L.t(
                        totalItems == 1
                            ? "%d topic to verify before moving. This checklist is not a legal conclusion."
                            : "%d topics to verify before moving. This checklist is not a legal conclusion."
                    ),
                    totalItems
                )
            )
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        )
    }
}
