import Foundation

/// Runtime translation lookup. The English string is the canonical key; the
/// Spanish translation lives in the static tables in `TranslationsData_*.swift`.
///
/// Call `L.t("English text")` from any View, badge, banner, or export to get
/// the language-correct rendering. The lookup is keyed by exact English text,
/// so seed-data fields (item titles, source titles, etc.) can be translated
/// without changing the seed data itself - the table just needs an entry
/// whose key matches the seed-data English exactly.
///
/// Falls back to the English input when:
///   - The current effective language is English.
///   - No translation exists in the table.
///   - The String is empty.
enum L {
    /// Reads the current effective language from the shared LocaleStore.
    /// Set up at app launch in `MoveSafeApp.swift`.
    static var currentLanguage: AppLanguage = .english

    /// Translate an English literal or variable-string value to the current
    /// effective language. Pass the canonical English text as-is.
    static func t(_ english: String) -> String {
        guard !english.isEmpty else { return english }
        switch currentLanguage {
        case .english:
            return english
        case .spanish:
            return spanish[english] ?? english
        }
    }

    /// Like `t(_:)` but for the share-sheet plain-text export which needs to
    /// honor the explicit language at the time the share was tapped.
    static func t(_ english: String, in lang: AppLanguage) -> String {
        guard !english.isEmpty else { return english }
        switch lang {
        case .english: return english
        case .spanish: return spanish[english] ?? english
        }
    }

    /// Combined Spanish dictionary, built from the per-domain tables.
    static let spanish: [String: String] = {
        var merged: [String: String] = [:]
        merged.merge(TranslationsData.uiSpanish) { _, new in new }
        merged.merge(TranslationsData.enumsSpanish) { _, new in new }
        merged.merge(TranslationsData.metaSpanish) { _, new in new }
        merged.merge(TranslationsData.itemsSpanish) { _, new in new }
        merged.merge(TranslationsData.sourcesSpanish) { _, new in new }
        return merged
    }()
}

/// Namespace for per-domain translation tables. Split across files so the
/// 700+ seed-data strings can be maintained alongside the smaller UI tables
/// without one massive file.
enum TranslationsData {
    // Populated in TranslationsData_UI.swift, TranslationsData_Enums.swift, etc.
    static var uiSpanish: [String: String] { UITranslations.spanish }
    static var enumsSpanish: [String: String] { EnumTranslations.spanish }
    static var metaSpanish: [String: String] { MetaTranslations.spanish }
    static var itemsSpanish: [String: String] { ItemTranslations.spanish }
    static var sourcesSpanish: [String: String] { SourceTranslations.spanish }
}
