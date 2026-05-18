import Foundation

enum RiskLevel: String, CaseIterable, Codable, Identifiable {
    case low = "LOW"
    case medium = "MEDIUM"
    case high = "HIGH"
    case verifySeparately = "VERIFY_SEPARATELY"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .low: return "Awareness item"
        case .medium: return "Verify soon"
        case .high: return "Important to verify"
        case .verifySeparately: return "Do not assume"
        }
    }

    var description: String {
        switch self {
        case .low:
            return "Worth knowing about. Usually administrative or low-stakes to verify."
        case .medium:
            return "Can cause inconvenience, fees, or compliance problems if ignored."
        case .high:
            return "May involve penalties, licensing consequences, or major state-by-state differences."
        case .verifySeparately:
            return "Rules vary substantially. Do not rely on this app — verify directly with official sources."
        }
    }

    // Display order: highest concern first.
    static let displayOrder: [RiskLevel] = [.verifySeparately, .high, .medium, .low]
}

enum JurisdictionType: String, Codable, Identifiable {
    case stateLaw = "STATE_LAW"
    case localOrdinance = "LOCAL_ORDINANCE"
    case federalLaw = "FEDERAL_LAW"
    case agencyRule = "AGENCY_RULE"
    case professionalBoardRule = "PROFESSIONAL_BOARD_RULE"
    case schoolPolicy = "SCHOOL_POLICY"
    case employerPolicy = "EMPLOYER_POLICY"
    case administrativeRequirement = "ADMINISTRATIVE_REQUIREMENT"
    case practicalRequirement = "PRACTICAL_REQUIREMENT"
    case mixed = "MIXED"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .stateLaw: return "State law"
        case .localOrdinance: return "Local ordinance"
        case .federalLaw: return "Federal law"
        case .agencyRule: return "Agency rule"
        case .professionalBoardRule: return "Professional licensing board"
        case .schoolPolicy: return "School / institution policy"
        case .employerPolicy: return "Employer policy"
        case .administrativeRequirement: return "Administrative requirement"
        case .practicalRequirement: return "Practical requirement"
        case .mixed: return "Mixed jurisdiction"
        }
    }
}

enum SourceType: String, Codable {
    case officialStateAgency = "OFFICIAL_STATE_AGENCY"
    case officialLocalAgency = "OFFICIAL_LOCAL_AGENCY"
    case officialFederalAgency = "OFFICIAL_FEDERAL_AGENCY"
    case professionalBoard = "PROFESSIONAL_BOARD"
    case schoolOrInstitution = "SCHOOL_OR_INSTITUTION"
    case legalAidGeneralInfo = "LEGAL_AID_GENERAL_INFO"
    case secondaryReference = "SECONDARY_REFERENCE"
    case placeholder = "PLACEHOLDER"

    var label: String {
        switch self {
        case .officialStateAgency: return "Official state agency"
        case .officialLocalAgency: return "Official local agency"
        case .officialFederalAgency: return "Official federal agency"
        case .professionalBoard: return "Professional licensing board"
        case .schoolOrInstitution: return "School or institution"
        case .legalAidGeneralInfo: return "Legal aid (general info)"
        case .secondaryReference: return "Secondary reference"
        case .placeholder: return "Placeholder source"
        }
    }
}

enum SourceStatus: String, Codable, Identifiable {
    case current = "CURRENT"
    case reviewRecommended = "REVIEW_RECOMMENDED"
    case possiblyOutdated = "POSSIBLY_OUTDATED"
    case stale = "STALE"
    case placeholder = "PLACEHOLDER"
    case missing = "MISSING"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .current: return "Recently verified"
        case .reviewRecommended: return "Review recommended"
        case .possiblyOutdated: return "Possibly outdated"
        case .stale: return "Stale source"
        case .placeholder: return "Placeholder source"
        case .missing: return "Missing source"
        }
    }

    var isStale: Bool {
        self == .reviewRecommended || self == .possiblyOutdated || self == .stale
    }

    var isPlaceholderOrMissing: Bool {
        self == .placeholder || self == .missing
    }
}

enum ProfileFlag: String, CaseIterable, Codable, Identifiable {
    case hasCar = "HAS_CAR"
    case rentsHousing = "RENTS_HOUSING"
    case hasPet = "HAS_PET"
    case movingForSchool = "MOVING_FOR_SCHOOL"
    case movingForWork = "MOVING_FOR_WORK"
    case healthcareStudent = "HEALTHCARE_STUDENT"
    case needsProfessionalLicense = "NEEDS_PROFESSIONAL_LICENSE"
    case temporaryStay = "TEMPORARY_STAY"
    case permanentRelocation = "PERMANENT_RELOCATION"
    case mayWorkInDestinationState = "MAY_WORK_IN_DESTINATION_STATE"
    case dreamer = "DREAMER"
    case greenCardHolder = "GREEN_CARD_HOLDER"
    case wantsHighRiskWarnings = "WANTS_HIGH_RISK_WARNINGS"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .hasCar: return "I have a car"
        case .rentsHousing: return "I rent housing"
        case .hasPet: return "I own a pet"
        case .movingForSchool: return "I am moving for school"
        case .movingForWork: return "I am moving for work"
        case .healthcareStudent: return "I am a nursing or healthcare student"
        case .needsProfessionalLicense: return "I hold or need a professional license"
        case .temporaryStay: return "I may stay temporarily"
        case .permanentRelocation: return "I plan to relocate permanently"
        case .mayWorkInDestinationState: return "I may work in the destination state"
        case .dreamer: return "I'm a Dreamer (DACA / similar)"
        case .greenCardHolder: return "I'm a green card holder (LPR)"
        case .wantsHighRiskWarnings: return "Show high-risk categories separately"
        }
    }

    // Mirrors profileFlagOrder in the web app.
    static let displayOrder: [ProfileFlag] = [
        .hasCar, .rentsHousing, .hasPet,
        .movingForSchool, .movingForWork, .healthcareStudent,
        .needsProfessionalLicense, .mayWorkInDestinationState,
        .permanentRelocation, .temporaryStay,
        .dreamer, .greenCardHolder,
        .wantsHighRiskWarnings
    ]
}
