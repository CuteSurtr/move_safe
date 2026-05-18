import Combine
import Foundation
import SwiftUI

/// Two-letter language code the app is currently presenting in.
/// Limited to the actively-translated set.
enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english = "en"
    case spanish = "es"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Español"
        }
    }
}

/// User's chosen language preference. Stored as an explicit override or `nil`
/// to mean "follow device locale."
enum LanguagePreference: Hashable, Codable {
    case system
    case override(AppLanguage)

    var override: AppLanguage? {
        if case .override(let lang) = self { return lang }
        return nil
    }
}

/// View-model that owns the in-app language choice, persisted to UserDefaults.
/// `effectiveLanguage` reflects the current rendered language - the user's
/// override if set, otherwise whichever supported language best matches the
/// device locale (falling back to English).
final class LocaleStore: ObservableObject {
    @Published var preference: LanguagePreference {
        didSet { persist() }
    }

    private let defaults: UserDefaults
    private static let key = "moveSafe.languagePreference.v1"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let data = defaults.data(forKey: Self.key),
           let p = try? JSONDecoder().decode(LanguagePreference.self, from: data) {
            self.preference = p
        } else {
            self.preference = .system
        }
    }

    /// The language the UI should actually render in right now.
    var effectiveLanguage: AppLanguage {
        if let override = preference.override { return override }
        return Self.languageForDevice()
    }

    /// What "follow system" would resolve to right now. Surfaced in the
    /// Settings UI so the user knows what auto-detect picked.
    var systemDetectedLanguage: AppLanguage {
        Self.languageForDevice()
    }

    private static func languageForDevice() -> AppLanguage {
        let code = Locale.current.language.languageCode?.identifier.lowercased() ?? "en"
        return AppLanguage(rawValue: code) ?? .english
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(preference) {
            defaults.set(data, forKey: Self.key)
        }
    }
}

// MARK: - SwiftUI Environment plumbing

private struct AppLanguageKey: EnvironmentKey {
    static let defaultValue: AppLanguage = .english
}

extension EnvironmentValues {
    /// Current effective UI language. Reads through `LocaleStore` via the
    /// `.localizedFor(_:)` modifier - View code can read it directly to make
    /// language-conditional formatting decisions when needed.
    var appLanguage: AppLanguage {
        get { self[AppLanguageKey.self] }
        set { self[AppLanguageKey.self] = newValue }
    }
}

extension View {
    /// Convenience modifier the root view applies so descendant views can read
    /// the current language from the environment.
    func localizedFor(_ language: AppLanguage) -> some View {
        environment(\.appLanguage, language)
    }
}
