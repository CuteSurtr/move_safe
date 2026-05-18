import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var input: BuilderInputStore
    @Binding var path: [Route]

    private var hasSavedSelections: Bool {
        !input.originStateId.isEmpty ||
        !input.destinationStateId.isEmpty ||
        !input.purposeId.isEmpty ||
        !input.selectedCategoryIds.isEmpty ||
        !input.selectedProfileFlags.isEmpty
    }

    private let exampleCategories = [
        "Driver's license",
        "Vehicle registration",
        "Auto insurance",
        "Housing / renter basics",
        "Pets",
        "Employment paperwork",
        "Professional licensure",
        "Nursing / healthcare licensure",
        "State residency basics",
        "Taxes / filing awareness",
        "Student relocation",
        "Healthcare access"
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                hero
                howItWorks
                whatItDoesGrid
                exampleChips
                DisclaimerBanner(variant: .full, tone: .subtle)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("MoveSafe")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("CROSS-STATE RELOCATION CHECKLIST")
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.tint)
            Text("Moving across state lines? Know what to verify before you go.")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Build a state-to-state checklist for licenses, vehicles, housing, pets, work, school, healthcare licensure, and other rules that may change when you move.")
                .font(.callout)
                .foregroundStyle(.secondary)

            VStack(spacing: 10) {
                Button {
                    path.append(.builder)
                } label: {
                    Text(hasSavedSelections ? "Continue my checklist" : "Build my checklist")
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)

                if hasSavedSelections {
                    Button(role: .destructive) {
                        input.reset()
                        path.append(.builder)
                    } label: {
                        Text("Start fresh")
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                } else {
                    Button {
                        input.loadExample()
                        path.append(.builder)
                    } label: {
                        Text("View example checklist")
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.top, 4)

            Text("MoveSafe is a source-first checklist tool. It links you to official resources and highlights topics to verify. It does not provide legal advice.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder private var howItWorks: some View {
        Card {
            Text("HOW IT WORKS")
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 10) {
                step(1, "Choose your origin and destination state.")
                step(2, "Pick a purpose and the categories that apply.")
                step(3, "Get a grouped checklist with risk badges and links to official sources.")
            }
        }
    }

    private func step(_ n: Int, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(n)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
                .background(Color.accentColor, in: Circle())
            Text(text)
                .font(.subheadline)
        }
    }

    @ViewBuilder private var whatItDoesGrid: some View {
        VStack(spacing: 12) {
            Card {
                Text("What MoveSafe does")
                    .font(.headline)
                bullet("Generates a checklist of topics to verify before moving")
                bullet("Links to official state agency sources")
                bullet("Flags risk levels so you know where to focus")
                bullet("Highlights stale or placeholder sources")
                bullet("Treats high-risk categories with a \"Do not assume\" label")
            }
            Card {
                Text("What MoveSafe does not do")
                    .font(.headline)
                bullet("Provide legal advice or attorney-client services")
                bullet("Determine whether a specific act is lawful")
                bullet("Decide your residency, eligibility, or tax status")
                bullet("Help avoid enforcement or recommend workarounds")
                bullet("Replace official agency or licensed-professional guidance")
            }
        }
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
            Text(text)
        }
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder private var exampleChips: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Example checklist categories")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(exampleCategories, id: \.self) { name in
                        Text(name)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemBackground), in: Capsule())
                            .overlay(Capsule().strokeBorder(Color(.separator), lineWidth: 1))
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}
