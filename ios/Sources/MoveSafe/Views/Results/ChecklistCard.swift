import SwiftUI

struct ChecklistCard: View {
    let entry: ChecklistItemWithSources
    @EnvironmentObject private var progress: ProgressStore
    @State private var isExpanded: Bool = false

    private var category: Category? {
        Categories.byId[entry.item.categoryId]
    }

    private var isCompleted: Bool {
        progress.isCompleted(entry.item.id)
    }

    // Picks the most-concerning status across sources for the inline warning.
    private var worstStatus: SourceStatus? {
        let order: [SourceStatus] = [.missing, .placeholder, .stale, .possiblyOutdated, .reviewRecommended]
        let statuses = entry.sources.map { $0.computedStatus }
        for s in order where statuses.contains(s) {
            return s
        }
        return nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.15)) {
                    isExpanded.toggle()
                }
            } label: {
                header
                    .padding(14)
            }
            .buttonStyle(.plain)
            .accessibilityHint(isExpanded ? "Tap to collapse" : "Tap to expand")
            .accessibilityAddTraits(.isButton)

            if isExpanded {
                Divider()
                expandedDetails
                    .padding(14)
                    .background(Color(.secondarySystemBackground))
            }
        }
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .opacity(isCompleted ? 0.6 : 1)
    }

    @ViewBuilder private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            // Completion toggle. Standalone Button so it doesn't trigger the
            // expand/collapse parent button.
            Button {
                progress.toggle(entry.item.id)
            } label: {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
                    .foregroundStyle(isCompleted ? Color.green : Color.secondary)
            }
            .buttonStyle(.plain)
            .padding(.top, 2)
            .accessibilityLabel(isCompleted ? "Mark as not verified" : "Mark as verified")

            VStack(alignment: .leading, spacing: 8) {
                FlowLayout(hSpacing: 6, vSpacing: 6) {
                    RiskBadge(level: entry.item.riskLevel)
                    JurisdictionBadge(type: entry.item.jurisdictionType)
                    if let category {
                        Text(category.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Text(entry.item.title)
                    .font(.headline)
                    .strikethrough(isCompleted, color: .secondary)
                    .multilineTextAlignment(.leading)
                Text(entry.item.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.down")
                .imageScale(.small)
                .foregroundStyle(.secondary)
                .rotationEffect(.degrees(isExpanded ? 180 : 0))
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder private var expandedDetails: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("WHY THIS MATTERS")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .tracking(0.6)
                    .foregroundStyle(.secondary)
                Text(entry.item.whyItMatters)
                    .font(.subheadline)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("WHAT TO VERIFY")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .tracking(0.6)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(entry.item.whatToVerify, id: \.self) { point in
                        HStack(alignment: .top, spacing: 6) {
                            Text("•")
                            Text(point)
                        }
                        .font(.subheadline)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("OFFICIAL SOURCES")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .tracking(0.6)
                    .foregroundStyle(.secondary)
                if entry.sources.isEmpty {
                    Text("Official source needed before relying on this item.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(Color(.separator), style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                        )
                } else {
                    VStack(spacing: 8) {
                        ForEach(entry.sources) { source in
                            SourceLink(source: source)
                        }
                    }
                }
                if let worst = worstStatus {
                    StaleSourceWarning(status: worst)
                }
            }

            if let notes = entry.item.safeLanguageNotes {
                Text("Note for editors: \(notes)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("General information only. Verify with the relevant official source. Not legal advice.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
