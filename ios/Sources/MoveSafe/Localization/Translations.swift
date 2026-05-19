import Foundation

/// Runtime translation lookup. The English string is the canonical key; the
/// non-English translation lives in the static tables in
/// `TranslationsData_*.swift`.
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
        t(english, in: currentLanguage)
    }

    /// Like `t(_:)` but for the share-sheet plain-text export which needs to
    /// honor the explicit language at the time the share was tapped.
    static func t(_ english: String, in lang: AppLanguage) -> String {
        guard !english.isEmpty else { return english }
        let table = dictionary(for: lang)
        return table?[english] ?? english
    }

    /// The full lookup dictionary for a given language, or nil for English.
    private static func dictionary(for lang: AppLanguage) -> [String: String]? {
        switch lang {
        case .english: return nil
        case .spanish: return TranslationsData.spanish
        case .korean: return TranslationsData.korean
        case .japanese: return TranslationsData.japanese
        case .simplifiedChinese: return TranslationsData.simplifiedChinese
        case .traditionalChinese: return TranslationsData.traditionalChinese
        case .wuChinese: return TranslationsData.wuChinese
        case .cantonese: return TranslationsData.cantonese
        case .hakka: return TranslationsData.hakka
        case .minNan: return TranslationsData.minNan
        case .xiang: return TranslationsData.xiang
        case .tagalog: return TranslationsData.tagalog
        case .vietnamese: return TranslationsData.vietnamese
        case .french: return TranslationsData.french
        case .russian: return TranslationsData.russian
        case .portuguese: return TranslationsData.portuguese
        case .german: return TranslationsData.german
        case .afrikaans: return TranslationsData.afrikaans
        case .somali: return TranslationsData.somali
        case .farsi: return TranslationsData.farsi
        }
    }
}

/// Namespace for per-language translation tables. Spanish is split across
/// per-domain files (historical reason: it was the first localization pass
/// and the translation was done in chunks). Languages added later are kept
/// in a single consolidated file each.
enum TranslationsData {
    // Spanish: merged from per-domain tables (TranslationsData_UI / Enums /
    // Meta / Items / Sources). Each table targets `static var <name>Spanish`
    // for backward compatibility with the original Spanish-only design.
    static let spanish: [String: String] = {
        var merged: [String: String] = [:]
        merged.merge(UITranslations.spanish) { _, new in new }
        merged.merge(EnumTranslations.spanish) { _, new in new }
        merged.merge(MetaTranslations.spanish) { _, new in new }
        merged.merge(ItemTranslations.spanish) { _, new in new }
        merged.merge(SourceTranslations.spanish) { _, new in new }
        return merged
    }()

    // Languages added in the second pass live in single consolidated files.
    static let korean: [String: String] = KoreanTranslations.translations
    static let japanese: [String: String] = JapaneseTranslations.translations
    static let simplifiedChinese: [String: String] = SimplifiedChineseTranslations.translations
    static let traditionalChinese: [String: String] = TraditionalChineseTranslations.translations
    static let wuChinese: [String: String] = WuChineseTranslations.translations
    static let cantonese: [String: String] = CantoneseTranslations.translations
    static let hakka: [String: String] = HakkaTranslations.translations
    static let minNan: [String: String] = MinNanTranslations.translations
    static let xiang: [String: String] = XiangTranslations.translations

    static let tagalog: [String: String] = OtherTranslations.tagalog
    static let vietnamese: [String: String] = OtherTranslations.vietnamese
    static let french: [String: String] = OtherTranslations.french
    static let russian: [String: String] = OtherTranslations.russian
    static let portuguese: [String: String] = OtherTranslations.portuguese
    static let german: [String: String] = OtherTranslations.german
    static let afrikaans: [String: String] = OtherTranslations.afrikaans
    static let somali: [String: String] = OtherTranslations.somali
    static let farsi: [String: String] = OtherTranslations.farsi
}
