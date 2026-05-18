import Foundation

// Safe-copy rules for MoveSafe.
//
// MoveSafe is a source-first checklist and risk-awareness tool. It does not
// give legal advice and does not draw legal conclusions about specific
// situations.
//
// Allowed phrases:
//   - "Verify", "Check", "Review official sources"
//   - "May vary", "May apply", "Can depend on"
//   - "Rules differ by jurisdiction"
//   - "This checklist is not a legal conclusion"
//   - "Consult a licensed attorney", "Consult the relevant agency"
//   - "Do not assume"
//
// Avoid in checklist or results copy:
//   - "Legal", "illegal", "allowed", "permitted", "prohibited"
//   - "Safe", "guaranteed"
//   - "You can" / "You cannot"
//   - "You should do X to avoid penalties"
//
// The word "legal information" is acceptable inside disclaimers, but
// checklist-item text should avoid sounding like a legal conclusion.
enum SafeCopy {
    static let allowedPhrases: [String] = [
        "verify",
        "check",
        "review official sources",
        "may vary",
        "may apply",
        "can depend on",
        "rules differ by jurisdiction",
        "this checklist is not a legal conclusion",
        "consult a licensed attorney",
        "consult the relevant agency",
        "do not assume"
    ]

    static let avoidPhrases: [String] = [
        "legal",
        "illegal",
        "allowed",
        "permitted",
        "prohibited",
        "safe",
        "guaranteed",
        "you can",
        "you cannot",
        "avoid penalties"
    ]

    /// Lightweight dev helper. Returns avoidPhrases present in given text.
    /// Not enforced at runtime — intended as a manual review aid during seeding.
    static func findUnsafePhrases(in text: String) -> [String] {
        let lower = text.lowercased()
        return avoidPhrases.filter { lower.contains($0) }
    }
}

enum Disclaimers {
    static let main: String = "MoveSafe provides general legal and administrative information based on publicly available sources. It does not provide legal advice, does not create an attorney-client relationship, and should not be used as a substitute for advice from a licensed attorney in your jurisdiction. Laws and agency rules change frequently. Always verify information with official sources before making decisions."

    static let short: String = "General information only. Not legal advice. Verify with official sources."

    static let resultsIntro: String = "Based on your selected states and purpose, here are topics to verify before moving. This checklist is not a legal conclusion."

    static let coverageCaveat: String = "This checklist is based on your selected categories and available source data. It may not include every requirement that applies to your situation."
}
