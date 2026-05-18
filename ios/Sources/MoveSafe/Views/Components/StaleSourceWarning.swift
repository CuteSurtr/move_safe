import SwiftUI

struct StaleSourceWarning: View {
    let status: SourceStatus

    private var message: String? {
        switch status {
        case .reviewRecommended:
            return L.t("This source was checked more than 90 days ago. Review recommended.")
        case .possiblyOutdated:
            return L.t("This source has not been verified in more than six months. Check the official website before relying on it.")
        case .stale:
            return L.t("This source has not been verified in more than a year. Treat as stale and verify directly with the official source.")
        case .placeholder:
            return L.t("Placeholder source. Replace with an official source before relying on this item.")
        case .missing:
            return L.t("Official source needed before relying on this item.")
        case .current:
            return nil
        }
    }

    var body: some View {
        if let message {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "clock.badge.exclamationmark")
                    .foregroundStyle(.orange)
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.orange)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.yellow.opacity(0.10), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(Color.yellow.opacity(0.45), lineWidth: 1)
            )
            .accessibilityElement(children: .combine)
        }
    }
}
