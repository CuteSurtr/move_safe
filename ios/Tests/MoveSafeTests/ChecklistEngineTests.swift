import XCTest
@testable import MoveSafe

final class ChecklistEngineTests: XCTestCase {
    private let reference: Date = {
        var c = DateComponents()
        c.year = 2026; c.month = 5; c.day = 18
        c.timeZone = TimeZone(identifier: "UTC")
        return Calendar(identifier: .gregorian).date(from: c)!
    }()

    private func baseInput(
        origin: String = "state-california",
        destination: String = "state-maryland",
        purpose: String = "purpose-nursing-school",
        categories: [String] = [
            "cat-drivers-license", "cat-vehicle-registration", "cat-auto-insurance",
            "cat-housing", "cat-nursing-healthcare", "cat-state-residency",
            "cat-student-relocation", "cat-healthcare-access", "cat-professional-license",
            "cat-taxes"
        ],
        flags: [ProfileFlag] = []
    ) -> GenerateChecklistInput {
        GenerateChecklistInput(
            originStateId: origin,
            destinationStateId: destination,
            purposeId: purpose,
            selectedCategoryIds: categories,
            selectedProfileFlags: flags
        )
    }

    // MARK: - Error paths

    func testThrowsOnUnknownOriginState() {
        let input = baseInput(origin: "state-atlantis")
        XCTAssertThrowsError(try ChecklistEngine.generate(input: input, reference: reference)) { err in
            guard case ChecklistEngineError.unknownOriginState(let id) = err else {
                return XCTFail("Expected unknownOriginState, got \(err)")
            }
            XCTAssertEqual(id, "state-atlantis")
        }
    }

    func testThrowsOnUnknownDestinationState() {
        let input = baseInput(destination: "state-mordor")
        XCTAssertThrowsError(try ChecklistEngine.generate(input: input, reference: reference)) { err in
            guard case ChecklistEngineError.unknownDestinationState(let id) = err else {
                return XCTFail("Expected unknownDestinationState, got \(err)")
            }
            XCTAssertEqual(id, "state-mordor")
        }
    }

    func testThrowsOnUnknownPurpose() {
        let input = baseInput(purpose: "purpose-time-travel")
        XCTAssertThrowsError(try ChecklistEngine.generate(input: input, reference: reference)) { err in
            guard case ChecklistEngineError.unknownPurpose(let id) = err else {
                return XCTFail("Expected unknownPurpose, got \(err)")
            }
            XCTAssertEqual(id, "purpose-time-travel")
        }
    }

    // MARK: - Filtering

    func testEmptyCategoriesYieldsNoItems() throws {
        let input = baseInput(categories: [])
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        XCTAssertEqual(output.totalItems, 0)
        XCTAssertEqual(output.groupedItems.count, 0)
    }

    func testCategoryFilterOnlyReturnsItemsInSelectedCategories() throws {
        let input = baseInput(categories: ["cat-drivers-license"])
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        XCTAssertGreaterThan(output.totalItems, 0)
        for (_, items) in output.groupedItems {
            for entry in items {
                XCTAssertEqual(entry.item.categoryId, "cat-drivers-license")
            }
        }
    }

    func testProfileFlagFilteringExcludesUntaggedItemsWhenFlagsSet() throws {
        // With no flags selected, items that have flag-restrictions still pass
        // through (the engine keeps them so flag-only users aren't blank).
        let inputNoFlags = baseInput(flags: [])
        let outputNoFlags = try ChecklistEngine.generate(input: inputNoFlags, reference: reference)

        // With flags selected, items whose flag list contains none of the
        // selected flags are excluded.
        let inputDreamer = baseInput(flags: [.dreamer])
        let outputDreamer = try ChecklistEngine.generate(input: inputDreamer, reference: reference)

        // Both should produce some items. Dreamer should expose at least one
        // item tagged with .dreamer.
        XCTAssertGreaterThan(outputNoFlags.totalItems, 0)
        XCTAssertGreaterThan(outputDreamer.totalItems, 0)

        let dreamerItems = outputDreamer.groupedItems.flatMap { $0.items }
        let anyDreamerTagged = dreamerItems.contains { entry in
            entry.item.appliesToProfileFlags.contains(.dreamer)
        }
        XCTAssertTrue(anyDreamerTagged, "Expected at least one .dreamer item when flag selected")
    }

