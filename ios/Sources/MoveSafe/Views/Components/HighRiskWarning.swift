import SwiftUI

struct HighRiskWarning: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(L.t("High-risk categories require separate verification."))
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(L.t("Some items may be regulated differently across state lines and may involve state law, local ordinances, federal law, or agency rules. MoveSafe does not determine whether possession, transportation, or use is lawful in any specific situation. Verify directly with official sources and consult a licensed attorney or relevant agency if needed."))
                .font(.callout)
        }
        .foregroundStyle(.red)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.red.opacity(0.35), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(L.t("High-risk warning. High-risk categories require separate verification."))
    }
}
