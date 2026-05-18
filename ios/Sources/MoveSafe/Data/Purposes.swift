import Foundation

enum Purposes {
    static let all: [Purpose] = [
        Purpose(
            id: "purpose-moving-for-school",
            name: "Moving for school",
            slug: "moving-for-school",
            description: "Relocating to attend an undergraduate or graduate program."
        ),
        Purpose(
            id: "purpose-moving-for-work",
            name: "Moving for work",
            slug: "moving-for-work",
            description: "Relocating for a job or new employer."
        ),
        Purpose(
            id: "purpose-nursing-school",
            name: "Nursing school / healthcare training",
            slug: "nursing-school",
            description: "Relocating for a nursing or healthcare program (ABSN, MEPN, MSN, allied health, etc.)."
        ),
        Purpose(
            id: "purpose-clinical-placement",
            name: "Clinical placement",
            slug: "clinical-placement",
            description: "Moving to another state for clinical rotations, externships, or supervised practice."
        ),
        Purpose(
            id: "purpose-internship",
            name: "Internship",
            slug: "internship",
            description: "Short-to-medium term internship or co-op in another state."
        ),
        Purpose(
            id: "purpose-temporary-stay",
            name: "Temporary stay",
            slug: "temporary-stay",
            description: "Staying in another state temporarily without intending to become a resident."
        ),
        Purpose(
            id: "purpose-permanent-relocation",
            name: "Permanent relocation",
            slug: "permanent-relocation",
            description: "Establishing a new permanent residence in the destination state."
        ),
        Purpose(
            id: "purpose-road-trip",
            name: "Road trip",
            slug: "road-trip",
            description: "Driving across one or more state lines for travel."
        ),
        Purpose(
            id: "purpose-family-move",
            name: "Family move",
            slug: "family-move",
            description: "Relocating with family members or dependents."
        ),
        Purpose(
            id: "purpose-not-sure",
            name: "Not sure yet",
            slug: "not-sure",
            description: "Exploring options. Receive a broad overview checklist."
        )
    ]

    static let byId: [String: Purpose] = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
}
