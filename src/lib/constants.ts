import type {
  JurisdictionType,
  ProfileFlag,
  RiskLevel,
  SourceStatus,
  SourceType,
} from "./types";

export const riskLabels: Record<RiskLevel, string> = {
  LOW: "Awareness item",
  MEDIUM: "Verify soon",
  HIGH: "Important to verify",
  VERIFY_SEPARATELY: "Do not assume",
};

export const riskDescriptions: Record<RiskLevel, string> = {
  LOW: "Worth knowing about. Usually administrative or low-stakes to verify.",
  MEDIUM: "Can cause inconvenience, fees, or compliance problems if ignored.",
  HIGH: "May involve penalties, licensing consequences, or major state-by-state differences.",
  VERIFY_SEPARATELY:
    "Rules vary substantially. Do not rely on this app — verify directly with official sources.",
};

export const riskOrder: RiskLevel[] = [
  "VERIFY_SEPARATELY",
  "HIGH",
  "MEDIUM",
  "LOW",
];

export const jurisdictionLabels: Record<JurisdictionType, string> = {
  STATE_LAW: "State law",
  LOCAL_ORDINANCE: "Local ordinance",
  FEDERAL_LAW: "Federal law",
  AGENCY_RULE: "Agency rule",
  PROFESSIONAL_BOARD_RULE: "Professional licensing board",
  SCHOOL_POLICY: "School / institution policy",
  EMPLOYER_POLICY: "Employer policy",
  ADMINISTRATIVE_REQUIREMENT: "Administrative requirement",
  PRACTICAL_REQUIREMENT: "Practical requirement",
  MIXED: "Mixed jurisdiction",
};

export const sourceTypeLabels: Record<SourceType, string> = {
  OFFICIAL_STATE_AGENCY: "Official state agency",
  OFFICIAL_LOCAL_AGENCY: "Official local agency",
  OFFICIAL_FEDERAL_AGENCY: "Official federal agency",
  PROFESSIONAL_BOARD: "Professional licensing board",
  SCHOOL_OR_INSTITUTION: "School or institution",
  LEGAL_AID_GENERAL_INFO: "Legal aid (general info)",
  SECONDARY_REFERENCE: "Secondary reference",
  PLACEHOLDER: "Placeholder source",
};

export const sourceStatusLabels: Record<SourceStatus, string> = {
  CURRENT: "Recently verified",
  REVIEW_RECOMMENDED: "Review recommended",
  POSSIBLY_OUTDATED: "Possibly outdated",
  STALE: "Stale source",
  PLACEHOLDER: "Placeholder source",
  MISSING: "Missing source",
};

export const profileFlagLabels: Record<ProfileFlag, string> = {
  HAS_CAR: "I have a car",
  RENTS_HOUSING: "I rent housing",
  HAS_PET: "I own a pet",
  MOVING_FOR_SCHOOL: "I am moving for school",
  MOVING_FOR_WORK: "I am moving for work",
  HEALTHCARE_STUDENT: "I am a nursing or healthcare student",
  NEEDS_PROFESSIONAL_LICENSE: "I hold or need a professional license",
  TEMPORARY_STAY: "I may stay temporarily",
  PERMANENT_RELOCATION: "I plan to relocate permanently",
  MAY_WORK_IN_DESTINATION_STATE: "I may work in the destination state",
  WANTS_HIGH_RISK_WARNINGS: "Show high-risk categories separately",
};

export const profileFlagOrder: ProfileFlag[] = [
  "HAS_CAR",
  "RENTS_HOUSING",
  "HAS_PET",
  "MOVING_FOR_SCHOOL",
  "MOVING_FOR_WORK",
  "HEALTHCARE_STUDENT",
  "NEEDS_PROFESSIONAL_LICENSE",
  "MAY_WORK_IN_DESTINATION_STATE",
  "PERMANENT_RELOCATION",
  "TEMPORARY_STAY",
  "WANTS_HIGH_RISK_WARNINGS",
];

export const MAIN_DISCLAIMER =
  "MoveSafe provides general legal and administrative information based on publicly available sources. It does not provide legal advice, does not create an attorney-client relationship, and should not be used as a substitute for advice from a licensed attorney in your jurisdiction. Laws and agency rules change frequently. Always verify information with official sources before making decisions.";

export const SHORT_DISCLAIMER =
  "General information only. Not legal advice. Verify with official sources.";

export const RESULTS_INTRO_DISCLAIMER =
  "Based on your selected states and purpose, here are topics to verify before moving. This checklist is not a legal conclusion.";

export const COVERAGE_CAVEAT =
  "This checklist is based on your selected categories and available source data. It may not include every requirement that applies to your situation.";
