import Foundation

// Staleness buckets (mirrors src/lib/utils/sourceStatus.ts):
//   - No lastChecked:  MISSING
//   - Status PLACEHOLDER: PLACEHOLDER
//   - 0-90 days:       CURRENT
//   - 91-180 days:     REVIEW_RECOMMENDED
//   - 181-365 days:    POSSIBLY_OUTDATED
//   - 365+ days:       STALE
enum SourceStatusEngine {
    static func compute(for source: Source, reference: Date = Date()) -> SourceStatus {
        if source.status == .placeholder { return .placeholder }
        if source.status == .missing { return .missing }

        guard let date = DateUtils.parse(source.lastChecked) else { return .missing }
        let days = DateUtils.daysSince(date, reference: reference)
        if days <= 90 { return .current }
        if days <= 180 { return .reviewRecommended }
        if days <= 365 { return .possiblyOutdated }
        return .stale
    }
}
