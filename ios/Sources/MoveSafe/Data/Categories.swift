import Foundation

enum Categories {
    static let all: [Category] = [
        Category(
            id: "cat-drivers-license",
            name: "Driver's license",
            slug: "drivers-license",
            description: "License transfer, deadlines, documents, and REAL ID awareness.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 1
        ),
        Category(
            id: "cat-vehicle-registration",
            name: "Vehicle registration",
            slug: "vehicle-registration",
            description: "Registration deadlines, inspection, emissions, title, and plate rules.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 2
        ),
        Category(
            id: "cat-auto-insurance",
            name: "Auto insurance",
            slug: "auto-insurance",
            description: "Minimum coverage, state-specific rules, and policy address updates.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 3
        ),
        Category(
            id: "cat-housing",
            name: "Housing / renter basics",
            slug: "housing",
            description: "Lease terms, security deposits, notice periods, and tenant protections.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 4
        ),
        Category(
            id: "cat-pets",
            name: "Pets",
            slug: "pets",
            description: "Vaccination, licensing, breed restrictions, housing pet policies.",
            defaultRiskLevel: .low,
            isHighRiskCategory: false,
            sortOrder: 5
        ),
        Category(
            id: "cat-employment",
            name: "Employment paperwork",
            slug: "employment",
            description: "State tax withholding, labor law basics, remote work considerations.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 6
        ),
        Category(
            id: "cat-professional-license",
            name: "Professional license transfer",
            slug: "professional-license",
            description: "Endorsement, reciprocity, temporary practice, and continuing education.",
            defaultRiskLevel: .high,
            isHighRiskCategory: false,
            sortOrder: 7
        ),
        Category(
            id: "cat-nursing-healthcare",
            name: "Nursing / healthcare licensure",
            slug: "nursing-healthcare",
            description: "Board of nursing requirements, compact licenses, clinical placement.",
            defaultRiskLevel: .high,
            isHighRiskCategory: false,
            sortOrder: 8
        ),
        Category(
            id: "cat-state-residency",
            name: "State residency basics",
            slug: "state-residency",
            description: "Factors that may affect residency for tuition, taxes, licensing, benefits.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 9
        ),
        Category(
            id: "cat-taxes",
            name: "Taxes / state filing awareness",
            slug: "taxes",
            description: "State filing requirements, part-year residency, remote work implications.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 10
        ),
        Category(
            id: "cat-student-relocation",
            name: "Student relocation",
            slug: "student-relocation",
            description: "School residency classification, immunization, student insurance, housing.",
            defaultRiskLevel: .low,
            isHighRiskCategory: false,
            sortOrder: 11
        ),
        Category(
            id: "cat-healthcare-access",
            name: "Healthcare access / insurance",
            slug: "healthcare-access",
            description: "Insurance networks, student health, prescriptions, primary care access.",
            defaultRiskLevel: .medium,
            isHighRiskCategory: false,
            sortOrder: 12
        ),
        Category(
            id: "cat-high-risk",
            name: "High-risk items to verify separately",
            slug: "high-risk",
            description: "Categories where rules vary substantially. Verify directly with official sources.",
            defaultRiskLevel: .verifySeparately,
            isHighRiskCategory: true,
            sortOrder: 13
        )
    ]

    static let byId: [String: Category] = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
}
