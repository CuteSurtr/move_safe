import Foundation

struct USState: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let abbreviation: String
    let slug: String
    var officialWebsiteUrl: String?
    var dmvUrl: String?
    var taxAgencyUrl: String?
    var housingAgencyUrl: String?
    var boardOfNursingUrl: String?
    var notes: String?

    /// Returns the URL stored at the given field, or `nil` if missing or still
    /// the `"#"` placeholder.
    func url(for field: StateUrlField) -> String? {
        let raw: String?
        switch field {
        case .official: raw = officialWebsiteUrl
        case .dmv:      raw = dmvUrl
        case .tax:      raw = taxAgencyUrl
        case .housing:  raw = housingAgencyUrl
        case .nursing:  raw = boardOfNursingUrl
        }
        guard let raw, !raw.isEmpty, raw != "#" else { return nil }
        return raw
    }
}

enum StateUrlField: String, Codable, Hashable {
    case official, dmv, tax, housing, nursing
}

enum StateRole: String, Codable, Hashable {
    case origin, destination
}

struct StateUrlBinding: Codable, Hashable {
    let role: StateRole
    let field: StateUrlField
}

struct Purpose: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let slug: String
    let description: String
}

struct Category: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let slug: String
    let description: String
    let defaultRiskLevel: RiskLevel
    let isHighRiskCategory: Bool
    let sortOrder: Int
}

struct Source: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let url: String
    let sourceType: SourceType
    let jurisdictionType: JurisdictionType
    var stateId: String?
    var agencyName: String?
    /// ISO date string (e.g. "2026-04-20") or nil for MISSING.
    var lastChecked: String?
    let status: SourceStatus
    var notes: String?
    let isOfficial: Bool
    /// When set, the URL displayed for this source is resolved against the
    /// origin or destination state's matching agency URL at engine time.
    /// Falls back to `url` if the target state has no value for that field.
    var stateUrlBinding: StateUrlBinding?

    init(
        id: String,
        title: String,
        url: String,
        sourceType: SourceType,
        jurisdictionType: JurisdictionType,
        stateId: String? = nil,
        agencyName: String? = nil,
        lastChecked: String? = nil,
        status: SourceStatus,
        notes: String? = nil,
        isOfficial: Bool,
        stateUrlBinding: StateUrlBinding? = nil
    ) {
        self.id = id
        self.title = title
        self.url = url
        self.sourceType = sourceType
        self.jurisdictionType = jurisdictionType
        self.stateId = stateId
        self.agencyName = agencyName
        self.lastChecked = lastChecked
        self.status = status
        self.notes = notes
        self.isOfficial = isOfficial
        self.stateUrlBinding = stateUrlBinding
    }
}

struct ChecklistItem: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let slug: String
    let categoryId: String
    let description: String
    let whyItMatters: String
    let whatToVerify: [String]
    let riskLevel: RiskLevel
    let jurisdictionType: JurisdictionType
    var originStateId: String?
    var destinationStateId: String?
    let appliesToPurposes: [String]
    let appliesToProfileFlags: [ProfileFlag]
    let sourceIds: [String]
    let isHighRisk: Bool
    let isStateSpecific: Bool
    let isLocalSensitive: Bool
    let isFederalSensitive: Bool
    var staleWarningOverride: String?
    var safeLanguageNotes: String?
}

/// A checklist item bundled with its sources and their computed staleness.
struct ChecklistItemWithSources: Identifiable, Hashable {
    let item: ChecklistItem
    let sources: [SourceWithStatus]

    var id: String { item.id }
}

/// A source plus its computed status at a given reference date. `resolvedUrl`
/// is the URL to actually display - either the source's literal `url` or, when
/// `source.stateUrlBinding` is set, the matching URL pulled from the origin /
/// destination state.
struct SourceWithStatus: Identifiable, Hashable {
    let source: Source
    let computedStatus: SourceStatus
    let resolvedUrl: String

    var id: String { source.id }
}

struct GenerateChecklistInput: Hashable {
    let originStateId: String
    let destinationStateId: String
    let purposeId: String
    let selectedCategoryIds: [String]
    let selectedProfileFlags: [ProfileFlag]
}

struct GenerateChecklistOutput {
    let originState: USState
    let destinationState: USState
    let purpose: Purpose
    /// Category ID → items, in category sortOrder.
    let groupedItems: [(categoryId: String, items: [ChecklistItemWithSources])]
    let riskCounts: [RiskLevel: Int]
    let warnings: [String]
    let totalItems: Int
}
