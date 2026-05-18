import type { Category } from "../types";

export const categories: Category[] = [
  {
    id: "cat-drivers-license",
    name: "Driver's license",
    slug: "drivers-license",
    description: "License transfer, deadlines, documents, and REAL ID awareness.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 1,
  },
  {
    id: "cat-vehicle-registration",
    name: "Vehicle registration",
    slug: "vehicle-registration",
    description:
      "Registration deadlines, inspection, emissions, title, and plate rules.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 2,
  },
  {
    id: "cat-auto-insurance",
    name: "Auto insurance",
    slug: "auto-insurance",
    description:
      "Minimum coverage, state-specific rules, and policy address updates.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 3,
  },
  {
    id: "cat-housing",
    name: "Housing / renter basics",
    slug: "housing",
    description:
      "Lease terms, security deposits, notice periods, and tenant protections.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 4,
  },
  {
    id: "cat-pets",
    name: "Pets",
    slug: "pets",
    description:
      "Vaccination, licensing, breed restrictions, housing pet policies.",
    defaultRiskLevel: "LOW",
    isHighRiskCategory: false,
    sortOrder: 5,
  },
  {
    id: "cat-employment",
    name: "Employment paperwork",
    slug: "employment",
    description:
      "State tax withholding, labor law basics, remote work considerations.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 6,
  },
  {
    id: "cat-professional-license",
    name: "Professional license transfer",
    slug: "professional-license",
    description:
      "Endorsement, reciprocity, temporary practice, and continuing education.",
    defaultRiskLevel: "HIGH",
    isHighRiskCategory: false,
    sortOrder: 7,
  },
  {
    id: "cat-nursing-healthcare",
    name: "Nursing / healthcare licensure",
    slug: "nursing-healthcare",
    description:
      "Board of nursing requirements, compact licenses, clinical placement.",
    defaultRiskLevel: "HIGH",
    isHighRiskCategory: false,
    sortOrder: 8,
  },
  {
    id: "cat-state-residency",
    name: "State residency basics",
    slug: "state-residency",
    description:
      "Factors that may affect residency for tuition, taxes, licensing, benefits.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 9,
  },
  {
    id: "cat-taxes",
    name: "Taxes / state filing awareness",
    slug: "taxes",
    description:
      "State filing requirements, part-year residency, remote work implications.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 10,
  },
  {
    id: "cat-student-relocation",
    name: "Student relocation",
    slug: "student-relocation",
    description:
      "School residency classification, immunization, student insurance, housing.",
    defaultRiskLevel: "LOW",
    isHighRiskCategory: false,
    sortOrder: 11,
  },
  {
    id: "cat-healthcare-access",
    name: "Healthcare access / insurance",
    slug: "healthcare-access",
    description:
      "Insurance networks, student health, prescriptions, primary care access.",
    defaultRiskLevel: "MEDIUM",
    isHighRiskCategory: false,
    sortOrder: 12,
  },
  {
    id: "cat-high-risk",
    name: "High-risk items to verify separately",
    slug: "high-risk",
    description:
      "Categories where rules vary substantially. Verify directly with official sources.",
    defaultRiskLevel: "VERIFY_SEPARATELY",
    isHighRiskCategory: true,
    sortOrder: 13,
  },
];

export const categoriesById = new Map(categories.map((c) => [c.id, c]));
