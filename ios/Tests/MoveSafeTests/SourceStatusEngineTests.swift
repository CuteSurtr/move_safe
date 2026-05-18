import XCTest
@testable import MoveSafe

final class SourceStatusEngineTests: XCTestCase {
    // Reference date used as "today" so the buckets are deterministic.
    private let reference: Date = {
        var c = DateComponents()
        c.year = 2026; c.month = 5; c.day = 18
        c.timeZone = TimeZone(identifier: "UTC")
        return Calendar(identifier: .gregorian).date(from: c)!
    }()

    private func source(
        id: String = "test-source",
        status: SourceStatus = .current,
        lastChecked: String? = nil
    ) -> Source {
        Source(
            id: id,
            title: "Test",
            url: "https://example.gov",
            sourceType: .officialFederalAgency,
            jurisdictionType: .federalLaw,
            lastChecked: lastChecked,
            status: status,
            isOfficial: true
        )
    }

    func testPlaceholderShortCircuits() {
        let s = source(status: .placeholder, lastChecked: "2026-05-17")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .placeholder)
    }

    func testMissingShortCircuits() {
        let s = source(status: .missing, lastChecked: "2026-05-17")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .missing)
    }

    func testNoLastCheckedFallsBackToMissing() {
        let s = source(status: .current, lastChecked: nil)
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .missing)
    }

    func testCurrentBucketAt0Days() {
        // Same day as reference.
        let s = source(lastChecked: "2026-05-18")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .current)
    }

    func testCurrentBucketAt90Days() {
        // Exactly 90 days before reference -> still CURRENT (boundary).
        let s = source(lastChecked: "2026-02-17")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .current)
    }

    func testReviewRecommendedAt91Days() {
        // 91 days before reference -> REVIEW_RECOMMENDED.
        let s = source(lastChecked: "2026-02-16")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .reviewRecommended)
    }

    func testReviewRecommendedAt180Days() {
        // 180 days before reference -> still REVIEW_RECOMMENDED (upper boundary).
        let s = source(lastChecked: "2025-11-19")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .reviewRecommended)
    }

    func testPossiblyOutdatedAt181Days() {
        let s = source(lastChecked: "2025-11-18")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .possiblyOutdated)
    }

    func testPossiblyOutdatedAt365Days() {
        // Exactly 365 days before reference -> POSSIBLY_OUTDATED (upper boundary).
        let s = source(lastChecked: "2025-05-18")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .possiblyOutdated)
    }

    func testStaleAt366Days() {
        let s = source(lastChecked: "2025-05-17")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .stale)
    }

    func testStaleMuchOlder() {
        let s = source(lastChecked: "2020-01-01")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .stale)
    }

    func testISO8601LastCheckedParses() {
        let s = source(lastChecked: "2026-05-18T12:00:00Z")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .current)
    }

    func testGarbageLastCheckedFallsBackToMissing() {
        let s = source(lastChecked: "not-a-date")
        XCTAssertEqual(SourceStatusEngine.compute(for: s, reference: reference), .missing)
    }
}
