import Foundation

// Today's reference date for MVP demos: 2026-05-17.
// Dates below are chosen to demonstrate each source-status bucket:
//   - <=90d:   CURRENT
//   - 91-180:  REVIEW_RECOMMENDED
//   - 181-365: POSSIBLY_OUTDATED
//   - >365:    STALE
enum Sources {
    static let all: [Source] = [
        Source(
            id: "src-destination-dmv",
            title: "Official destination state motor vehicle agency",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .agencyRule,
            agencyName: "Destination state DMV / MVA",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with an official URL from the destination state motor vehicle agency before relying on this item.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .dmv)
        ),
        Source(
            id: "src-origin-dmv",
            title: "Official origin state motor vehicle agency",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .agencyRule,
            agencyName: "Origin state DMV / MVA",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with an official URL from the origin state motor vehicle agency before relying on this item.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .origin, field: .dmv)
        ),
        Source(
            id: "src-destination-tax-agency",
            title: "Official destination state tax agency",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .agencyRule,
            agencyName: "Destination state tax agency",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state's official tax agency website. Tax rules and forms change frequently.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .tax)
        ),
        Source(
            id: "src-destination-board-of-nursing",
            title: "Official destination state board of nursing",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .professionalBoardRule,
            agencyName: "Destination state board of nursing",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the official destination state board of nursing URL. Board rules govern eligibility and endorsement.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .nursing)
        ),
        Source(
            id: "src-nlc-info",
            title: "Nurse Licensure Compact general information",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .professionalBoardRule,
            agencyName: "Nurse Licensure Compact",
            lastChecked: "2025-12-01",
            status: .placeholder,
            notes: "Replace with the official NLC information page. Participation status and rules can change.",
            isOfficial: false
        ),
        Source(
            id: "src-destination-attorney-general",
            title: "Official destination state attorney general - tenant resources",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .stateLaw,
            agencyName: "Destination state attorney general",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state's attorney general or housing agency. Local ordinances may add protections.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .housing)
        ),
        Source(
            id: "src-destination-health-dept",
            title: "Official destination state department of health",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .agencyRule,
            agencyName: "Destination state department of health",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state department of health URL.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .official)
        ),
        Source(
            id: "src-destination-agriculture-pets",
            title: "Official destination state department of agriculture - pet entry",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .agencyRule,
            agencyName: "Destination state department of agriculture",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state agriculture / animal-health agency. Some species, breeds, or vaccinations have specific entry rules.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .official)
        ),
        Source(
            id: "src-destination-labor-dept",
            title: "Official destination state department of labor",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .stateLaw,
            agencyName: "Destination state department of labor",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state labor agency for paid leave, withholding, and labor law basics.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .official)
        ),
        Source(
            id: "src-destination-professional-licensing",
            title: "Official destination state professional licensing portal",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .professionalBoardRule,
            agencyName: "Destination state professional licensing",
            lastChecked: "2026-05-17",
            status: .placeholder,
            notes: "Replace with the destination state's professional licensing portal or relevant board for the specific profession.",
            isOfficial: false,
            stateUrlBinding: StateUrlBinding(role: .destination, field: .official)
        ),
        Source(
            id: "src-school-residency-policy",
            title: "School residency / tuition classification policy",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .schoolPolicy,
            agencyName: "Receiving school registrar / residency office",
            lastChecked: "2026-04-30",
            status: .placeholder,
            notes: "Replace with the receiving school's residency or tuition classification page. School rules differ from state-agency rules.",
            isOfficial: false
        ),
        Source(
            id: "src-irs-state-residency-general",
            title: "Federal tax authority general guidance",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .federalLaw,
            agencyName: "Federal tax authority",
            lastChecked: "2026-04-30",
            status: .placeholder,
            notes: "Replace with official federal tax-authority guidance. Use only as general orientation; consult a qualified tax professional.",
            isOfficial: false
        ),
        Source(
            id: "src-missing-example",
            title: "Source not yet documented",
            url: "#",
            sourceType: .placeholder,
            jurisdictionType: .mixed,
            agencyName: nil,
            lastChecked: nil,
            status: .missing,
            notes: "No source has been added yet for this item. Add an official source before relying on it.",
            isOfficial: false
        )
    ]

    static let byId: [String: Source] = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
}
