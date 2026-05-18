import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var input: BuilderInputStore
    @Binding var path: [Route]
    @State private var showSettings = false

    private var hasSavedSelections: Bool {
        !input.originStateId.isEmpty ||
        !input.destinationStateId.isEmpty ||
        !input.purposeId.isEmpty ||
        !input.selectedCategoryIds.isEmpty ||
        !input.selectedProfileFlags.isEmpty
    }

    // Categories that mirror the seed-data names. Rendered through L.t() so
    // they translate via MetaTranslations alongside the live Builder picker.
    private let exampleCategoryEnglishNames = [
        "Driver's license",
        "Vehicle registration",
        "Auto insurance",
        "Housing / renter basics",
        "Pets",
        "Employment paperwork",
        "Professional license transfer",
        "Nursing / healthcare licensure",
        "State residency basics",
        "Taxes / state filing awareness",
        "Student relocation",
        "Healthcare access / insurance"
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
        .navigationTitle(L.t("MoveSafe"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel(L.t("Settings"))
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }

    @ViewBuilder private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L.t("CROSS-STATE RELOCATION CHECKLIST"))
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.tint)
            Text(L.t("Moving across state lines? Know what to verify before you go."))
                .font(.title2)
                .fontWeight(.semibold)
            Text(L.t("Build a state-to-state checklist for licenses, vehicles, housing, pets, work, school, healthcare licensure, and other rules that may change when you move."))
                .font(.callout)
                .foregroundStyle(.secondary)

            VStack(spacing: 10) {
                Button {
                    path.append(.builder)
                } label: {
                    Text(L.t(hasSavedSelections ? "Continue my checklist" : "Build my checklist"))
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
                        Text(L.t("Start fresh"))
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
                        Text(L.t("View example checklist"))
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.top, 4)

            Text(L.t("MoveSafe is a source-first checklist tool. It links you to official resources and highlights topics to verify. It does not provide legal advice."))
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder private var howItWorks: some View {
        Card {
            Text(L.t("HOW IT WORKS"))
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(0.6)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 10) {
                step(1, L.t("Choose your origin and destination state."))
                step(2, L.t("Pick a purpose and the categories that apply."))
                step(3, L.t("Get a grouped checklist with risk badges and links to official sources."))
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
                Text(L.t("What MoveSafe does"))
                    .font(.headline)
                bullet(L.t("Generates a checklist of topics to verify before moving"))
                bullet(L.t("Links to official state agency sources"))
                bullet(L.t("Flags risk levels so you know where to focus"))
                bullet(L.t("Highlights stale or placeholder sources"))
                bullet(L.t("Treats high-risk categories with a \"Do not assume\" label"))
            }
            Card {
                Text(L.t("What MoveSafe does not do"))
                    .font(.headline)
                bullet(L.t("Provide legal advice or attorney-client services"))
                bullet(L.t("Determine whether a specific act is lawful"))
                bullet(L.t("Decide your residency, eligibility, or tax status"))
                bullet(L.t("Help avoid enforcement or recommend workarounds"))
                bullet(L.t("Replace official agency or licensed-professional guidance"))
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
            Text(L.t("Example checklist categories"))
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(exampleCategoryEnglishNames, id: \.self) { name in
                        Text(L.t(name))
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
