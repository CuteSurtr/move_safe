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

        // -------- Visa-holder specific (also flags AR-11 for LPRs and DACA) --------
        ChecklistItem(
            id: "uscis-ar11-address-change",
            title: "Report your new address to USCIS within 10 days (Form AR-11)",
            slug: "uscis-ar11-address-change",
            categoryId: "cat-state-residency",
            description: "Most non-citizens in the United States must report a change of address to USCIS within 10 days of moving, typically via Form AR-11 or its online equivalent.",
            whyItMatters: "Missing the AR-11 reporting window can affect notice delivery from USCIS, may interact with future immigration filings, and is a separate requirement from updating addresses with state agencies, schools, employers, or the post office.",
            whatToVerify: [
                "Whether your specific status (visa category, parole, asylum, LPR, etc.) is covered by the AR-11 requirement",
                "Whether a destination-state DMV address update or post-office change-of-address satisfies the federal requirement (it generally does not)",
                "How to file AR-11 (online vs. paper) and what confirmation to keep for your records",
                "Whether any pending USCIS cases require separate address updates beyond AR-11",
                "Whether you should consult a licensed immigration attorney before filing"
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
            appliesToProfileFlags: [.dreamer, .greenCardHolder, .visaHolder],
            sourceIds: [],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Frame as a federal requirement with a short reporting window that 'may apply' depending on status. Do not state the AR-11 requirement does or does not apply to a specific user. Direct to the USCIS site and a licensed immigration attorney."
        ),
        ChecklistItem(
            id: "visa-status-maintenance-after-move",
            title: "Maintain visa status and update SEVIS / employer records after moving",
            slug: "visa-status-maintenance-after-move",
            categoryId: "cat-state-residency",
            description: "Maintaining nonimmigrant visa status involves status-specific obligations that an interstate move may trigger, such as SEVIS updates for F-1 and J-1 students, address updates with an H-1B or other employer-sponsored case, and confirmation that a state-issued license has not been shortened to match a federal document expiration.",
            whyItMatters: "Lapsed reporting, an expired status document, or a license linked to an older federal document can cascade into work-authorization, tuition, and immigration consequences that are easier to prevent than to fix.",
            whatToVerify: [
                "Whether your designated school official (DSO) for F-1 or J-1 status needs to update SEVIS with the new address and any program-location change",
                "Whether an employer-sponsored status (H-1B, L-1, O-1, etc.) requires a worksite update, amendment, or address change with USCIS",
                "Whether a driver's license issued in the origin state had an expiration tied to a federal document, and how that affects the destination-state application",
                "Whether the destination state requires an updated I-94 or status document beyond what the origin state required",
                "Whether you should consult a licensed immigration attorney and your DSO or HR contact about how the move affects status maintenance"
            ],
            riskLevel: .high,
            jurisdictionType: .mixed,
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
            sourceIds: [],
            isHighRisk: false,
            isStateSpecific: false,
            isLocalSensitive: false,
            isFederalSensitive: true,
            safeLanguageNotes: "Do not say a specific user must or must not file an amendment, update SEVIS, or take any specific action. Frame as items to verify with the school DSO, employer HR / immigration counsel, and a licensed immigration attorney. Use neutral 'may apply' framing throughout."
        )
    ]
}
