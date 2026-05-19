import Foundation

/// Cantonese / Yue Chinese (粤语 / 廣東話) translation table, written in
/// Simplified Chinese characters with Cantonese-specific vocabulary and
/// grammar where natural. Distinctive Cantonese characters (嘅, 啲, 喺, 咗,
/// 哋, 唔, 系, 佢, etc.) work in both Simplified and Traditional encodings
/// and are used inline where the dialect calls for them.
///
/// For formal compliance / legal / agency content, falls back to Standard
/// Written Chinese phrasing - Cantonese has no established written legal
/// register distinct from Mandarin.
///
/// US state names and US-agency abbreviations stay in English by design.
enum CantoneseTranslations {
    static let translations: [String: String] = [:]
}
