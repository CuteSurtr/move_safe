import Foundation

/// Hakka (客家话) translation table, written in Simplified Chinese characters
/// with Hakka-specific vocabulary and grammar where natural (e.g., 𠊎 for
/// "I", 佢 for "he/she", 唔 for "not", 个 as a possessive/topical marker).
///
/// For formal compliance / legal / agency content, falls back to Standard
/// Written Chinese phrasing - Hakka has no established written legal
/// register distinct from Mandarin.
///
/// US state names and US-agency abbreviations stay in English by design.
enum HakkaTranslations {
    static let translations: [String: String] = [:]
}
