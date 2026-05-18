import SwiftUI

struct BuilderView: View {
    @EnvironmentObject private var input: BuilderInputStore
    @Binding var path: [Route]
    @State private var submitted: Bool = false
    @State private var showDreamerAlert: Bool = false
    @State private var showGreenCardAlert: Bool = false
    @State private var showVisaAlert: Bool = false

    private var errors: [String] { input.validationErrors() }
    private var sameStateNotice: Bool {
        !input.originStateId.isEmpty &&
        !input.destinationStateId.isEmpty &&
        input.originStateId == input.destinationStateId
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(
                    eyebrow: L.t("Checklist builder"),
                    title: L.t("Build your relocation checklist"),
                    subtitle: L.t("Choose your origin and destination, your purpose, and the categories that apply. MoveSafe will generate a list of topics to verify before moving.")
                )

                DisclaimerBanner(variant: .short, tone: .subtle)

                statesAndPurposeCard
                categoriesCard
                profileFlagsCard
                disclaimerConfirmCard

                if submitted, !errors.isEmpty {
                    errorBox
                }

                submitButton
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(L.t("Build checklist"))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: input.selectedProfileFlags.contains(.dreamer)) { wasOn, isOn in
            if isOn && !wasOn {
                showDreamerAlert = true
            }
        }
        .onChange(of: input.selectedProfileFlags.contains(.greenCardHolder)) { wasOn, isOn in
            if isOn && !wasOn {
                showGreenCardAlert = true
            }
        }
        .onChange(of: input.selectedProfileFlags.contains(.visaHolder)) { wasOn, isOn in
            if isOn && !wasOn {
                showVisaAlert = true
            }
        }
        .alert(L.t("About Dreamer status"), isPresented: $showDreamerAlert) {
            Button(L.t("I understand")) { }
        } message: {
            Text(L.t("Immigration status - including Dreamer / DACA status - can significantly affect driver's licenses and REAL ID, professional licensure (especially nursing and healthcare), in-state tuition, SSN-related requirements, and state tax filing. Rules vary by state and federal law and change frequently.\n\nMoveSafe is not a substitute for legal counsel. Consider consulting a licensed immigration attorney before relying on any state-by-state summary."))
        }
        .alert(L.t("About green card holder status"), isPresented: $showGreenCardAlert) {
            Button(L.t("I understand")) { }
        } message: {
            Text(L.t("Lawful permanent residents (LPRs / green card holders) can face state-by-state variation in driver's license documents and REAL ID, professional licensure (especially nursing - foreign credentials evaluation may apply), Medicaid and state-marketplace eligibility (the federal 5-year bar interacts with state programs), state tax filing, and how DMVs handle voter-registration prompts (LPRs are not eligible to vote in federal or most state elections).\n\nMoveSafe is not a substitute for legal counsel. Consider consulting a licensed immigration attorney for status-affecting questions and a qualified tax professional for cross-state filing."))
        }
        .alert(L.t("About visa-holder status"), isPresented: $showVisaAlert) {
            Button(L.t("I understand")) { }
        } message: {
            Text(L.t("Nonimmigrant visa holders (F-1, H-1B, J-1, L-1, O-1, and others) face state-by-state variation in driver's license documents and REAL ID (often tied to I-94 / visa dates), in-state tuition (most public universities classify F-1 students as out-of-state), professional licensure documentation, tax residency rules, and health-insurance options. USCIS also requires reporting any address change within 10 days via Form AR-11.\n\nMoveSafe is not a substitute for legal counsel. Consider consulting a licensed immigration attorney, your school's DSO if on F-1, employer HR or immigration counsel if on a work visa, and a qualified tax professional for cross-state filing."))
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button(L.t("Load example")) {
                        input.loadExample()
                        submitted = false
                    }
                    Button(L.t("Reset all selections"), role: .destructive) {
                        input.reset()
                        submitted = false
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .accessibilityLabel(L.t("Builder options"))
            }
        }
    }

    @ViewBuilder private var statesAndPurposeCard: some View {
        Card {
            // Origin / destination.
            VStack(alignment: .leading, spacing: 12) {
                statePicker(label: L.t("Origin state"), selection: $input.originStateId)
                statePicker(label: L.t("Destination state"), selection: $input.destinationStateId)
            }

            if sameStateNotice {
                Text(L.t("MoveSafe is designed for state-to-state moves. You can still build a checklist, but some items may not apply."))
                    .font(.caption)
                    .foregroundStyle(.orange)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.yellow.opacity(0.10), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(Color.yellow.opacity(0.45), lineWidth: 1)
                    )
            }

            purposePicker
        }
    }

    private func statePicker(label: String, selection: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(label).font(.subheadline).fontWeight(.medium)
                Text("*").foregroundStyle(.red)
            }
            Menu {
                Picker(label, selection: selection) {
                    Text(L.t("Select a state…")).tag("")
                    ForEach(States.all) { state in
                        Text(state.name).tag(state.id)
                    }
                }
            } label: {
                HStack {
                    Text(displayName(for: selection.wrappedValue) ?? L.t("Select a state…"))
                        .foregroundStyle(selection.wrappedValue.isEmpty ? Color.secondary : Color.primary)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color(.separator), lineWidth: 1)
                )
            }
        }
    }

    private func displayName(for stateId: String) -> String? {
        // State names are intentionally NOT translated - proper nouns.
        States.byId[stateId]?.name
    }

    @ViewBuilder private var purposePicker: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(L.t("Purpose")).font(.subheadline).fontWeight(.medium)
                Text("*").foregroundStyle(.red)
            }
            Menu {
                Picker(L.t("Purpose"), selection: $input.purposeId) {
                    Text(L.t("Select a purpose…")).tag("")
                    ForEach(Purposes.all) { purpose in
                        Text(L.t(purpose.name)).tag(purpose.id)
                    }
                }
            } label: {
                HStack {
                    Text(Purposes.byId[input.purposeId].map { L.t($0.name) } ?? L.t("Select a purpose…"))
                        .foregroundStyle(input.purposeId.isEmpty ? Color.secondary : Color.primary)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color(.separator), lineWidth: 1)
                )
            }
            if let desc = Purposes.byId[input.purposeId]?.description {
                Text(L.t(desc))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 2)
            }
        }
    }

    @ViewBuilder private var categoriesCard: some View {
        Card {
            VStack(alignment: .leading, spacing: 6) {
                Text(L.t("Categories")).font(.subheadline).fontWeight(.medium)
                Text(L.t("Select one or more. You can change these later."))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 8) {
                ForEach(Categories.all) { cat in
                    categoryRow(cat)
                }
            }
        }
    }

    private func categoryRow(_ cat: Category) -> some View {
        let checked = input.selectedCategoryIds.contains(cat.id)
        return Button {
            if checked {
                input.selectedCategoryIds.remove(cat.id)
            } else {
                input.selectedCategoryIds.insert(cat.id)
            }
        } label: {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundStyle(checked ? Color.accentColor : Color.secondary)
                    .imageScale(.medium)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(L.t(cat.name))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                        if cat.isHighRiskCategory {
                            Text(L.t("Do not assume"))
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red.opacity(0.12), in: Capsule())
                                .overlay(Capsule().strokeBorder(Color.red.opacity(0.35), lineWidth: 1))
                                .foregroundStyle(.red)
                        }
                    }
                    Text(L.t(cat.description))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                Spacer(minLength: 0)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                checked ? Color.accentColor.opacity(0.08) : Color(.systemBackground),
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(checked ? Color.accentColor.opacity(0.45) : Color(.separator), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(checked ? [.isSelected] : [])
    }

    @ViewBuilder private var profileFlagsCard: some View {
        Card {
            VStack(alignment: .leading, spacing: 6) {
                Text(L.t("Optional profile")).font(.subheadline).fontWeight(.medium)
                Text(L.t("Helps tailor the checklist. None of these flags create legal conclusions."))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 6) {
                ForEach(ProfileFlag.displayOrder) { flag in
                    profileFlagRow(flag)
                }
            }
        }
    }

    private func profileFlagRow(_ flag: ProfileFlag) -> some View {
        let checked = input.selectedProfileFlags.contains(flag)
        return Button {
            if checked {
                input.selectedProfileFlags.remove(flag)
            } else {
                input.selectedProfileFlags.insert(flag)
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundStyle(checked ? Color.accentColor : Color.secondary)
                    .imageScale(.medium)
                Text(L.t(flag.label))
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                checked ? Color.accentColor.opacity(0.08) : Color(.systemBackground),
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(checked ? Color.accentColor.opacity(0.45) : Color(.separator), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(checked ? [.isSelected] : [])
    }

    @ViewBuilder private var disclaimerConfirmCard: some View {
        Card {
            Toggle(isOn: $input.acceptedDisclaimer) {
                Text(L.t("I understand that MoveSafe provides general information and source links, not legal advice."))
                    .font(.subheadline)
            }
            .toggleStyle(.switch)
        }
    }

    @ViewBuilder private var errorBox: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(L.t("Please fix the following:"))
                .font(.subheadline)
                .fontWeight(.semibold)
            VStack(alignment: .leading, spacing: 2) {
                ForEach(errors, id: \.self) { msg in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                        Text(L.t(msg))
                    }
                    .font(.caption)
                }
            }
        }
        .foregroundStyle(.red)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color.red.opacity(0.30), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }

    @ViewBuilder private var submitButton: some View {
        VStack(alignment: .leading, spacing: 6) {
            Button {
                submitted = true
                guard errors.isEmpty else { return }
                path.append(.results)
            } label: {
                Text(L.t("Generate checklist"))
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)

            Text(L.t("Your selections aren't saved or shared. The checklist is generated locally."))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
