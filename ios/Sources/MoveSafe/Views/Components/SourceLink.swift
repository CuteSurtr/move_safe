import SwiftUI

struct SourceLink: View {
    let source: SourceWithStatus

    private var isPlaceholderOrMissing: Bool { source.computedStatus.isPlaceholderOrMissing }

    private var resolvedURL: URL? {
        guard !isPlaceholderOrMissing else { return nil }
        let raw = source.resolvedUrl
        guard raw != "#", !raw.isEmpty else { return nil }
        return URL(string: raw)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(source.source.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    if let agency = source.source.agencyName {
                        Text(agency)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer(minLength: 8)
                SourceStatusBadge(status: source.computedStatus)
            }

            HStack(spacing: 12) {
                Text("Last verified: \(DateUtils.format(source.source.lastChecked))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if let url = resolvedURL {
                    Link(destination: url) {
                        HStack(spacing: 2) {
                            Text("Open official source")
                            Image(systemName: "arrow.up.right.square")
                        }
                        .font(.caption)
                        .fontWeight(.medium)
                    }
                } else {
                    Text("Placeholder - replace with official source")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
            }

            if let notes = source.source.notes {
                Text(notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        )
    }
}
