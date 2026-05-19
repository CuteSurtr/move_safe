import Foundation

/// Min Nan / Hokkien / Taiwanese (闽南语 / 台语 / 福建话) translation table,
/// written in Simplified Chinese characters with Min Nan-specific vocabulary
/// and grammar where natural (e.g., 阮 for "we" inclusive, 汝 for "you",
/// 个 / 的 for possessive, 无 for "not", 是 for "to be").
///
/// Min Nan covers Hokkien (spoken in Fujian, Taiwan, much of overseas Chinese
/// in Southeast Asia and the US) and related variants. For formal compliance
/// / legal / agency content, falls back to Standard Written Chinese phrasing
/// - Min Nan has no established written legal register distinct from
/// Mandarin in mainland contexts (though Taiwanese-Hokkien written forms
/// exist for literature and pop culture).
///
/// US state names and US-agency abbreviations stay in English by design.
enum MinNanTranslations {
    static let translations: [String: String] = [:]
}
