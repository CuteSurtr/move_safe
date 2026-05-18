import clsx from "clsx";
import { riskLabels } from "../../lib/constants";
import type { RiskLevel } from "../../lib/types";

export type ResultFilters = {
  riskLevels: Set<RiskLevel>;
  highRiskOnly: boolean;
  staleOnly: boolean;
};

type Props = {
  filters: ResultFilters;
  onChange: (next: ResultFilters) => void;
};

const allLevels: RiskLevel[] = ["VERIFY_SEPARATELY", "HIGH", "MEDIUM", "LOW"];

export function FilterBar({ filters, onChange }: Props) {
  function toggleLevel(level: RiskLevel) {
    const next = new Set(filters.riskLevels);
    if (next.has(level)) next.delete(level);
    else next.add(level);
    onChange({ ...filters, riskLevels: next });
  }

  return (
    <div className="rounded-lg border border-slate-200 bg-white p-3">
      <div className="flex flex-wrap items-center gap-3">
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Risk
          </span>
          {allLevels.map((level) => {
            const active = filters.riskLevels.has(level);
            return (
              <button
                key={level}
                type="button"
                onClick={() => toggleLevel(level)}
                className={clsx(
                  "rounded-full border px-3 py-1 text-xs font-medium transition",
                  active
                    ? "border-brand-500 bg-brand-50 text-brand-800"
                    : "border-slate-200 bg-white text-slate-700 hover:bg-slate-50"
                )}
                aria-pressed={active}
              >
                {riskLabels[level]}
              </button>
            );
          })}
        </div>
        <div className="ml-auto flex flex-wrap items-center gap-3">
          <label className="flex items-center gap-2 text-xs text-slate-700">
            <input
              type="checkbox"
              className="h-3.5 w-3.5 rounded border-slate-300 text-brand-700 focus:ring-brand-500"
              checked={filters.highRiskOnly}
              onChange={(e) =>
                onChange({ ...filters, highRiskOnly: e.target.checked })
              }
            />
            High-risk only
          </label>
          <label className="flex items-center gap-2 text-xs text-slate-700">
            <input
              type="checkbox"
              className="h-3.5 w-3.5 rounded border-slate-300 text-brand-700 focus:ring-brand-500"
              checked={filters.staleOnly}
              onChange={(e) =>
                onChange({ ...filters, staleOnly: e.target.checked })
              }
            />
            Stale or placeholder sources only
          </label>
        </div>
      </div>
    </div>
  );
}
