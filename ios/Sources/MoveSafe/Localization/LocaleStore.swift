import Combine
import Foundation
import SwiftUI

/// Language tag the app is currently presenting in. Tags follow BCP 47:
/// `en`, `es`, `ko`, `ja`, `zh-Hans` (Simplified), `zh-Hant` (Traditional),
/// `wuu` (Wu Chinese), plus a handful of other US-immigrant-population
/// languages. Wu has no native iOS locale, so device auto-detect rarely
/// picks it; users select it explicitly from Settings.
enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english = "en"
    case spanish = "es"
    case korean = "ko"
    case japanese = "ja"
    case simplifiedChinese = "zh-Hans"
    case traditionalChinese = "zh-Hant"
    case wuChinese = "wuu"
    case cantonese = "yue"
    case hakka = "hak"
    case minNan = "nan"
    case xiang = "hsn"
    case tagalog = "tl"
    case vietnamese = "vi"
    case french = "fr"
    case russian = "ru"
    case portuguese = "pt"
    case german = "de"
    case afrikaans = "af"
    case somali = "so"
    case farsi = "fa"

    var id: String { rawValue }

    /// Name shown in the language picker, written in that language.
    var displayName: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Español"
        case .korean: return "한국어"
        case .japanese: return "日本語"
        case .simplifiedChinese: return "简体中文"
        case .traditionalChinese: return "繁體中文"
        case .wuChinese: return "吴语"
        case .cantonese: return "粤语"
        case .hakka: return "客家话"
        case .minNan: return "闽南语"
        case .xiang: return "湘语"
        case .tagalog: return "Tagalog"
        case .vietnamese: return "Tiếng Việt"
        case .french: return "Français"
        case .russian: return "Русский"
        case .portuguese: return "Português"
        case .german: return "Deutsch"
        case .afrikaans: return "Afrikaans"
        case .somali: return "Soomaali"
        case .farsi: return "فارسی"
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
        let lang = Locale.current.language
        let code = lang.languageCode?.identifier.lowercased() ?? "en"
        // Chinese needs the script suffix (Hans vs Hant) to disambiguate.
        // Apple's Locale exposes that via `script` on the language struct.
        if code == "zh" {
            let script = lang.script?.identifier.lowercased() ?? ""
            switch script {
            case "hant": return .traditionalChinese
            case "hans": return .simplifiedChinese
            default:
                // Fall back to region: TW / HK / MO → Traditional, otherwise Simplified.
                let region = Locale.current.region?.identifier.uppercased() ?? ""
                if ["TW", "HK", "MO"].contains(region) {
                    return .traditionalChinese
                }
                return .simplifiedChinese
            }
        }
        // Wu, Cantonese, Hakka, Min Nan, and Xiang have their own BCP 47 codes
        // but iOS device locale rarely surfaces them - users opt in via the
        // in-app picker.
        if code == "wuu" { return .wuChinese }
        if code == "yue" { return .cantonese }
        if code == "hak" { return .hakka }
        if code == "nan" { return .minNan }
        if code == "hsn" { return .xiang }
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
