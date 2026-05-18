import SwiftUI

/// Sheet for app-level preferences. Currently exposes language selection
/// (system / English / Español) and version info.
struct SettingsView: View {
    @EnvironmentObject private var localeStore: LocaleStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(L.t("Language")) {
                    Picker(L.t("Language"), selection: pickerBinding) {
                        Text(
                            String(
                                format: L.t("Auto-detected: %@"),
                                localeStore.systemDetectedLanguage.displayName
                            )
                        )
                        .tag(LanguagePreference.system)

                        ForEach(AppLanguage.allCases) { lang in
                            Text(lang.displayName)
                                .tag(LanguagePreference.override(lang))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }

                Section(L.t("About")) {
                    LabeledContent(L.t("Version"), value: appVersion)
                }
            }
            .navigationTitle(L.t("Settings"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(L.t("Done")) { dismiss() }
                }
            }
        }
    }

    private var pickerBinding: Binding<LanguagePreference> {
        Binding(
            get: { localeStore.preference },
            set: { localeStore.preference = $0 }
        )
    }

    private var appVersion: String {
        let bundle = Bundle.main
        let v = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let b = bundle.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "\(v) (\(b))"
    }
}
