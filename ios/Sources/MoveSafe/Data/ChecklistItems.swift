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
        ),

        // -------- Dreamer / Green card holder (immigration status) --------
        ChecklistItem(
            id: "noncitizen-drivers-license-documents",
            title: "Verify destination-state DMV documents for non-citizen applicants",
            slug: "noncitizen-drivers-license-documents",
            categoryId: "cat-drivers-license",
            description: "Document lists accepted by state DMVs for non-citizen license or state-ID applicants can differ from those accepted for U.S. citizens, and accepted combinations may vary by jurisdiction.",
            whyItMatters: "Arriving without the document combination the destination-state DMV expects can delay license issuance and other tasks that rely on a state ID after a move.",
            whatToVerify: [
                "Which federal immigration documents (for example, EAD, permanent resident card, USCIS notices) the destination-state DMV currently lists as acceptable",
                "Whether a Social Security card or an SSA ineligibility letter is required to apply",
                "Whether proof of in-state residency is needed in addition to identity and status documents",
                "Whether REAL ID and standard (non-REAL-ID) credentials use different document checklists",
                "Whether the license expiration is tied to the federal document expiration date",
                "Whether translations or originals are required, and whether copies are accepted"
            ],
            riskLevel: .medium,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not state which states do or do not issue licenses to a given group, and do not list specific accepted documents. Frame everything as items to verify with the destination-state DMV."
        ),
        ChecklistItem(
            id: "real-id-noncitizen-applicants",
            title: "Verify whether to apply for a REAL ID or a standard credential",
            slug: "real-id-noncitizen-applicants",
            categoryId: "cat-drivers-license",
            description: "REAL ID and standard credentials use different document checklists and have different uses for federal purposes such as boarding domestic flights or entering certain federal buildings.",
            whyItMatters: "Choosing the wrong credential type at the destination-state DMV can mean reapplying later, and document expiration may shorten the validity of a REAL ID issued to non-citizens.",
            whatToVerify: [
                "Whether your federal status document is on the destination-state DMV's accepted list for REAL ID",
                "Whether the REAL ID expiration date may be tied to the underlying federal document",
                "Whether a standard (non-REAL-ID) credential is offered as an alternative",
                "Whether the destination state offers a separate marked credential for some non-citizen applicants",
                "Whether identity, residency, and SSN documents are required in addition to status documents"
            ],
            riskLevel: .low,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not assert that any group is or is not eligible for REAL ID in a given state. REAL ID rules involve both federal minimums and state implementation that may change. Use 'verify' and 'may vary' language only."
        ),
        ChecklistItem(
            id: "dmv-voter-registration-noncitizen",
            title: "Know how to respond if asked to register to vote at the DMV",
            slug: "dmv-voter-registration-noncitizen",
            categoryId: "cat-state-residency",
            description: "Federal law generally requires motor vehicle offices to offer voter registration to applicants, and forms are screened for citizenship attestations. Non-citizens generally are not eligible to register for federal elections, and a registration record can later create immigration complications.",
            whyItMatters: "Registering or being recorded as registered, even by mistake, may create issues for naturalization, status renewal, or future immigration filings. The risk of an inadvertent record can depend on how a state's DMV workflow is designed.",
            whatToVerify: [
                "Whether the destination-state DMV asks all applicants about voter registration, including non-citizens",
                "How to decline voter registration when offered at the DMV in that state",
                "What documentation, if any, the DMV keeps if a non-citizen declines",
                "How to correct the record if a non-citizen registration was submitted in error",
                "Whether the destination state offers any voting that is open to non-citizens (for example, certain local elections), and how that may interact with federal voter rolls",
                "Whether you should consult a licensed immigration attorney before signing any voter-related paperwork"
            ],
            riskLevel: .high,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: true,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not characterize voter registration by non-citizens using legal-conclusion or accusatory language. Use neutral framing such as 'generally not eligible' and 'may create immigration complications'. Direct readers to consult a licensed immigration attorney. Do not give procedural advice for any specific state."
        ),
        ChecklistItem(
            id: "selective-service-license-link",
            title: "Check whether a destination-state license application triggers Selective Service registration",
            slug: "selective-service-license-link",
            categoryId: "cat-drivers-license",
            description: "Selective Service registration is a federal requirement for almost all males ages 18 through 25 in the United States, regardless of citizenship, and many states link license or ID applications to that registration.",
            whyItMatters: "Failing to register on time may affect eligibility for federal benefits, federal jobs, and naturalization later, even though the requirement is federal. State DMV workflows can also trigger automatic registration, which applicants should understand before applying.",
            whatToVerify: [
                "Whether you fall within the federal age range and category that must register",
                "Whether the destination-state license or ID application automatically initiates Selective Service registration",
                "How to confirm a registration after applying for a license",
                "How to obtain or replace a Selective Service registration record if needed for future immigration or federal-benefit filings",
                "Whether you should consult a licensed immigration attorney about how Selective Service registration interacts with your specific status"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-dmv"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not state that any specific person is or is not required to register. Frame as a federal requirement that 'may apply' depending on age and sex, with state implementation details to verify. Use neutral language and follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "professional-license-status-documentation",
            title: "Verify documentation a destination-state licensing board requires for non-citizens",
            slug: "professional-license-status-documentation",
            categoryId: "cat-professional-license",
            description: "Professional and occupational licensing boards set their own documentation rules. Whether a state board accepts an Employment Authorization Document, asks for an SSN, accepts an ITIN, or requires an attestation about lawful presence can differ across states and across professions within a state.",
            whyItMatters: "Application delays, denials, or re-fingerprinting may follow if the documents you submit do not match the destination-state board's current rules, especially when moving from a state with different requirements.",
            whatToVerify: [
                "Whether the destination-state board for your profession lists DACA recipients or lawful permanent residents in its documentation guidance",
                "Whether an SSN is required to apply, and whether an ITIN, an SSA ineligibility letter, or an affidavit is accepted as an alternative",
                "Whether your EAD or permanent resident card is on the accepted-documents list",
                "Whether the application asks for a lawful presence attestation",
                "Whether a license issued to a non-citizen may have a shorter renewal cycle tied to a federal document",
                "Whether the board accepts background-check results processed under your current status",
                "Whether you should consult a licensed immigration attorney before signing licensing attestations"
            ],
            riskLevel: .high,
            jurisdictionType: .professionalBoardRule,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-professional-licensing"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not state that any specific board does or does not license non-citizens. Frame everything as items to verify with the destination-state board. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "nursing-license-noncitizen-documentation",
            title: "Verify destination Board of Nursing documentation for non-citizen applicants",
            slug: "nursing-license-noncitizen-documentation",
            categoryId: "cat-nursing-healthcare",
            description: "Boards of Nursing may have specific guidance about documentation for non-citizen applicants, including whether an SSN is required, whether an ITIN or attestation is accepted, how foreign education is evaluated, and how license endorsement works when moving from another state.",
            whyItMatters: "NCLEX and license-by-endorsement steps can stall when documentation does not match a destination board's current rules, which can delay clinical placement, hire dates, and compact-state recognition.",
            whatToVerify: [
                "Whether the destination Board of Nursing requires an SSN at application, and whether an ITIN, attestation, or affidavit is accepted as an alternative",
                "Whether the destination state participates in the Nurse Licensure Compact and how that interacts with non-citizen documentation",
                "Whether your EAD or permanent resident card is on the board's current accepted-documents list",
                "Whether internationally educated nurses must complete a credentials-evaluation step (for example, CGFNS)",
                "Whether a license issued to a non-citizen may have a renewal cycle tied to a federal document",
                "How clinical-placement and background-check requirements interact with your immigration status",
                "Whether you should consult both the board and a licensed immigration attorney before signing licensing attestations"
            ],
            riskLevel: .high,
            jurisdictionType: .professionalBoardRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-board-of-nursing", "src-nlc-info"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not say a Board of Nursing in a particular state grants or refuses an applicant's NCLEX path. Use 'verify with the destination Board of Nursing'. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "instate-tuition-noncitizen",
            title: "Verify destination-state tuition classification rules for non-citizen students",
            slug: "instate-tuition-noncitizen",
            categoryId: "cat-student-relocation",
            description: "States and individual public colleges and universities use different tuition-classification rules for non-citizens, including how prior in-state high school attendance, current immigration status, and a parent's residency are considered.",
            whyItMatters: "Whether a student is classified as in-state, out-of-state, or under a tuition-equity policy can change the cost of attendance significantly, and rules can differ between the state higher-education agency, a state university system, and individual institutions.",
            whatToVerify: [
                "Whether the destination state has a tuition-equity policy that may apply, and what documentation it requires",
                "Whether your specific school sets its own tuition-classification rules in addition to any state policy",
                "How long you must hold residency in the destination state before being considered for in-state classification",
                "Whether high school attendance or graduation in the destination state is one of the qualifying paths",
                "What documents (for example, EAD, transcripts, affidavits, tax records) the registrar requires to support a tuition-classification request",
                "Whether moving mid-program changes the classification timeline",
                "Whether you should consult both the registrar and a licensed immigration attorney about how your documentation may interact with classification"
            ],
            riskLevel: .high,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-school-residency-policy"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not list which states grant in-state tuition for DACA recipients. Frame as classification rules to verify with the school registrar and the state higher-education agency."
        ),
        ChecklistItem(
            id: "state-aid-financial-aid-noncitizen",
            title: "Verify destination-state financial aid eligibility rules for non-citizens",
            slug: "state-aid-financial-aid-noncitizen",
            categoryId: "cat-student-relocation",
            description: "State grant and scholarship programs each have their own rules about whether non-citizen students may be considered, what application form (FAFSA, a state alternative, or an institutional form) is used, and what documentation is needed.",
            whyItMatters: "Moving from one state's aid program to another's may change which aid applications to consider and which documents to gather, and this can affect how to plan tuition and living costs at the destination.",
            whatToVerify: [
                "Whether the destination state operates a non-FAFSA aid application for students who cannot file a FAFSA",
                "Whether specific state grants or scholarships consider DACA recipients or lawful permanent residents in their eligibility criteria",
                "Whether institutional aid at your destination school is governed by separate rules from state aid",
                "How a mid-year move between states may affect aid-application deadlines",
                "What tax or residency documentation the state aid agency requires",
                "Whether you should consult both the financial-aid office and a licensed immigration attorney about how your status documentation will be used"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-school-residency-policy"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not say a particular aid program 'is open to' or 'is closed to' DACA recipients or LPRs. Use 'verify with the state aid agency and the school financial-aid office'. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "medicaid-chip-lpr-fiveyear-bar",
            title: "Verify how the federal five-year waiting period applies in the destination state",
            slug: "medicaid-chip-lpr-fiveyear-bar",
            categoryId: "cat-healthcare-access",
            description: "Federal Medicaid and CHIP rules generally include a five-year waiting period for many qualified non-citizens after obtaining qualified status, with several federal exceptions. States may use an option that removes the waiting period for children and pregnant people, and some states cover certain groups with state funds.",
            whyItMatters: "Whether the waiting period applies, whether a state option removes it for children or pregnancy, and which documents are accepted can change between origin and destination states and affect coverage continuity.",
            whatToVerify: [
                "Whether you fall within a federal exception to the five-year waiting period (for example, certain humanitarian categories, military-connected status, or qualifying work history)",
                "Whether the destination state uses the CHIPRA/ICHIA option to remove the waiting period for children, pregnant people, or both",
                "Whether the destination state offers any state-funded coverage for non-citizens who do not qualify for federal Medicaid",
                "Which documents the destination state Medicaid agency uses to verify status",
                "How a move mid-coverage may affect the reasonable opportunity period for documentation",
                "How CHIP coverage rules in the destination state interact with the waiting period for your household"
            ],
            riskLevel: .high,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.greenCardHolder],
            sourceIds: ["src-destination-health-dept"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not determine that a household 'is' or 'is not' eligible for Medicaid. Frame as items to verify with the state Medicaid agency. Use 'may apply' and 'rules differ by jurisdiction'. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "marketplace-health-coverage-noncitizen",
            title: "Verify health-insurance marketplace options in the destination state",
            slug: "marketplace-health-coverage-noncitizen",
            categoryId: "cat-healthcare-access",
            description: "Federal rules govern which immigration statuses can purchase coverage and receive financial help through the Affordable Care Act marketplace, and those rules have changed. State-based marketplaces and state-funded programs add another layer that can differ between origin and destination.",
            whyItMatters: "Continuity of coverage after a move depends on whether the destination state operates its own marketplace, which categories of non-citizens it considers, and whether state-funded coverage is offered to people who are not eligible for the federal marketplace.",
            whatToVerify: [
                "Whether the destination state uses HealthCare.gov or runs its own state-based marketplace",
                "Whether your current immigration status is on the marketplace's current 'lawfully present' list",
                "Whether DACA recipients are currently considered for marketplace coverage, since this category has changed at the federal level",
                "Whether the destination state offers any state-funded coverage for people not eligible for the federal marketplace",
                "Whether a move triggers a special enrollment period and what documents the marketplace requires to verify status",
                "Whether you should consult a licensed immigration attorney before submitting any marketplace documents related to status"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-health-dept"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not say a person 'can' or 'cannot' enroll. Use 'verify current eligibility categories with the marketplace operator' since federal rules have changed. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "state-funded-benefits-lpr",
            title: "Verify state-funded benefit programs that may apply during a federal waiting period",
            slug: "state-funded-benefits-lpr",
            categoryId: "cat-state-residency",
            description: "Federal SNAP, TANF, and similar programs apply a waiting period to many qualified non-citizens. Some states use state funds to operate replacement or supplemental programs that cover groups not eligible for the federal program, with differing rules.",
            whyItMatters: "A household that was covered by a state-funded program in the origin state may not find an equivalent program at the destination, which can affect a move plan.",
            whatToVerify: [
                "Whether the destination state operates state-funded SNAP, TANF, or cash-assistance programs that may apply during the federal waiting period",
                "Whether you fall within a federal exception (for example, qualifying work history, certain humanitarian categories, or specific military-connected categories)",
                "Which documents the destination-state agency uses to verify status",
                "Whether moving mid-coverage requires reapplication in the destination state",
                "Whether benefits use by certain immigrant categories can interact with future immigration filings, and whether you should consult a licensed immigration attorney before applying"
            ],
            riskLevel: .high,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.greenCardHolder],
            sourceIds: ["src-destination-labor-dept"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not provide a public-charge determination or say that using benefits 'will' or 'will not' affect immigration. Frame as 'may interact' and recommend consulting a licensed immigration attorney. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "state-residency-tax-filing-noncitizen",
            title: "Verify state tax residency and filing rules after a move",
            slug: "state-residency-tax-filing-noncitizen",
            categoryId: "cat-taxes",
            description: "State tax residency is determined under each state's own rules, which may differ from federal tax residency. Domicile, days of physical presence, employer location, and other factors can each play a role.",
            whyItMatters: "A move part-way through a tax year can lead to part-year filings, multiple state filings, or unexpected withholding, and rules for non-citizens generally follow the same state framework as for citizens but documentation can differ.",
            whatToVerify: [
                "Whether the destination state defines residency by domicile, by days of physical presence, or by a combination",
                "Whether you may owe a part-year return in the origin state and another in the destination state for the year of the move",
                "Whether your employer's state tax withholding should be updated after the move",
                "Whether the destination state accepts an ITIN where an SSN is requested on its return",
                "Whether any state credit programs (for example, an earned-income or family credit) consider non-citizen filers",
                "Whether you should consult a tax preparer who is familiar with non-citizen filers in the destination state"
            ],
            riskLevel: .medium,
            jurisdictionType: .stateLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: ["src-destination-tax-agency", "src-irs-state-residency-general"],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not state how a specific state defines residency or that someone 'is' a resident. Frame as 'rules differ by jurisdiction' and 'verify with the destination-state tax agency'. Follow the SafeCopy avoid list."
        ),

        // ---- Visa-holder research (2026-05-18) ----
        ChecklistItem(
            id: "uscis-ar11-ten-day-filing",
            title: "Verify the 10-day USCIS address change filing after an interstate move",
            slug: "uscis-ar11-ten-day-filing",
            categoryId: "cat-state-residency",
            description: "Federal law (INA section 265) generally directs non-citizens to report a change of address to USCIS within 10 days of moving, typically through Form AR-11 or the USCIS online change-of-address tool. The federal filing is separate from updating a state DMV record, an employer, a school, or the U.S. Postal Service.",
            whyItMatters: "A missed AR-11 filing can disrupt USCIS notice delivery for any pending or future case, and may create a question of status maintenance that compounds with employer and school records that also need updating.",
            whatToVerify: [
                "Whether the 10-day clock starts on the move date or the date the new address becomes permanent",
                "Whether the online change-of-address tool in a USCIS online account is the right path, or whether a paper Form AR-11 is needed",
                "Whether any pending USCIS case (I-129, I-485, I-765, I-130, and similar) requires a separate address update beyond AR-11",
                "What confirmation record (receipt, screenshot, mailed copy) to keep after filing",
                "Whether a USPS change-of-address forwards mail from USCIS (USCIS guidance generally indicates it does not)",
                "Whether to consult a licensed immigration attorney about how AR-11 interacts with a specific status"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "uscis-ar11-landing",
                "uscis-change-of-address-hub",
                "uscis-policy-manual-changes-of-address",
                "uscis-ar11-form-pdf",
                "uscis-online-change-address-tool-alert"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame AR-11 as a federal reporting step to verify, not a guarantee of status. Do not state that any specific status category is or is not covered without source. Avoid the iOS SafeCopy avoid-list (legal-conclusion phrasing such as the i-word, the p-words, and penalty-avoidance phrasing). Direct readers to consult a licensed immigration attorney for status-specific guidance."
        ),
        ChecklistItem(
            id: "ar11-not-same-as-usps-or-dmv",
            title: "Do not assume a USPS or DMV address update satisfies the federal AR-11 step",
            slug: "ar11-not-same-as-usps-or-dmv",
            categoryId: "cat-state-residency",
            description: "USCIS guidance generally indicates that a U.S. Postal Service change-of-address request does not change a record with USCIS and that USPS does not forward USCIS mail. A destination-state DMV address update is also a separate step from the federal AR-11 filing.",
            whyItMatters: "Setting up mail forwarding or updating a state license can give a false sense that the federal address record is current, while a pending USCIS case may still be sending notices to an old address.",
            whatToVerify: [
                "Whether USPS mail forwarding is in place for the new address",
                "Whether the destination-state DMV record reflects the new address on its own timeline",
                "Whether AR-11 has been filed separately with USCIS within the federal 10-day window",
                "Whether any active USCIS receipt number has its own e-Notification or online-account address that needs to be checked",
                "Whether to keep dated confirmations of each address update in case a later filing relies on it"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "uscis-ar11-landing",
                "uscis-change-of-address-hub",
                "usps-change-of-address"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Use do not assume language. Do not state that USPS or DMV updates can substitute for AR-11 (USCIS guidance says they generally do not). Avoid the iOS SafeCopy avoid-list (legal-conclusion phrasing and penalty-avoidance phrasing)."
        ),
        ChecklistItem(
            id: "f1-j1-sevis-address-dso-ten-day",
            title: "Verify the 10-day DSO or sponsor SEVIS address update for F-1 and J-1 status",
            slug: "f1-j1-sevis-address-dso-ten-day",
            categoryId: "cat-state-residency",
            description: "Department of Homeland Security guidance for F-1 and M-1 students, and Department of State regulations for J-1 exchange visitors, generally require reporting an address change to a designated school official (DSO) or program sponsor within 10 days so the SEVIS record can be updated.",
            whyItMatters: "An outdated SEVIS address can interfere with notice delivery from SEVP or the program sponsor, and uncorrected records can place a SEVIS record at risk of termination, which can have downstream effects on status, work authorization, and travel.",
            whatToVerify: [
                "Whether the destination address is being reported to the DSO or J-1 sponsor within 10 days of the move",
                "Whether both physical and mailing addresses are recorded in SEVIS if they differ",
                "Whether the DSO has confirmed the SEVIS record was updated and any documentation that confirms the update",
                "Whether a move that includes a change of school or program site requires additional SEVIS steps beyond an address update",
                "Whether the federal AR-11 filing is also needed as a separate step"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "study-in-the-states-personal-information",
                "study-in-the-states-report-changes-dso",
                "study-in-the-states-address-correct-sevis",
                "ice-sevis-landing",
                "studyinthestates-sevis-address",
                "ice-sevis-overview"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as items to verify with the DSO or J-1 sponsor and Study in the States or ICE guidance. This item is specific to F-1, M-1, and J-1 status. Avoid the iOS SafeCopy avoid-list (legal-conclusion phrasing and penalty-avoidance phrasing)."
        ),
        ChecklistItem(
            id: "f1-sevis-school-transfer",
            title: "Verify F-1 SEVIS school-transfer steps if the move is to a different school",
            slug: "f1-sevis-school-transfer",
            categoryId: "cat-student-relocation",
            description: "An F-1 student moving to another SEVP-certified school generally goes through a SEVIS record transfer between the current school's DSO and the new school's DSO, with a transfer release date, an initial reporting requirement at the new school, and a new Form I-20.",
            whyItMatters: "Missing the transfer reporting steps at the new school, or letting the transfer release date and program start fall out of sync, can affect status maintenance and access to on-campus work.",
            whatToVerify: [
                "Whether the current school DSO and the new school DSO have coordinated a SEVIS transfer release date",
                "Whether a new Form I-20 from the destination school has been issued and signed",
                "Whether the program start date and on-campus reporting deadline at the new school have been confirmed",
                "How a transfer interacts with current employment authorization, on-campus work, and any pending OPT",
                "Whether to consult the DSO and a licensed immigration attorney before making decisions that affect the transfer timeline"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "study-in-the-states-transfer-f1",
                "ice-f1-transfers",
                "ice-sevis-landing"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "F-1 specific. Frame as verify with both DSOs and reference Study in the States or ICE materials. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "opt-stem-opt-sevp-portal-updates",
            title: "Verify SEVP Portal updates for address, employer, and unemployment-day tracking on OPT or STEM OPT",
            slug: "opt-stem-opt-sevp-portal-updates",
            categoryId: "cat-employment",
            description: "F-1 students on post-completion OPT or a STEM OPT extension generally use the SEVP Portal or work with their DSO to update physical and mailing address, employer information, and other personal data, typically within 10 days of a change. Unemployment-day limits during OPT continue to apply during and after a move.",
            whyItMatters: "An interstate move during OPT or STEM OPT often coincides with an employer change, and missed reporting can affect both SEVIS standing and the running count of unemployment days, which is tracked at the federal level rather than by the destination state.",
            whatToVerify: [
                "Whether the new physical and mailing address has been entered in the SEVP Portal or reported to the DSO within 10 days",
                "Whether employer name, address, supervisor, and start or end dates are current in the SEVP Portal or reported to the DSO",
                "How the move affects any STEM OPT Form I-983 training plan and the destination employer's E-Verify status",
                "How unemployment days are counted during a gap between employers around a move",
                "Whether to consult the DSO and a licensed immigration attorney before changing employers around an interstate move"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-internship",
                "purpose-clinical-placement",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "study-in-the-states-opt-reporting",
                "study-in-the-states-stem-opt-hub",
                "ice-sevis-landing"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "F-1 OPT and STEM OPT specific. Use verify with the DSO and SEVP Portal guidance. Avoid the iOS SafeCopy avoid-list (legal-conclusion phrasing and penalty-avoidance phrasing). Do not advise on a specific status outcome."
        ),
        ChecklistItem(
            id: "h1b-lca-amendment-new-msa",
            title: "Verify whether an H-1B amended petition is needed for a worksite move to a new MSA",
            slug: "h1b-lca-amendment-new-msa",
            categoryId: "cat-employment",
            description: "Under USCIS guidance following Matter of Simeio Solutions (2015), an H-1B worker's move to a worksite outside the metropolitan statistical area (MSA) or area of intended employment listed on the current Labor Condition Application (LCA) is generally a material change that calls for a new LCA and an amended H-1B petition.",
            whyItMatters: "Starting work at a new worksite outside the LCA's MSA without an amended petition can affect status maintenance, and the timing of the amended petition filing matters for when the worker can begin at the new location.",
            whatToVerify: [
                "Whether the new worksite is inside the same MSA or area of intended employment as the current LCA, or in a new MSA",
                "Whether the employer is filing a new LCA and an amended Form I-129 before or shortly after the worker reports to the new worksite",
                "Whether posting requirements for the existing LCA at the new location, when in the same MSA, have been satisfied",
                "Whether a short-term placement exception (subject to federal time limits) applies before an amendment is needed",
                "How the move interacts with H-4 dependent status and any pending I-485 or I-140",
                "Whether to consult employer counsel and a licensed immigration attorney before the worker starts at the new location"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "uscis-simeio-final-guidance",
                "uscis-h1b-landing",
                "dol-foreign-labor-flag-portal"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "H-1B specific. Frame as verify with employer counsel and USCIS or DOL guidance. Do not state that an amendment is or is not required in a particular fact pattern. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "h1b-portability-same-employer-same-msa",
            title: "Verify H-1B portability and address handling for a move within the same MSA",
            slug: "h1b-portability-same-employer-same-msa",
            categoryId: "cat-employment",
            description: "USCIS guidance generally indicates that an H-1B worker moving to a new worksite within the same MSA or area of intended employment as the existing LCA does not require a new LCA or an amended H-1B petition, although the existing LCA may still need to be posted at the new worksite. The federal AR-11 address change requirement still applies to the worker.",
            whyItMatters: "Treating an intra-MSA worksite change as a full new petition can create unnecessary cost and timing risk, while assuming portability rules apply without checking the MSA boundaries can lead to status questions later.",
            whatToVerify: [
                "Whether the new worksite falls inside the MSA or area of intended employment listed on the current LCA",
                "Whether the existing LCA needs to be posted at the new worksite for the required period",
                "Whether the federal AR-11 address change has been filed within 10 days of the residential move",
                "Whether any change in job duties, hours, or wage triggers a separate amendment analysis even when the worksite stays in the same MSA",
                "Whether to consult employer counsel before relying on intra-MSA treatment"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "uscis-h1b-landing",
                "uscis-simeio-final-guidance",
                "uscis-ar11-landing"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "H-1B specific. Use verify whether MSA boundaries cover the new worksite. Do not assert that no amendment is needed in any specific fact pattern. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "l1-o1-worksite-amendment-check",
            title: "Verify L-1 or O-1 worksite change handling against the approved petition",
            slug: "l1-o1-worksite-amendment-check",
            categoryId: "cat-employment",
            description: "For L-1A, L-1B, and O-1 status, USCIS treats a move to a new worksite as a material change in some fact patterns and not others, depending on what the original petition described and whether the new location is consistent with the approved terms. The analysis follows the underlying petition, not LCA-based MSA rules.",
            whyItMatters: "Assuming H-1B-style MSA logic for L-1 or O-1 can lead to a missed amendment when the original petition described a specific worksite or itinerary that no longer matches.",
            whatToVerify: [
                "Whether the original L-1 or O-1 petition listed a specific worksite, employer location, or itinerary that the move changes",
                "For O-1, whether the new venue, event, engagement, or agent arrangement falls within the approved petition scope",
                "For L-1, whether the new worksite is the same qualifying U.S. office described in the petition or a different one",
                "Whether the employer or petitioner is filing an amended Form I-129 before the worker reports to the new location",
                "Whether the federal AR-11 address change has been filed within 10 days of the residential move",
                "Whether to consult petitioner counsel and a licensed immigration attorney before the worker starts at the new location"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "uscis-l1a-page",
                "uscis-l1b-page",
                "uscis-o1-page"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "L-1 and O-1 specific. Frame as verify against the approved petition and consult petitioner counsel. Do not state that an amendment is or is not needed for any specific scenario. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "j1-program-sponsor-site-of-activity",
            title: "Verify J-1 program sponsor reporting for site-of-activity or host-organization changes",
            slug: "j1-program-sponsor-site-of-activity",
            categoryId: "cat-employment",
            description: "Under 22 CFR Part 62, J-1 program sponsors maintain the SEVIS record and monitor the site of activity for each exchange visitor. A move that changes residence, site of activity, or host organization generally triggers an exchange-visitor reporting obligation to the sponsor and a sponsor update to SEVIS.",
            whyItMatters: "Because the J-1 sponsor (not USCIS) controls the SEVIS record and may need Department of State approval for certain changes, a move can affect program compliance differently from H-1B or F-1 scenarios.",
            whatToVerify: [
                "Whether the J-1 sponsor has been notified within 10 days of any change in U.S. address, telephone, or email",
                "Whether a change in site of activity or host organization needs prior sponsor authorization before it occurs",
                "Whether any category-specific rules (research scholar, professor, intern, trainee, physician, au pair, and others) add steps that the sponsor must approve",
                "Whether the federal AR-11 filing is also needed in addition to sponsor notification",
                "Whether to consult the responsible officer or alternate responsible officer at the sponsor and a licensed immigration attorney for category-specific guidance"
            ],
            riskLevel: .high,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "j1visa-state-gov",
                "j1visa-program-categories",
                "ecfr-22cfr-part-62",
                "ecfr-22cfr-62-13-notification"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "J-1 specific. Frame as verify with the program sponsor and reference 22 CFR Part 62. Do not state that any specific category does or does not require sponsor pre-approval for a particular change. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "substantial-presence-test-federal-residency",
            title: "Verify federal tax residency under the Substantial Presence Test after a move",
            slug: "substantial-presence-test-federal-residency",
            categoryId: "cat-taxes",
            description: "For federal tax purposes, a non-citizen is generally treated as a resident alien if they meet the Substantial Presence Test or hold lawful permanent resident status, with separate rules in IRS Publication 519 for exempt individuals (such as certain F-1, J-1, M-1, and Q students and scholars) whose days of presence may not count.",
            whyItMatters: "Federal residency for tax purposes determines whether worldwide income is reported, which IRS forms apply, and how an interstate move's first and last year are filed at the federal level, separately from state residency rules.",
            whatToVerify: [
                "Whether the calendar-year count of days under the Substantial Presence Test meets the federal threshold for the current year",
                "Whether an exempt-individual rule (for certain F, J, M, Q categories) may apply and for how many years",
                "Whether a closer connection exception or a tax-treaty tie-breaker rule may apply",
                "How a year of arrival to or departure from the United States interacts with the test",
                "Whether to consult a tax preparer familiar with non-citizen federal tax issues before relying on a particular residency conclusion"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "irs-pub-519",
                "irs-substantial-presence-test",
                "irs-determining-tax-residency",
                "irs-nonresident-alien-taxation"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as items to verify with IRS Publication 519 and a tax preparer. Do not state a person is or is not a resident alien for federal tax purposes. Use may apply and rules differ by jurisdiction. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "dual-status-year-tax-filing",
            title: "Verify dual-status year considerations for the federal return covering a move",
            slug: "dual-status-year-tax-filing",
            categoryId: "cat-taxes",
            description: "IRS Publication 519 describes a dual-status tax year for non-citizens who are both a nonresident and a resident for federal tax purposes during the same year, which can apply to many arrival, departure, and adjustment-of-status fact patterns rather than interstate moves alone.",
            whyItMatters: "A first or last year in the United States, or a year that includes adjustment to LPR status, can involve different forms, allowable deductions, and treatment of foreign income than a standard resident or nonresident return.",
            whatToVerify: [
                "Whether the tax year of the move includes both nonresident and resident periods for federal tax purposes",
                "Which forms (1040, 1040-NR, and supporting statements) apply for a dual-status year",
                "Whether a first-year choice or a tax-treaty election can change the analysis",
                "Whether a state return for the destination or origin state must be filed alongside the federal dual-status return",
                "Whether to consult a tax preparer who handles dual-status filings"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "irs-pub-519",
                "irs-dual-status",
                "irs-determining-tax-residency"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as items to verify in IRS Publication 519 and with a qualified tax preparer. Do not state a person is a dual-status filer for a particular year. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "fica-exemption-f1-j1-nonresident",
            title: "Verify FICA (Social Security and Medicare) handling for F-1 and J-1 nonresident aliens",
            slug: "fica-exemption-f1-j1-nonresident",
            categoryId: "cat-taxes",
            description: "IRS guidance generally describes an exemption from FICA tax for wages paid for services performed by F-1, J-1, M-1, and Q nonresident-alien students, scholars, teachers, researchers, and trainees, when the work is part of the activity for which they were admitted and they remain nonresident aliens for federal tax purposes.",
            whyItMatters: "After a move that involves a new employer, payroll systems may default to withholding FICA, and a misclassification can take time to correct through the employer or via an IRS refund claim.",
            whatToVerify: [
                "Whether the worker still meets the IRS conditions for the F-1, J-1, M-1, or Q FICA exemption (status type, primary purpose, and federal tax residency)",
                "Whether the new employer's payroll setup reflects the exemption",
                "How OPT or STEM OPT employment is treated for FICA while the worker remains a nonresident alien",
                "Whether a year of transition to resident-alien status under the Substantial Presence Test changes FICA treatment",
                "Whether to consult a tax preparer or the employer's payroll team to verify FICA setup after the move"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-internship",
                "purpose-clinical-placement",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "irs-fica-foreign-students",
                "irs-fica-aliens-employed",
                "irs-pub-519"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "F-1, J-1, M-1, and Q specific. Frame as items to verify with IRS guidance and the employer. Do not state that a particular worker is exempt from FICA. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "selective-service-nonimmigrant-exemption",
            title: "Verify how Selective Service registration applies to a specific nonimmigrant status",
            slug: "selective-service-nonimmigrant-exemption",
            categoryId: "cat-state-residency",
            description: "Selective Service System materials generally describe a Selective Service registration requirement for almost all men ages 18 through 25 living in the United States, with an exception for men who are in the United States on a current valid nonimmigrant visa while that status remains valid up to age 26.",
            whyItMatters: "Whether the exception covers a specific person depends on age, current status, and continuity of valid nonimmigrant status, and a later transition to LPR or naturalization can revive a registration question relevant to federal benefits and naturalization.",
            whatToVerify: [
                "Whether the person is within the age range to which the federal requirement may apply",
                "Whether their current nonimmigrant status is on the list described by the Selective Service System as covered by the exception",
                "How a future change to LPR status before age 26 may affect the registration question",
                "How the destination state's DMV or other application workflows interact with Selective Service screening",
                "Whether to consult a licensed immigration attorney about how registration history may interact with later filings"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-temporary-stay",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "sss-who-must-register",
                "sss-who-must-register-chart",
                "sss-faq"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as a federal requirement that may apply, with a nonimmigrant exception that may apply based on continuous valid status. Do not state that any specific person is or is not required to register. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "aca-marketplace-lawfully-present-nonimmigrants",
            title: "Verify ACA marketplace categories described as lawfully present for nonimmigrants",
            slug: "aca-marketplace-lawfully-present-nonimmigrants",
            categoryId: "cat-healthcare-access",
            description: "Federal HealthCare.gov guidance describes a list of immigration statuses considered lawfully present for purposes of the Affordable Care Act marketplace, which includes many common nonimmigrant categories. These categories can purchase coverage without a five-year waiting period that applies in many Medicaid contexts.",
            whyItMatters: "A move that triggers loss of prior coverage may open a marketplace special enrollment period, and the eligibility framework for nonimmigrants can differ from Medicaid waiting-period rules. Federal rules in this area have been changing.",
            whatToVerify: [
                "Whether the current nonimmigrant status appears on the current HealthCare.gov lawfully present list",
                "Whether the destination state uses HealthCare.gov or runs its own state-based marketplace with separate documentation rules",
                "Whether the move triggers a special enrollment period and the documentation needed to verify status",
                "Whether premium tax credit or cost-sharing reduction eligibility rules have changed for the relevant year",
                "Whether to consult a licensed immigration attorney before submitting status documentation to the marketplace"
            ],
            riskLevel: .medium,
            jurisdictionType: .federalLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "healthcare-gov-lawfully-present",
                "healthcare-gov-immigrants-coverage",
                "healthcare-gov-immigration-status",
                "cms-marketplace-overview"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as items to verify with the current HealthCare.gov or state-based marketplace lists. Do not state any specific category is or is not on the lawfully present list, since federal rules have changed. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "medicare-medicaid-nonimmigrant-eligibility",
            title: "Verify Medicare and Medicaid eligibility rules that may apply to nonimmigrants after a move",
            slug: "medicare-medicaid-nonimmigrant-eligibility",
            categoryId: "cat-healthcare-access",
            description: "Federal Medicare guidance generally describes eligibility for non-citizens who are lawfully admitted for permanent residence and have lived in the United States for five continuous years. Federal Medicaid rules for most nonimmigrants are narrower than for LPRs, with state-specific options for emergency Medicaid and for lawfully residing children and pregnant individuals.",
            whyItMatters: "Many nonimmigrant visa holders are not within the standard Medicare or Medicaid eligibility groups, and federal rules in this area have been changing. Destination-state Medicaid rules add another layer that may differ from origin-state rules.",
            whatToVerify: [
                "Whether the current status is within a recognized federal eligibility group for Medicare or Medicaid",
                "Whether destination-state Medicaid offers emergency-only coverage to nonimmigrants and what documentation it requires",
                "Whether the destination state has elected the CHIPRA option to cover lawfully residing children and pregnant individuals without a federal waiting period",
                "How the move and any change in employer-sponsored coverage interact with marketplace special enrollment timing",
                "Whether to consult the destination-state Medicaid agency for current eligibility categories"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "cms-medicare-eligibility-original",
                "medicare-gov-get-started",
                "cms-medicaid-chip-noncitizen-press",
                "ssa-poms-rs00204010"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as items to verify with CMS and the destination-state Medicaid agency. Federal rules have changed and may continue to change. Do not state a person is or is not eligible. Avoid the iOS SafeCopy avoid-list."
        ),
        ChecklistItem(
            id: "visa-dmv-documents-nonimmigrant",
            title: "Verify destination-state DMV documents for nonimmigrant visa applicants",
            slug: "visa-dmv-documents-nonimmigrant",
            categoryId: "cat-drivers-license",
            description: "State DMV document checklists for nonimmigrant visa applicants (F-1, J-1, H-1B, L-1, O-1 and similar) can differ from those used for U.S. citizens or lawful permanent residents. Accepted combinations of passport, visa, I-94, I-20 or DS-2019, and I-797 or employer letter may vary, and some states ask for an SSN card or an SSA ineligibility letter.",
            whyItMatters: "Arriving without the document combination the destination-state DMV expects can delay license issuance, which then delays other tasks that rely on a state credential after a move, including rental, employer onboarding, and school registration.",
            whatToVerify: [
                "Which federal immigration documents the destination-state DMV currently lists for nonimmigrant visa applicants (for example, passport with visa stamp, I-94, I-20 or DS-2019, I-797, employer support letter)",
                "Whether the destination state requires a Social Security card or an SSA ineligibility letter, and how the visa category interacts with SSN issuance timing",
                "Whether proof of in-state residency is required in addition to identity and status documents, and what residency proofs the DMV accepts for new arrivals",
                "Whether the destination state imposes a minimum remaining stay on the I-94 before issuing a credential",
                "Whether the destination DMV requires original documents and current address proofs, and whether copies or translations are accepted",
                "Whether you should consult your designated school official, employer immigration contact, or a licensed immigration attorney before applying"
            ],
            riskLevel: .high,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "ca-dmv-realid-noncitizen",
                "tx-dps-id-requirements",
                "ny-dmv-noncitizen-resources",
                "fl-flhsmv-nonimmigrant",
                "il-sos-tvdl",
                "ma-rmv-id-requirements",
                "wa-dol-proof-of-identity",
                "ga-dds-non-us-citizens",
                "i94-cbp",
                "uscis-employment-authorization"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not state which states issue or do not issue licenses to a given visa category, and do not list specific accepted documents. Frame everything as items to verify with the destination-state DMV. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "visa-real-id-status-document-expiration",
            title: "Verify how a destination-state REAL ID expiration may track an underlying federal document",
            slug: "visa-real-id-status-document-expiration",
            categoryId: "cat-drivers-license",
            description: "Federal REAL ID rules require evidence of lawful status, and many states issue a REAL ID to nonimmigrant visa holders only with an expiration date that does not extend past the I-94, the visa, or another underlying federal document. Implementation differs between states, and standard (non-REAL-ID) options may or may not be offered.",
            whyItMatters: "If a credential is issued with an unexpected short term tied to a federal document, the timing of renewal can affect domestic flights, federal building access, and other tasks that may rely on a REAL ID after a move.",
            whatToVerify: [
                "Whether the destination-state DMV will issue a REAL ID to your specific visa category and which federal documents it requires",
                "Whether the REAL ID expiration date may be tied to the I-94, the visa, or an I-797 or I-20 or DS-2019, and how renewal works after a status extension",
                "Whether a standard (non-REAL-ID) credential is offered as an alternative and whether its expiration is also tied to a federal document",
                "Whether a separate identifier or marking appears on credentials issued to applicants with temporary lawful status in that state",
                "Whether identity, residency, and SSN documents are required in addition to status documents",
                "Whether you should consult your designated school official, employer immigration contact, or a licensed immigration attorney about timing renewals around an extension or change of status"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .greenCardHolder, .dreamer],
            sourceIds: [
                "tsa-real-id",
                "tsa-real-id-faqs",
                "ca-dmv-realid-noncitizen",
                "ny-dmv-realid-enhanced",
                "ma-rmv-id-requirements",
                "i94-cbp"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not assert that any visa category is or is not eligible for REAL ID in a given state. REAL ID involves both federal minimums and state implementation that may change. Use 'verify' and 'may vary' language only and follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "visa-license-renewal-cycle-tied-to-i94",
            title: "Verify license fee and renewal-cycle rules that may follow an I-94 expiration",
            slug: "visa-license-renewal-cycle-tied-to-i94",
            categoryId: "cat-drivers-license",
            description: "Some states issue driver licenses or state IDs to nonimmigrant visa applicants on a shortened renewal cycle that tracks the I-94 or an underlying federal document, instead of the multi-year cycle used for citizens. Fees, renewal timing, and steps after a status extension can differ between origin and destination states.",
            whyItMatters: "A move that triggers a fresh application in the destination state may produce a credential with a different renewal cycle than the prior state used, and timing renewal around an I-94 or visa extension can affect work, study, and travel logistics.",
            whatToVerify: [
                "Whether the destination-state DMV typically issues a credential to your visa category for the standard multi-year cycle or for a shortened cycle keyed to the I-94 or another federal document",
                "Whether a fresh I-94 printout or an updated I-797 is needed at the time of renewal, and whether the DMV verifies status through a federal system in real time",
                "Whether renewal fees and step counts differ from the standard renewal process used for citizens",
                "How an in-progress extension of status (for example, an H-1B amendment or an F-1 transfer) interacts with renewing or replacing the credential",
                "Whether you should consult your designated school official, employer immigration contact, or a licensed immigration attorney about timing a DMV renewal around a pending federal filing"
            ],
            riskLevel: .medium,
            jurisdictionType: .agencyRule,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "ca-dmv-realid-noncitizen",
                "tx-dps-id-requirements",
                "fl-flhsmv-nonimmigrant",
                "il-sos-tvdl",
                "ga-dds-non-us-citizens",
                "i94-cbp"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not assert that any specific state always uses a shortened renewal cycle for a given visa category. Frame as items to verify with the destination-state DMV. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "visa-instate-tuition-classification",
            title: "Verify destination-state tuition classification rules for nonimmigrant visa students",
            slug: "visa-instate-tuition-classification",
            categoryId: "cat-student-relocation",
            description: "Public college and university residency rules for tuition often treat nonimmigrant visa holders (such as F-1 and J-1 students) differently from U.S. citizens and lawful permanent residents. Some visa categories are considered able to establish a domicile in a state, while others generally are not, and some states have separate statutes or board regulations that apply to high school graduates from the state regardless of status. Rules vary across the state higher-education agency, a system office, and individual institutions.",
            whyItMatters: "Whether a student is classified as resident, nonresident, or under a state tuition-equity provision can change the cost of attendance significantly, and rules vary across origin and destination states and across institutions within a state.",
            whatToVerify: [
                "Whether the destination state recognizes your specific visa category as one that may establish a domicile for tuition purposes",
                "Whether the destination state has a tuition-equity or high-school-attendance provision that could apply, and what documentation it requires",
                "Whether the institution you plan to attend sets its own classification rules in addition to any state policy",
                "How long you must hold residency in the destination state before being considered for in-state classification, and whether time on a nonimmigrant visa counts",
                "What documents (for example, I-94, I-20 or DS-2019, I-797, transcripts, affidavits, tax records) the registrar requires to support a classification request",
                "Whether moving mid-program changes the classification timeline",
                "Whether you should consult the registrar, your designated school official, and a licensed immigration attorney about how your documentation interacts with classification"
            ],
            riskLevel: .medium,
            jurisdictionType: .mixed,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-permanent-relocation",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "tx-higher-ed-residency",
                "ca-uc-ab540-exemption",
                "suny-residency-tuition-policy",
                "cuny-residency-tuition-manual",
                "nj-tuition-equality-act",
                "il-isac-nonus-citizens",
                "il-ibhe-undocumented-liaisons",
                "fl-bog-residency-requirements"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not characterize whether any visa category can establish residency in a specific state as a determination. Frame as classification rules to verify with the school registrar and the state higher-education agency. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "visa-professional-licensing-documentation",
            title: "Verify destination-state professional licensing documentation rules for visa or OPT applicants",
            slug: "visa-professional-licensing-documentation",
            categoryId: "cat-professional-license",
            description: "Professional and occupational licensing boards (including nursing, medicine, law, engineering, and many others) set their own documentation rules. Whether a state board accepts an EAD, asks for an SSN, accepts an ITIN or affidavit, accepts an I-797 for an H-1B or O-1 worker, or requires fingerprint background checks tied to a specific status can differ across states and across professions within a state. Some boards specifically address F-1 OPT and J-1 academic-training applicants.",
            whyItMatters: "Application delays, denials, or re-fingerprinting may follow if the documents you submit do not match the destination-state board's current rules, especially when moving from a state with different requirements. Boards of Nursing also vary in how they treat the Nurse Licensure Compact for non-citizen primary state of residency.",
            whatToVerify: [
                "Whether the destination-state board for your profession lists nonimmigrant visa categories or OPT or academic training in its documentation guidance",
                "Whether an SSN is required to apply, and whether an ITIN, an SSA ineligibility letter, or an affidavit is accepted as an alternative",
                "Whether your visa documents (passport with visa, I-94, I-20 or DS-2019, I-797, EAD) are on the accepted-documents list",
                "Whether the application asks for a lawful presence attestation and what document supports it",
                "Whether a license issued to a visa holder may have a shorter renewal cycle tied to a federal document",
                "For nursing specifically, how the destination state treats primary state of residency under the Nurse Licensure Compact for a non-citizen who declares either the country of origin or the compact state, and any credentials-evaluation requirement (for example, CGFNS) for internationally educated applicants",
                "Whether you should consult both the board and a licensed immigration attorney before signing licensing attestations"
            ],
            riskLevel: .high,
            jurisdictionType: .professionalBoardRule,
            appliesToPurposes: [
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-nursing-school",
                "purpose-clinical-placement",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder, .dreamer, .greenCardHolder],
            sourceIds: [
                "ca-rn-licensure-faqs",
                "ca-rn-endorsement-international",
                "tx-bon-eligibility",
                "tx-bon-endorsement",
                "ny-op-rn-license-requirements",
                "ncsbn-nurse-licensure-guidance",
                "ncsbn-nurse-licensure-compact",
                "nursecompact-faqs"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not state that any specific board does or does not license a given visa category. Frame everything as items to verify with the destination-state board. Follow the SafeCopy avoid list."
        ),
        ChecklistItem(
            id: "visa-state-tax-residency-nra",
            title: "Verify state tax residency rules and how they interact with federal nonresident alien status",
            slug: "visa-state-tax-residency-nra",
            categoryId: "cat-taxes",
            description: "State tax residency is determined under each state's own rules, which may differ from federal tax residency. A person treated as a nonresident alien on the federal return may still be a resident, part-year resident, or nonresident for state purposes depending on domicile, days of physical presence, employer location, and other factors. States may or may not conform to federal income tax treaty exclusions.",
            whyItMatters: "A move part-way through a tax year may produce part-year filings, multiple state filings, or unexpected withholding, and the interaction between federal nonresident alien treatment and state residency rules can change between origin and destination.",
            whatToVerify: [
                "Whether the destination state defines residency by domicile, by days of physical presence, or by a combination",
                "Whether the destination state conforms to federal income tax treaty exclusions for nonresident aliens, or taxes that income at the state level",
                "Whether you may owe a part-year return in the origin state and another in the destination state for the year of the move",
                "Whether your employer's state tax withholding should be updated after the move and which form is used",
                "Whether the destination state accepts an ITIN where an SSN is requested on its return, and whether a separate state tax ID is offered",
                "Whether you should consult a tax preparer familiar with nonresident alien filers in the destination state"
            ],
            riskLevel: .medium,
            jurisdictionType: .stateLaw,
            appliesToPurposes: [
                "purpose-moving-for-school",
                "purpose-moving-for-work",
                "purpose-permanent-relocation",
                "purpose-internship",
                "purpose-family-move",
                "purpose-not-sure"
            ],
            appliesToProfileFlags: [.visaHolder],
            sourceIds: [
                "ca-ftb-residency-status",
                "ca-ftb-part-year-nonresident",
                "ny-tax-nonresident-partyear",
                "ny-tax-nonresident-faqs",
                "ma-dor-nonresident-tax",
                "ma-dor-part-year-tax"
            ],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: false,
            safeLanguageNotes: "Do not state how a specific state defines residency for a given visa category or that someone 'is' a resident. Frame as 'rules differ by jurisdiction' and 'verify with the destination-state tax agency'. Follow the SafeCopy avoid list."
        )
    ]
}
