import clsx from "clsx";
import { riskLabels } from "../../lib/constants";
import type { RiskLevel } from "../../lib/types";

const styles: Record<RiskLevel, string> = {
  LOW: "bg-slate-100 text-slate-700 border-slate-200",
  MEDIUM: "bg-blue-50 text-blue-800 border-blue-200",
  HIGH: "bg-orange-50 text-orange-800 border-orange-200",
  VERIFY_SEPARATELY: "bg-rose-50 text-rose-800 border-rose-200",
};

const dotStyles: Record<RiskLevel, string> = {
  LOW: "bg-slate-400",
  MEDIUM: "bg-blue-500",
  HIGH: "bg-orange-500",
  VERIFY_SEPARATELY: "bg-rose-500",
};

export function RiskBadge({
  level,
  className,
}: {
  level: RiskLevel;
  className?: string;
}) {
  return (
    <span
      className={clsx(
        "inline-flex items-center gap-1.5 rounded-full border px-2.5 py-0.5 text-xs font-medium",
        styles[level],
        className
      )}
      aria-label={`Risk level: ${riskLabels[level]}`}
    >
      <span
        aria-hidden
        className={clsx("h-1.5 w-1.5 rounded-full", dotStyles[level])}
      />
      {riskLabels[level]}
    </span>
  );
}
