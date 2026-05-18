import SwiftUI

struct EmptyState<Action: View>: View {
    let title: String
    var description: String? = nil
    @ViewBuilder var action: () -> Action

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            if let description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 320)
            }
            action()
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal, 16)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

extension EmptyState where Action == EmptyView {
    init(title: String, description: String? = nil) {
        self.init(title: title, description: description, action: { EmptyView() })
    }
}
