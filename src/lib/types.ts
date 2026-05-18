export type RiskLevel = "LOW" | "MEDIUM" | "HIGH" | "VERIFY_SEPARATELY";

export type JurisdictionType =
  | "STATE_LAW"
  | "LOCAL_ORDINANCE"
  | "FEDERAL_LAW"
  | "AGENCY_RULE"
  | "PROFESSIONAL_BOARD_RULE"
  | "SCHOOL_POLICY"
  | "EMPLOYER_POLICY"
  | "ADMINISTRATIVE_REQUIREMENT"
  | "PRACTICAL_REQUIREMENT"
  | "MIXED";

export type SourceType =
  | "OFFICIAL_STATE_AGENCY"
  | "OFFICIAL_LOCAL_AGENCY"
  | "OFFICIAL_FEDERAL_AGENCY"
  | "PROFESSIONAL_BOARD"
  | "SCHOOL_OR_INSTITUTION"
  | "LEGAL_AID_GENERAL_INFO"
  | "SECONDARY_REFERENCE"
  | "PLACEHOLDER";

export type SourceStatus =
  | "CURRENT"
  | "REVIEW_RECOMMENDED"
  | "POSSIBLY_OUTDATED"
  | "STALE"
  | "PLACEHOLDER"
  | "MISSING";

export type ProfileFlag =
  | "HAS_CAR"
  | "RENTS_HOUSING"
  | "HAS_PET"
  | "MOVING_FOR_SCHOOL"
  | "MOVING_FOR_WORK"
  | "HEALTHCARE_STUDENT"
  | "NEEDS_PROFESSIONAL_LICENSE"
  | "TEMPORARY_STAY"
  | "PERMANENT_RELOCATION"
  | "MAY_WORK_IN_DESTINATION_STATE"
  | "WANTS_HIGH_RISK_WARNINGS";

export type State = {
  id: string;
  name: string;
  abbreviation: string;
  slug: string;
  officialWebsiteUrl?: string;
  dmvUrl?: string;
  taxAgencyUrl?: string;
  housingAgencyUrl?: string;
  boardOfNursingUrl?: string;
  notes?: string;
};

export type Purpose = {
  id: string;
  name: string;
  slug: string;
  description: string;
};

export type Category = {
  id: string;
  name: string;
  slug: string;
  description: string;
  defaultRiskLevel: RiskLevel;
  isHighRiskCategory: boolean;
  sortOrder: number;
};

export type Source = {
  id: string;
  title: string;
  url: string;
  sourceType: SourceType;
  jurisdictionType: JurisdictionType;
  stateId?: string;
  agencyName?: string;
  lastChecked?: string;
  status: SourceStatus;
  notes?: string;
  isOfficial: boolean;
  createdAt: string;
  updatedAt: string;
};

export type ChecklistItem = {
  id: string;
  title: string;
  slug: string;
  categoryId: string;
  description: string;
  whyItMatters: string;
  whatToVerify: string[];
  riskLevel: RiskLevel;
  jurisdictionType: JurisdictionType;
  originStateId?: string | null;
  destinationStateId?: string | null;
  appliesToPurposes: string[];
  appliesToProfileFlags: ProfileFlag[];
  sourceIds: string[];
  isHighRisk: boolean;
  isStateSpecific: boolean;
  isLocalSensitive: boolean;
  isFederalSensitive: boolean;
  staleWarningOverride?: string;
  safeLanguageNotes?: string;
  createdAt: string;
  updatedAt: string;
};

export type ChecklistItemWithSources = ChecklistItem & {
  sources: Array<Source & { computedStatus: SourceStatus }>;
};

export type GenerateChecklistInput = {
  originStateId: string;
  destinationStateId: string;
  purposeId: string;
  selectedCategoryIds: string[];
  selectedProfileFlags: ProfileFlag[];
};

export type GenerateChecklistOutput = {
  originState: State;
  destinationState: State;
  purpose: Purpose;
  groupedItems: Record<string, ChecklistItemWithSources[]>;
  riskCounts: Record<RiskLevel, number>;
  warnings: string[];
  totalItems: number;
};
