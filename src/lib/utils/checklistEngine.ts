import { categories, categoriesById } from "../data/categories";
import { checklistItems } from "../data/checklistItems";
import { purposesById } from "../data/purposes";
import { sources, sourcesById } from "../data/sources";
import { statesById } from "../data/states";
import { riskOrder } from "../constants";
import type {
  ChecklistItemWithSources,
  GenerateChecklistInput,
  GenerateChecklistOutput,
  RiskLevel,
  Source,
  SourceStatus,
} from "../types";
import { getSourceStatus, isSourcePlaceholderOrMissing, isSourceStale } from "./sourceStatus";

function attachSources(
  sourceIds: string[],
  reference: Date
): Array<Source & { computedStatus: SourceStatus }> {
  return sourceIds
    .map((id) => sourcesById.get(id))
    .filter((s): s is Source => Boolean(s))
    .map((s) => ({ ...s, computedStatus: getSourceStatus(s, reference) }));
}

export function generateChecklist(
  input: GenerateChecklistInput,
  reference: Date = new Date()
): GenerateChecklistOutput {
  const originState = statesById.get(input.originStateId);
  const destinationState = statesById.get(input.destinationStateId);
  const purpose = purposesById.get(input.purposeId);

  if (!originState) throw new Error(`Unknown origin state: ${input.originStateId}`);
  if (!destinationState)
    throw new Error(`Unknown destination state: ${input.destinationStateId}`);
  if (!purpose) throw new Error(`Unknown purpose: ${input.purposeId}`);

  const selectedCategories = new Set(input.selectedCategoryIds);
  const selectedFlags = new Set(input.selectedProfileFlags);

  // Filter checklist items based on the user's selections.
  const filtered = checklistItems.filter((item) => {
    if (!selectedCategories.has(item.categoryId)) return false;

    // Purpose match (or item applies to all purposes when list is empty).
    if (
      item.appliesToPurposes.length > 0 &&
      !item.appliesToPurposes.includes(input.purposeId)
    ) {
      return false;
    }

    // Profile-flag match: if item declares flags, at least one must match,
    // unless the user selected no flags at all (then we keep flag-tagged
    // items in to avoid empty results when users skip optional flags).
    if (item.appliesToProfileFlags.length > 0 && selectedFlags.size > 0) {
      const anyFlagMatches = item.appliesToProfileFlags.some((f) =>
        selectedFlags.has(f)
      );
      if (!anyFlagMatches) return false;
    }

    // State-specific items (none in MVP seed, but enforced for future data).
    if (item.originStateId && item.originStateId !== input.originStateId) {
      return false;
    }
    if (
      item.destinationStateId &&
      item.destinationStateId !== input.destinationStateId
    ) {
      return false;
    }

    return true;
  });

  // Attach sources with computed staleness.
  const withSources: ChecklistItemWithSources[] = filtered.map((item) => ({
    ...item,
    sources: attachSources(item.sourceIds, reference),
  }));

  // Group by category and sort within group by risk order.
  const grouped: Record<string, ChecklistItemWithSources[]> = {};
  for (const item of withSources) {
    (grouped[item.categoryId] ||= []).push(item);
  }
  for (const id of Object.keys(grouped)) {
    grouped[id].sort(
      (a, b) =>
        riskOrder.indexOf(a.riskLevel) - riskOrder.indexOf(b.riskLevel)
    );
  }

  // Sort category keys by category.sortOrder so the UI is stable.
  const orderedGrouped: Record<string, ChecklistItemWithSources[]> = {};
  for (const cat of categories) {
    if (grouped[cat.id]) orderedGrouped[cat.id] = grouped[cat.id];
  }

  // Risk counts across all visible items.
  const riskCounts: Record<RiskLevel, number> = {
    VERIFY_SEPARATELY: 0,
    HIGH: 0,
    MEDIUM: 0,
    LOW: 0,
  };
  for (const item of withSources) riskCounts[item.riskLevel]++;

  // Warnings derived from the result set.
  const warnings: string[] = [];

  const hasPlaceholder = withSources.some((i) =>
    i.sources.some((s) => isSourcePlaceholderOrMissing(s.computedStatus))
  );
  if (hasPlaceholder) {
    warnings.push(
      "Some checklist items use placeholder sources. Replace with official sources before relying on them."
    );
  }

  const hasStale = withSources.some((i) =>
    i.sources.some((s) => isSourceStale(s.computedStatus))
  );
  if (hasStale) {
    warnings.push(
      "Some sources have not been verified recently. Check the official website before relying on them."
    );
  }

  if (riskCounts.VERIFY_SEPARATELY > 0) {
    warnings.push(
      "High-risk categories require separate verification. MoveSafe does not determine whether possession, transportation, or use of regulated items is lawful."
    );
  }

  if (categoriesById.get("cat-high-risk")?.id && !selectedCategories.has("cat-high-risk")) {
    // Note when high-risk was not selected so the user knows it isn't covered.
  }

  warnings.push(
    "This checklist is not a legal conclusion. Verify with official sources and consult a licensed professional where appropriate."
  );

  if (input.originStateId === input.destinationStateId) {
    warnings.unshift(
      "Origin and destination are the same. MoveSafe is designed for state-to-state moves — some items may not apply."
    );
  }

  return {
    originState,
    destinationState,
    purpose,
    groupedItems: orderedGrouped,
    riskCounts,
    warnings,
    totalItems: withSources.length,
  };
}

// Helper: how many unique sources exist across the result set.
export function getUniqueSources(
  grouped: Record<string, ChecklistItemWithSources[]>
): Array<Source & { computedStatus: SourceStatus }> {
  const map = new Map<string, Source & { computedStatus: SourceStatus }>();
  for (const items of Object.values(grouped)) {
    for (const item of items) {
      for (const s of item.sources) {
        if (!map.has(s.id)) map.set(s.id, s);
      }
    }
  }
  return Array.from(map.values());
}

export { sources };
