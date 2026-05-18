import SwiftUI

struct ChecklistGroup: View {
    let categoryId: String
    let items: [ChecklistItemWithSources]

    private var category: Category? { Categories.byId[categoryId] }

    var body: some View {
        if let category, !items.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text(category.name)
                        .font(.headline)
                    Spacer()
                    Text("\(items.count) \(items.count == 1 ? "item" : "items")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if category.isHighRiskCategory {
                    Text("Do not assume rules from your origin state apply. Rules vary across state, local, and federal jurisdictions. Verify directly with official sources.")
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(Color.red.opacity(0.30), lineWidth: 1)
                        )
                }

                VStack(spacing: 10) {
                    ForEach(items) { entry in
                        ChecklistCard(entry: entry)
                    }
                }
            }
        }
    }
}