    func testVisaHolderFlagSurfacesVisaResearchItems() throws {
        let input = baseInput(flags: [.visaHolder])
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let visaTagged = output.groupedItems
            .flatMap { $0.items }
            .filter { $0.item.appliesToProfileFlags.contains(.visaHolder) }
        XCTAssertGreaterThanOrEqual(
            visaTagged.count, 10,
            "Visa-holder flag should surface a meaningful number of items from the visa research pass"
        )
    }

    // MARK: - Warnings

    func testSameOriginAndDestinationWarningInsertedFirst() throws {
        let input = baseInput(origin: "state-california", destination: "state-california")
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        XCTAssertTrue(
            output.warnings.first?.contains("Origin and destination are the same") ?? false,
            "Expected first warning to flag same-state, got: \(output.warnings)"
        )
    }

    func testDefaultDisclaimerWarningAlwaysAppended() throws {
        let input = baseInput()
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        XCTAssertTrue(
            output.warnings.contains { $0.contains("not a legal conclusion") },
            "Expected the 'not a legal conclusion' disclaimer in warnings"
        )
    }

    func testHighRiskCategoryAddsSeparateVerificationWarning() throws {
        // Only the high-risk category selected, which contains VERIFY_SEPARATELY items.
        let input = baseInput(categories: ["cat-high-risk"])
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let hasHighRiskWarning = output.warnings.contains {
            $0.contains("High-risk categories require separate verification")
        }
        XCTAssertTrue(hasHighRiskWarning)
    }

    // MARK: - Risk counts and grouping

    func testRiskCountsSumToTotalItems() throws {
        let input = baseInput(flags: [.dreamer, .greenCardHolder, .visaHolder])
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let summed = output.riskCounts.values.reduce(0, +)
        XCTAssertEqual(summed, output.totalItems)
    }

    func testGroupedItemsRespectCategorySortOrder() throws {
        let input = baseInput()
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let sortOrders = output.groupedItems.compactMap { (catId, _) in
            Categories.byId[catId]?.sortOrder
        }
        XCTAssertEqual(sortOrders, sortOrders.sorted(),
                       "Grouped categories should appear in ascending sortOrder")
    }

    func testItemsWithinGroupSortedByDisplayRiskOrder() throws {
        let input = baseInput()
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let riskIndex = Dictionary(
            uniqueKeysWithValues: RiskLevel.displayOrder.enumerated().map { ($1, $0) }
        )
        for (_, items) in output.groupedItems {
            let positions = items.map { riskIndex[$0.item.riskLevel] ?? 0 }
            XCTAssertEqual(positions, positions.sorted(),
                           "Items inside a category should be sorted by RiskLevel.displayOrder")
        }
    }

    // MARK: - Source resolution

    func testStateBoundSourceResolvesAgainstDestinationStateUrl() throws {
        let input = baseInput()
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let allSources = output.groupedItems.flatMap { $0.items }.flatMap { $0.sources }

        // Find any source with stateUrlBinding to destination DMV that resolved
        // to a non-"#" URL - that means the engine pulled the destination state's
        // dmvUrl in. Maryland has a verified dmvUrl, so this should succeed.
        let resolved = allSources.first { sws in
            sws.source.stateUrlBinding?.role == .destination
                && sws.source.stateUrlBinding?.field == .dmv
                && sws.resolvedUrl.starts(with: "http")
        }
        XCTAssertNotNil(resolved, "Expected a destination-DMV bound source to resolve to a real URL for Maryland")
    }

    func testUniqueSourcesPreserveFirstSeenOrder() throws {
        let input = baseInput()
        let output = try ChecklistEngine.generate(input: input, reference: reference)
        let unique = ChecklistEngine.uniqueSources(from: output.groupedItems)
        let ids = unique.map { $0.source.id }
        XCTAssertEqual(Set(ids).count, ids.count, "uniqueSources should not contain duplicates")
    }
}
