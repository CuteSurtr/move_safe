import Combine
import Foundation

/// Tracks which checklist items the user has marked as verified/completed.
/// Persisted across launches via UserDefaults.
final class ProgressStore: ObservableObject {
    @Published private(set) var completedItemIds: Set<String> = []

    private let defaults: UserDefaults
    private var cancellables: Set<AnyCancellable> = []
    private var isLoading = false

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
        objectWillChange
            .sink { [weak self] _ in
                guard let self, !self.isLoading else { return }
                DispatchQueue.main.async { self.persist() }
            }
            .store(in: &cancellables)
    }

    func isCompleted(_ itemId: String) -> Bool {
        completedItemIds.contains(itemId)
    }

    func toggle(_ itemId: String) {
        if completedItemIds.contains(itemId) {
            completedItemIds.remove(itemId)
        } else {
            completedItemIds.insert(itemId)
        }
    }

    /// Clears progress for a specific set of item IDs (used by the "Reset progress"
    /// action when only the visible items should be reset).
    func clear(itemIds: [String]) {
        for id in itemIds { completedItemIds.remove(id) }
    }

    /// Clears all tracked completions.
    func reset() {
        completedItemIds = []
    }

    private func persist() {
        let array = Array(completedItemIds)
        defaults.set(array, forKey: PersistenceKeys.completedItemIds)
    }

    private func load() {
        let array = defaults.stringArray(forKey: PersistenceKeys.completedItemIds) ?? []
        isLoading = true
        defer { isLoading = false }
        completedItemIds = Set(array)
    }
}
