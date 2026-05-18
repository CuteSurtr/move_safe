import clsx from "clsx";
import { riskDescriptions, riskLabels } from "../../lib/constants";
import type { RiskLevel } from "../../lib/types";

const orderedLevels: RiskLevel[] = [
  "VERIFY_SEPARATELY",
  "HIGH",
  "MEDIUM",
  "LOW",
];

const accentBorders: Record<RiskLevel, string> = {
  LOW: "border-slate-200",
  MEDIUM: "border-blue-200",
  HIGH: "border-orange-200",
  VERIFY_SEPARATELY: "border-rose-200",
};

const accentNumbers: Record<RiskLevel, string> = {
  LOW: "text-slate-700",
  MEDIUM: "text-blue-700",
  HIGH: "text-orange-700",
  VERIFY_SEPARATELY: "text-rose-700",
};

export function RiskOverviewCards({
  counts,
}: {
  counts: Record<RiskLevel, number>;
}) {
  return (
    <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
      {orderedLevels.map((level) => (
        <div
          key={level}
          className={clsx(
            "rounded-lg border bg-white px-4 py-3",
            accentBorders[level]
          )}
        >
          <p
            className={clsx(
              "text-2xl font-semibold tabular-nums",
              accentNumbers[level]
            )}
          >
            {counts[level]}
          </p>
          <p className="mt-1 text-sm font-medium text-slate-900">
            {riskLabels[level]}
          </p>
          <p className="mt-0.5 text-xs text-slate-600">
            {riskDescriptions[level]}
          </p>
        </div>
      ))}
    </div>
  );
}
