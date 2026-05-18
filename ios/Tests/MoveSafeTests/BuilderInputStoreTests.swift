import XCTest
@testable import MoveSafe

final class BuilderInputStoreTests: XCTestCase {
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        // Use a per-test ephemeral defaults suite so we don't touch real
        // UserDefaults and tests stay independent.
        let suite = "MoveSafeTests-\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suite)
        defaults.removePersistentDomain(forName: suite)
    }

    override func tearDown() {
        if let name = defaults?.dictionaryRepresentation().keys.first {
            // Cleanup is best-effort.
            _ = name
        }
        defaults = nil
        super.tearDown()
    }

    // MARK: - Defaults and snapshot

    func testFreshStoreHasEmptyDefaults() {
        let store = BuilderInputStore(defaults: defaults)
        XCTAssertEqual(store.originStateId, "")
        XCTAssertEqual(store.destinationStateId, "")
        XCTAssertEqual(store.purposeId, "")
        XCTAssertTrue(store.selectedCategoryIds.isEmpty)
        XCTAssertTrue(store.selectedProfileFlags.isEmpty)
        XCTAssertFalse(store.acceptedDisclaimer)
    }

    func testSnapshotMirrorsCurrentSelections() {
        let store = BuilderInputStore(defaults: defaults)
        store.originStateId = "state-california"
        store.destinationStateId = "state-texas"
        store.purposeId = "purpose-moving-for-work"
        store.selectedCategoryIds = ["cat-drivers-license", "cat-taxes"]
        store.selectedProfileFlags = [.hasCar, .visaHolder]

        let snap = store.snapshot()
        XCTAssertEqual(snap.originStateId, "state-california")
        XCTAssertEqual(snap.destinationStateId, "state-texas")
        XCTAssertEqual(snap.purposeId, "purpose-moving-for-work")
        XCTAssertEqual(Set(snap.selectedCategoryIds), ["cat-drivers-license", "cat-taxes"])
        XCTAssertEqual(Set(snap.selectedProfileFlags), [.hasCar, .visaHolder])
    }

    // MARK: - Validation

    func testValidationErrorsListsEveryMissingField() {
        let store = BuilderInputStore(defaults: defaults)
        let errs = store.validationErrors()
        XCTAssertEqual(errs.count, 5, "Expected one error per required field")
        XCTAssertTrue(errs.contains { $0.contains("origin") })
        XCTAssertTrue(errs.contains { $0.contains("destination") })
        XCTAssertTrue(errs.contains { $0.contains("purpose") })
        XCTAssertTrue(errs.contains { $0.contains("category") })
        XCTAssertTrue(errs.contains { $0.contains("disclaimer") })
    }

    func testValidationPassesWhenAllRequiredFieldsSet() {
        let store = BuilderInputStore(defaults: defaults)
        store.originStateId = "state-california"
        store.destinationStateId = "state-maryland"
        store.purposeId = "purpose-nursing-school"
        store.selectedCategoryIds = ["cat-drivers-license"]
        store.acceptedDisclaimer = true
        XCTAssertEqual(store.validationErrors(), [])
    }

    // MARK: - Reset

    func testResetClearsAllSelections() {
        let store = BuilderInputStore(defaults: defaults)
        store.originStateId = "state-california"
        store.destinationStateId = "state-texas"
        store.purposeId = "purpose-moving-for-work"
        store.selectedCategoryIds = ["cat-drivers-license"]
        store.selectedProfileFlags = [.dreamer]
        store.acceptedDisclaimer = true

        store.reset()

        XCTAssertEqual(store.originStateId, "")
        XCTAssertEqual(store.destinationStateId, "")
        XCTAssertEqual(store.purposeId, "")
        XCTAssertTrue(store.selectedCategoryIds.isEmpty)
        XCTAssertTrue(store.selectedProfileFlags.isEmpty)
        XCTAssertFalse(store.acceptedDisclaimer)
    }

    // MARK: - Example pre-fill

    func testLoadExamplePopulatesAllFieldsAndUsesValidIds() {
        let store = BuilderInputStore(defaults: defaults)
        store.loadExample()

        XCTAssertNotNil(States.byId[store.originStateId])
        XCTAssertNotNil(States.byId[store.destinationStateId])
        XCTAssertNotNil(Purposes.byId[store.purposeId])
        XCTAssertFalse(store.selectedCategoryIds.isEmpty)
        XCTAssertFalse(store.selectedProfileFlags.isEmpty)
        for catId in store.selectedCategoryIds {
            XCTAssertNotNil(Categories.byId[catId], "loadExample referenced unknown category: \(catId)")
        }
    }

    // MARK: - Persistence

    func testPersistenceRoundTrip() {
        let suite = "MoveSafeTests-roundtrip-\(UUID().uuidString)"
        let defaults1 = UserDefaults(suiteName: suite)!
        defaults1.removePersistentDomain(forName: suite)

        let store1 = BuilderInputStore(defaults: defaults1)
        store1.originStateId = "state-california"
        store1.destinationStateId = "state-maryland"
        store1.purposeId = "purpose-nursing-school"
        store1.selectedCategoryIds = ["cat-drivers-license", "cat-housing"]
        store1.selectedProfileFlags = [.visaHolder, .movingForSchool]
        store1.acceptedDisclaimer = true

        // Persistence is deferred to next runloop tick; spin briefly so it fires.
        let exp = expectation(description: "persist")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { exp.fulfill() }
        wait(for: [exp], timeout: 1.0)

        let store2 = BuilderInputStore(defaults: defaults1)
        XCTAssertEqual(store2.originStateId, "state-california")
        XCTAssertEqual(store2.destinationStateId, "state-maryland")
        XCTAssertEqual(store2.purposeId, "purpose-nursing-school")
        XCTAssertEqual(store2.selectedCategoryIds, ["cat-drivers-license", "cat-housing"])
        XCTAssertEqual(store2.selectedProfileFlags, [.visaHolder, .movingForSchool])
        XCTAssertTrue(store2.acceptedDisclaimer)

        defaults1.removePersistentDomain(forName: suite)
    }

    func testUnknownProfileFlagInPersistedDataIsSilentlyDropped() {
        let suite = "MoveSafeTests-flagdrop-\(UUID().uuidString)"
        let defaults1 = UserDefaults(suiteName: suite)!
        defaults1.removePersistentDomain(forName: suite)

        // Hand-craft a persisted blob that includes a flag that no longer
        // exists in the enum.
        struct Persisted: Codable {
            var originStateId: String
            var destinationStateId: String
            var purposeId: String
            var selectedCategoryIds: [String]
            var selectedProfileFlags: [String]
            var acceptedDisclaimer: Bool
        }
        let blob = Persisted(
            originStateId: "state-california",
            destinationStateId: "state-maryland",
            purposeId: "purpose-nursing-school",
            selectedCategoryIds: [],
            selectedProfileFlags: ["VISA_HOLDER", "RETIRED_OBSOLETE_FLAG"],
            acceptedDisclaimer: true
        )
        let data = try! JSONEncoder().encode(blob)
        defaults1.set(data, forKey: PersistenceKeys.builderSelections)

        let store = BuilderInputStore(defaults: defaults1)
        XCTAssertEqual(store.selectedProfileFlags, [.visaHolder])
        defaults1.removePersistentDomain(forName: suite)
    }
}
