import Combine
import Foundation
import SwiftUI

/// View-model that holds the in-progress builder selections. Owned by the
/// root, observed by Builder and read by Results. Persists to UserDefaults so
/// selections survive app relaunch.
final class BuilderInputStore: ObservableObject {
    @Published var originStateId: String = ""
    @Published var destinationStateId: String = ""
    @Published var purposeId: String = ""
    @Published var selectedCategoryIds: Set<String> = []
    @Published var selectedProfileFlags: Set<ProfileFlag> = []
    @Published var acceptedDisclaimer: Bool = false

    private let defaults: UserDefaults
    private var cancellables: Set<AnyCancellable> = []
    private var isLoading = false

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
        // Persist on any published change. objectWillChange fires before the
        // mutation commits, so defer to the next tick to capture the new value.
        objectWillChange
            .sink { [weak self] _ in
                guard let self, !self.isLoading else { return }
                DispatchQueue.main.async { self.persist() }
            }
            .store(in: &cancellables)
    }

    func reset() {
        originStateId = ""
        destinationStateId = ""
        purposeId = ""
        selectedCategoryIds = []
        selectedProfileFlags = []
        acceptedDisclaimer = false
    }

    /// Example pre-fill: California → Maryland for nursing school.
    func loadExample() {
        originStateId = "state-california"
        destinationStateId = "state-maryland"
        purposeId = "purpose-nursing-school"
        selectedCategoryIds = [
            "cat-drivers-license",
            "cat-vehicle-registration",
            "cat-auto-insurance",
            "cat-housing",
            "cat-nursing-healthcare",
            "cat-state-residency",
            "cat-student-relocation",
            "cat-healthcare-access"
        ]
        selectedProfileFlags = [
            .hasCar, .rentsHousing, .movingForSchool, .healthcareStudent
        ]
        acceptedDisclaimer = false
    }

    /// Snapshot of the current selections in the engine input shape.
    func snapshot() -> GenerateChecklistInput {
        GenerateChecklistInput(
            originStateId: originStateId,
            destinationStateId: destinationStateId,
            purposeId: purposeId,
            selectedCategoryIds: Array(selectedCategoryIds),
            selectedProfileFlags: Array(selectedProfileFlags)
        )
    }

    /// Validation errors, in display order. Empty when ready to submit.
    func validationErrors() -> [String] {
        var errs: [String] = []
        if originStateId.isEmpty { errs.append("Select an origin state.") }
        if destinationStateId.isEmpty { errs.append("Select a destination state.") }
        if purposeId.isEmpty { errs.append("Select a purpose.") }
        if selectedCategoryIds.isEmpty { errs.append("Select at least one category.") }
        if !acceptedDisclaimer { errs.append("Please confirm the disclaimer to continue.") }
        return errs
    }

    // MARK: - Persistence

    private struct Persisted: Codable {
        var originStateId: String
        var destinationStateId: String
        var purposeId: String
        var selectedCategoryIds: [String]
        var selectedProfileFlags: [String]
        var acceptedDisclaimer: Bool
    }

    private func persist() {
        let snap = Persisted(
            originStateId: originStateId,
            destinationStateId: destinationStateId,
            purposeId: purposeId,
            selectedCategoryIds: Array(selectedCategoryIds),
            selectedProfileFlags: selectedProfileFlags.map(\.rawValue),
            acceptedDisclaimer: acceptedDisclaimer
        )
        guard let data = try? JSONEncoder().encode(snap) else { return }
        defaults.set(data, forKey: PersistenceKeys.builderSelections)
    }

    private func load() {
        guard
            let data = defaults.data(forKey: PersistenceKeys.builderSelections),
            let p = try? JSONDecoder().decode(Persisted.self, from: data)
        else { return }
        isLoading = true
        defer { isLoading = false }
        originStateId = p.originStateId
        destinationStateId = p.destinationStateId
        purposeId = p.purposeId
        selectedCategoryIds = Set(p.selectedCategoryIds)
        selectedProfileFlags = Set(p.selectedProfileFlags.compactMap(ProfileFlag.init(rawValue:)))
        acceptedDisclaimer = p.acceptedDisclaimer
    }
}
