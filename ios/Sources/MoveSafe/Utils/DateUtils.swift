import Foundation

enum DateUtils {
    /// ISO date parser used for seed lastChecked strings. Accepts "yyyy-MM-dd"
    /// and full ISO-8601 timestamps so the same data shape as the web works.
    static func parse(_ input: String?) -> Date? {
        guard let input, !input.isEmpty else { return nil }

        // Try yyyy-MM-dd (UTC) first.
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "en_US_POSIX")
        dayFormatter.timeZone = TimeZone(identifier: "UTC")
        dayFormatter.dateFormat = "yyyy-MM-dd"
        if let d = dayFormatter.date(from: input) {
            return d
        }

        // Fall back to ISO-8601 with fractional seconds.
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let d = iso.date(from: input) { return d }
        let iso2 = ISO8601DateFormatter()
        iso2.formatOptions = [.withInternetDateTime]
        return iso2.date(from: input)
    }

    static func daysSince(_ date: Date, reference: Date = Date()) -> Int {
        let interval = reference.timeIntervalSince(date)
        return Int(floor(interval / 86_400))
    }

    /// Human-friendly date string (e.g. "Apr 20, 2026"). Returns em-dash when nil.
    static func format(_ input: String?) -> String {
        guard let date = parse(input) else { return "-" }
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}
