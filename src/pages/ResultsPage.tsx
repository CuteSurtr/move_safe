import { useMemo, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { DisclaimerBanner } from "../components/common/DisclaimerBanner";
import { EmptyState } from "../components/common/EmptyState";
import { ChecklistGroup } from "../components/results/ChecklistGroup";
import {
  FilterBar,
  type ResultFilters,
} from "../components/results/FilterBar";
import { HighRiskWarning } from "../components/results/HighRiskWarning";
import { ResultsSummary } from "../components/results/ResultsSummary";
import { RiskOverviewCards } from "../components/results/RiskOverviewCards";
import { COVERAGE_CAVEAT, RESULTS_INTRO_DISCLAIMER } from "../lib/constants";
import type { ChecklistItemWithSources, RiskLevel } from "../lib/types";
import { decodeBuilderInput } from "../lib/utils/builderQuery";
import {
  generateChecklist,
  getUniqueSources,
} from "../lib/utils/checklistEngine";
import { SourceLink } from "../components/sources/SourceLink";
import {
  isSourcePlaceholderOrMissing,
  isSourceStale,
} from "../lib/utils/sourceStatus";

export default function ResultsPage() {
  const location = useLocation();
  const input = useMemo(
    () => decodeBuilderInput(location.search),
    [location.search]
  );

  const [filters, setFilters] = useState<ResultFilters>({
    riskLevels: new Set<RiskLevel>(),
    highRiskOnly: false,
    staleOnly: false,
  });

  if (!input) {
    return (
      <div className="container-page">
        <EmptyState
          title="No checklist parameters found"
          description="Start by building a checklist from the builder page."
          action={
            <Link to="/builder" className="btn-primary mt-3 no-underline">
              Build my checklist
            </Link>
          }
        />
      </div>
    );
  }

  let result;
  try {
    result = generateChecklist(input);
  } catch (err) {
    return (
      <div className="container-page">
        <EmptyState
          title="Could not generate checklist"
          description={
            err instanceof Error
              ? err.message
              : "An unknown error occurred while generating the checklist."
          }
          action={
            <Link to="/builder" className="btn-primary mt-3 no-underline">
              Back to builder
            </Link>
          }
        />
      </div>
    );
  }

  // Apply UI filters to the engine output.
  const filteredGrouped: Record<string, ChecklistItemWithSources[]> = {};
  for (const [catId, items] of Object.entries(result.groupedItems)) {
    const filtered = items.filter((item) => {
      if (
        filters.riskLevels.size > 0 &&
        !filters.riskLevels.has(item.riskLevel)
      ) {
        return false;
      }
      if (filters.highRiskOnly && !item.isHighRisk && item.riskLevel !== "VERIFY_SEPARATELY") {
        return false;
      }
      if (filters.staleOnly) {
        const hasStale = item.sources.some(
          (s) =>
            isSourceStale(s.computedStatus) ||
            isSourcePlaceholderOrMissing(s.computedStatus)
        );
        if (!hasStale && item.sources.length > 0) return false;
        if (item.sources.length === 0 && !filters.staleOnly) return false;
      }
      return true;
    });
    if (filtered.length > 0) filteredGrouped[catId] = filtered;
  }

  const visibleItems = Object.values(filteredGrouped).flat();
  const uniqueSources = getUniqueSources(filteredGrouped);

  const hasHighRisk = visibleItems.some(
    (i) => i.riskLevel === "VERIFY_SEPARATELY" || i.isHighRisk
  );

  return (
    <div className="container-page space-y-6">
      <ResultsSummary
        origin={result.originState}
        destination={result.destinationState}
        purpose={result.purpose}
        totalItems={result.totalItems}
      />

      <DisclaimerBanner variant="short" />

      <section aria-label="Notes about this checklist" className="space-y-2">
        <p className="text-sm text-slate-700">{RESULTS_INTRO_DISCLAIMER}</p>
        <ul className="list-disc space-y-1 pl-5 text-xs text-slate-600">
          {result.warnings.map((w, i) => (
            <li key={i}>{w}</li>
          ))}
          <li>{COVERAGE_CAVEAT}</li>
        </ul>
      </section>

      <RiskOverviewCards counts={result.riskCounts} />

      {hasHighRisk && <HighRiskWarning />}

      <FilterBar filters={filters} onChange={setFilters} />

      {Object.keys(filteredGrouped).length === 0 ? (
        <EmptyState
          title="No items match your filters"
          description="Try clearing risk filters or the high-risk / stale-source toggles."
        />
      ) : (
        <div className="space-y-6">
          {Object.entries(filteredGrouped).map(([catId, items]) => (
            <ChecklistGroup key={catId} categoryId={catId} items={items} />
          ))}
        </div>
      )}

      <section aria-labelledby="sources-heading" className="pt-2">
        <h2
          id="sources-heading"
          className="text-base font-semibold text-slate-900"
        >
          Sources referenced in this checklist
        </h2>
        <p className="mt-1 text-xs text-slate-600">
          MoveSafe prefers official agency sources. Placeholder entries should
          be replaced with verified URLs before production use.
        </p>
        {uniqueSources.length === 0 ? (
          <p className="mt-3 text-sm text-slate-600">
            No sources are attached to the items in this view.
          </p>
        ) : (
          <ul className="mt-3 grid gap-2 sm:grid-cols-2">
            {uniqueSources.map((s) => (
              <SourceLink key={s.id} source={s} />
            ))}
          </ul>
        )}
      </section>

      <div className="flex flex-wrap gap-3 pt-4">
        <Link to="/builder" className="btn-secondary no-underline">
          Edit selections
        </Link>
        <Link to="/" className="btn-secondary no-underline">
          Back to home
        </Link>
      </div>

      <DisclaimerBanner variant="full" tone="subtle" className="mt-6" />
    </div>
  );
}
