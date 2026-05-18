import SwiftUI

struct ResultsSummary: View {
    let origin: USState
    let destination: USState
    let purpose: Purpose
    let totalItems: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("YOUR CHECKLIST")
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.tint)
            Text("Moving from \(origin.name) to \(destination.name)")
                .font(.title2)
                .fontWeight(.semibold)
            HStack(spacing: 4) {
                Text("Purpose:")
                Text(purpose.name).fontWeight(.medium).foregroundStyle(.primary)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Text("\(totalItems) \(totalItems == 1 ? "topic" : "topics") to verify before moving. This checklist is not a legal conclusion.")
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
