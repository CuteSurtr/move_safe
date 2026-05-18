import Foundation

// Items are state-agnostic by default. State-specific items can be added later
// by setting originStateId / destinationStateId. All language follows the
// safe-copy rules in SafeCopy.swift - no legal conclusions.
enum ChecklistItems {
    static let all: [ChecklistItem] = [
        // -------- Driver's license --------
        ChecklistItem(
            id: "drivers-license-deadline",
            title: "Verify the destination-state driver's license deadline",
            slug: "drivers-license-deadline",
            categoryId: "cat-drivers-license",
            description: "Many states require new residents to obtain a state driver's license within a specific period after becoming a resident.",
            whyItMatters: "Missing a state motor vehicle deadline can create administrative or driving-related problems after relocation.",
            whatToVerify: [
                "Whether the destination state considers you a resident",
                "Whether students or temporary residents are treated differently",
                "The deadline for applying for a destination-state license",
                "Required documents for the application",
                "Whether your current license remains usable during a transition period"
            ],
            riskLevel: .medium,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.hasCar],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),
        ChecklistItem(
            id: "drivers-license-documents",
            title: "Confirm required documents for a destination-state license",
            slug: "drivers-license-documents",
            categoryId: "cat-drivers-license",
            description: "States may require proof of identity, residency, lawful presence, school documents, or other paperwork.",
            whyItMatters: "Arriving without the right documents can delay your license and other tasks that depend on it.",
            whatToVerify: [
                "Identity and residency documents accepted by the destination state",
                "Whether immigration status or school documents affect the process",
                "Whether REAL ID requirements apply for your situation"
            ],
            riskLevel: .low,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.hasCar],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),

        // -------- Vehicle registration --------
        ChecklistItem(
            id: "vehicle-registration-deadline",
            title: "Verify vehicle registration requirements after moving",
            slug: "vehicle-registration-deadline",
            categoryId: "cat-vehicle-registration",
            description: "Vehicle registration rules can change after a state-to-state move, especially if the destination state treats you as a new resident.",
            whyItMatters: "Registration, inspection, emissions, title, and plate requirements can differ by state.",
            whatToVerify: [
                "Registration deadline after establishing residency",
                "Inspection requirement",
                "Emissions testing requirement",
                "Title transfer process",
                "Plate requirements (front and/or rear)",
                "Student or temporary resident exceptions"
            ],
            riskLevel: .medium,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.hasCar],
            sourceIds: ["src-destination-dmv", "src-origin-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),

        // -------- Auto insurance --------
        ChecklistItem(
            id: "auto-insurance-coverage",
            title: "Confirm your auto insurance covers the destination state",
            slug: "auto-insurance-coverage",
            categoryId: "cat-auto-insurance",
            description: "Auto insurance minimums and rules differ by state. Insurers may need to update your policy after a move.",
            whyItMatters: "Driving with coverage that does not meet destination-state minimums can create compliance and financial problems.",
            whatToVerify: [
                "Whether your current policy covers driving in the destination state",
                "Destination-state minimum coverage requirements",
                "Whether your insurer requires you to update your policy address",
                "Whether state-specific uninsured/underinsured motorist rules apply"
            ],
            riskLevel: .medium,
            jurisdictionType: .stateLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-road-trip",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.hasCar],
            sourceIds: ["src-missing-example"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Direct users to confirm coverage with their insurer. Do not state whether coverage applies."
        ),

        // -------- Housing --------
        ChecklistItem(
            id: "housing-lease-basics",
            title: "Review destination-state lease and tenant basics",
            slug: "housing-lease-basics",
            categoryId: "cat-housing",
            description: "Security deposit limits, notice periods, eviction rules, and late-fee rules can differ between states and between cities.",
            whyItMatters: "Lease decisions made based on origin-state assumptions may not match destination-state rules.",
            whatToVerify: [
                "Security deposit limits and return deadlines",
                "Required notice periods for ending a lease",
                "Whether local tenant protections apply",
                "Subleasing rules",
                "Eviction and late-fee rules"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.rentsHousing],
            sourceIds: ["src-destination-attorney-general"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: true,
            isFederalSensitive: false,
            safeLanguageNotes: "Local city/county rules may add protections. Review lease language directly."
        ),

        // -------- Pets --------
        ChecklistItem(
            id: "pets-vaccination-and-rules",
            title: "Check pet vaccination, licensing, and housing rules",
            slug: "pets-vaccination-and-rules",
            categoryId: "cat-pets",
            description: "Vaccination, local licensing, breed restrictions, and landlord pet policies can vary across destination states and cities.",
            whyItMatters: "Pet rules may be set by state, local, or housing-provider policies. Each layer can have different requirements.",
            whatToVerify: [
                "Rabies and other vaccination documentation requirements",
                "Local pet licensing requirements",
                "Breed or species restrictions (state, local, or housing-level)",
                "Apartment or landlord pet policies",
                "Travel documentation if flying with a pet"
            ],
            riskLevel: .low,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure",
                "purpose-road-trip"
            ],
            appliesToProfileFlags: [.hasPet],
            sourceIds: ["src-destination-agriculture-pets"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: true,
            isFederalSensitive: false
        ),

        // -------- Employment --------
        ChecklistItem(
            id: "employment-tax-and-paperwork",
            title: "Update employment paperwork and state tax forms",
            slug: "employment-tax-and-paperwork",
            categoryId: "cat-employment",
            description: "Moving may change which state tax withholding forms apply, and remote work can create cross-state payroll questions.",
            whyItMatters: "Withholding the wrong state's taxes can lead to filing complications and unexpected balances.",
            whatToVerify: [
                "Whether the destination state has different tax withholding forms",
                "Whether local taxes apply",
                "Whether your employer needs an updated address",
                "Whether remote work creates state tax or payroll issues",
                "State labor law basics (paid sick leave, breaks, final pay rules)"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.movingForWork, .mayWorkInDestinationState],
            sourceIds: ["src-destination-labor-dept", "src-destination-tax-agency"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not provide tax advice. Direct to official tax agency and qualified professionals."
        ),

        // -------- Professional license transfer --------
        ChecklistItem(
            id: "professional-license-transfer",
            title: "Check whether your professional license transfers",
            slug: "professional-license-transfer",
            categoryId: "cat-professional-license",
            description: "Endorsement, reciprocity, temporary permits, and continuing education requirements vary by state and profession.",
            whyItMatters: "Working in a licensed profession before completing the destination state's licensing process may have regulatory consequences.",
            whatToVerify: [
                "Whether your license transfers via endorsement or reciprocity",
                "Whether a new application is required",
                "Whether temporary practice permits exist",
                "Continuing education requirements",
                "Background check or fingerprinting requirements",
                "Whether pending discipline or incomplete education affects transfer"
            ],
            riskLevel: .high,
            jurisdictionType: .professionalBoardRule,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.needsProfessionalLicense, .mayWorkInDestinationState],
            sourceIds: ["src-destination-professional-licensing"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),

        // -------- Nursing / healthcare licensure --------
        ChecklistItem(
            id: "nursing-board-requirements",
            title: "Check the destination state board of nursing requirements",
            slug: "nursing-board-requirements",
            categoryId: "cat-nursing-healthcare",
            description: "Nursing education, licensure, endorsement, temporary permits, and compact license rules are handled by state boards of nursing and may differ by state.",
            whyItMatters: "Licensure requirements can affect clinical placement, NCLEX eligibility, endorsement, and employment timing.",
            whatToVerify: [
                "NCLEX eligibility requirements",
                "Endorsement requirements if already licensed",
                "Temporary permit availability",
                "Background check and fingerprinting requirements",
                "Nurse Licensure Compact participation",
                "Primary state of residence requirements",
                "SSN or identity documentation requirements if applicable",
                "School-specific clinical onboarding requirements"
            ],
            riskLevel: .high,
            jurisdictionType: .professionalBoardRule,
            appliesToPurposes: [
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-moving-for-work",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.healthcareStudent, .needsProfessionalLicense],
            sourceIds: ["src-destination-board-of-nursing", "src-nlc-info"],
            isHighRisk: false,
            isStateSpecific: true,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not state whether the user is eligible for licensure. Only identify requirements to verify."
        ),
        ChecklistItem(
            id: "nursing-clinical-placement",
            title: "Confirm clinical placement and school onboarding requirements",
            slug: "nursing-clinical-placement",
            categoryId: "cat-nursing-healthcare",
            description: "Clinical sites and schools may require immunizations, drug screens, CPR/BLS, background checks, and other clearances separate from board licensure.",
            whyItMatters: "Missing a school or hospital onboarding requirement can delay clinical hours and graduation timing.",
            whatToVerify: [
                "Immunization requirements",
                "Drug screen requirements",
                "CPR / BLS certification",
                "Background check and fingerprinting requirements",
                "Health clearance documentation",
                "Whether clinicals can begin before full licensure"
            ],
            riskLevel: .high,
            jurisdictionType: .schoolPolicy,
            appliesToPurposes: [
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.healthcareStudent],
            sourceIds: ["src-school-residency-policy"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),

        // -------- State residency --------
        ChecklistItem(
            id: "state-residency-factors",
            title: "Understand how the destination state defines residency",
            slug: "state-residency-factors",
            categoryId: "cat-state-residency",
            description: "Residency can affect tuition, taxes, licensing, and benefits, and is determined by the relevant state agency, school, or tax authority - not by MoveSafe.",
            whyItMatters: "Different agencies may apply different residency tests. The same person can be a resident for one purpose and not another.",
            whatToVerify: [
                "How the destination state defines residency",
                "Whether school attendance affects residency",
                "Which factors apply (lease, employment, vehicle registration, voting, tax filing)",
                "How temporary stay is treated differently from permanent relocation",
                "Whether residency affects tuition, taxes, licenses, or benefits"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [],
            sourceIds: ["src-school-residency-policy", "src-destination-tax-agency"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not determine residency. List factors to verify. Direct to the relevant agency or school."
        ),

        // -------- Taxes --------
        ChecklistItem(
            id: "taxes-state-filing-awareness",
            title: "Check whether moving creates a state tax filing requirement",
            slug: "taxes-state-filing-awareness",
            categoryId: "cat-taxes",
            description: "Part-year residency, remote work, and school attendance may all affect state tax filing.",
            whyItMatters: "State tax filing can apply even when income is earned remotely. Rules differ by state.",
            whatToVerify: [
                "Whether part-year residency rules apply",
                "Whether remote work may create tax issues",
                "Whether your employer needs updated state tax forms",
                "Whether school attendance affects tax residency"
            ],
            riskLevel: .medium,
            jurisdictionType: .stateLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-internship",
                "purpose-nursing-school",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [],
            sourceIds: ["src-destination-tax-agency", "src-irs-state-residency-general"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not provide tax advice. Direct to state tax agency or qualified tax professional."
        ),

        // -------- Student relocation --------
        ChecklistItem(
            id: "student-school-onboarding",
            title: "Confirm school residency, insurance, and immunization rules",
            slug: "student-school-onboarding",
            categoryId: "cat-student-relocation",
            description: "Schools set their own residency, health-insurance, and immunization requirements separate from state-agency rules.",
            whyItMatters: "School-level requirements can affect tuition classification, enrollment, and clinical participation.",
            whatToVerify: [
                "School residency classification",
                "Student health insurance requirements",
                "Immunization requirements",
                "Parking permit and campus housing rules",
                "Whether out-of-state students need special documentation"
            ],
            riskLevel: .low,
            jurisdictionType: .schoolPolicy,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.movingForSchool, .healthcareStudent],
            sourceIds: ["src-school-residency-policy"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false
        ),

        // -------- Healthcare access --------
        ChecklistItem(
            id: "healthcare-network-and-prescriptions",
            title: "Check insurance networks, student health, and prescription transfer",
            slug: "healthcare-network-and-prescriptions",
            categoryId: "cat-healthcare-access",
            description: "Insurance networks, Medicaid and marketplace rules, and prescription transfer processes vary by state.",
            whyItMatters: "A health plan that works at home may have limited in-network access in the destination state.",
            whatToVerify: [
                "Whether your health insurance network covers the destination state",
                "Whether student health insurance is required",
                "Whether Medicaid or state marketplace rules differ",
                "Whether prescriptions can be transferred",
                "Primary care access after moving"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [],
            sourceIds: ["src-destination-health-dept"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Administrative guidance only. Not medical advice."
        ),

        // -------- High-risk (verify separately) --------
        ChecklistItem(
            id: "high-risk-regulated-items",
            title: "Do not assume regulated items follow the same rules across state lines",
            slug: "high-risk-regulated-items",
            categoryId: "cat-high-risk",
            description: "Some items may be regulated differently across state lines and may involve state law, local ordinances, federal law, or agency rules.",
            whyItMatters: "Rules may differ substantially by jurisdiction, and MoveSafe does not determine whether possession, transportation, or use is lawful in a specific situation.",
            whatToVerify: [
                "Whether the item is regulated by state law",
                "Whether local ordinances are stricter than state rules",
                "Whether federal rules apply to interstate transportation",
                "Whether permits, age restrictions, documentation, or location-specific rules apply",
                "Whether professional legal advice is needed"
            ],
            riskLevel: .verifySeparately,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-road-trip",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.wantsHighRiskWarnings],
            sourceIds: [],
            isHighRisk: true,
            isStateSpecific: false,
            isLocalSensitive: true,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not provide tactical instructions for transporting, possessing, hiding, storing, modifying, or avoiding enforcement for regulated items."
        ),
        ChecklistItem(
            id: "high-risk-prescriptions-transport",
            title: "Verify rules for transporting prescription medication across state lines",
            slug: "high-risk-prescriptions-transport",
            categoryId: "cat-high-risk",
            description: "Prescription medications, especially controlled substances, may be subject to state, federal, and pharmacy-level rules during interstate moves.",
            whyItMatters: "Rules around possession, documentation, and refills can differ across states and pharmacies.",
            whatToVerify: [
                "Whether the medication is a controlled substance under federal or state law",
                "Whether documentation (original container, prescription) is recommended",
                "Whether your pharmacy can transfer the prescription",
                "Whether the destination state has additional reporting or filling rules",
                "Whether you should speak with your prescriber or pharmacist"
            ],
            riskLevel: .verifySeparately,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-road-trip",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-family-move",
                "purpose-nursing-school",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.wantsHighRiskWarnings],
            sourceIds: [],
            isHighRisk: true,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not provide medical or transport instructions for controlled substances."
        )
    ]
}
