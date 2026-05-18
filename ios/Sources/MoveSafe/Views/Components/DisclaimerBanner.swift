import SwiftUI

enum DisclaimerVariant { case full, short }
enum DisclaimerTone { case neutral, subtle }

struct DisclaimerBanner: View {
    var variant: DisclaimerVariant = .short
    var tone: DisclaimerTone = .neutral

    private var message: String {
        variant == .full ? Disclaimers.main : Disclaimers.short
    }

    private var background: Color {
        switch tone {
        case .neutral: return Color.yellow.opacity(0.12)
        case .subtle: return Color(.secondarySystemBackground)
        }
    }

    private var border: Color {
        switch tone {
        case .neutral: return Color.yellow.opacity(0.45)
        case .subtle: return Color(.separator)
        }
    }

    private var foreground: Color {
        switch tone {
        case .neutral: return Color.orange
        case .subtle: return .secondary
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .imageScale(.small)
                .foregroundStyle(foreground)
                .padding(.top, 2)
            Text(message)
                .font(.callout)
                .foregroundStyle(foreground)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(background, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(border, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Disclaimer. \(message)")
    }
}
