import clsx from "clsx";
import { sourceStatusLabels } from "../../lib/constants";
import type { SourceStatus } from "../../lib/types";

const styles: Record<SourceStatus, string> = {
  CURRENT: "bg-emerald-50 text-emerald-800 border-emerald-200",
  REVIEW_RECOMMENDED: "bg-amber-50 text-amber-800 border-amber-200",
  POSSIBLY_OUTDATED: "bg-orange-50 text-orange-800 border-orange-200",
  STALE: "bg-rose-50 text-rose-800 border-rose-200",
  PLACEHOLDER: "bg-slate-100 text-slate-700 border-slate-300 border-dashed",
  MISSING: "bg-slate-100 text-slate-700 border-slate-300 border-dashed",
};

export function SourceStatusBadge({
  status,
  className,
}: {
  status: SourceStatus;
  className?: string;
}) {
  return (
    <span
      className={clsx(
        "inline-flex items-center gap-1 rounded-full border px-2.5 py-0.5 text-xs font-medium",
        styles[status],
        className
      )}
      aria-label={`Source status: ${sourceStatusLabels[status]}`}
    >
      {sourceStatusLabels[status]}
    </span>
  );
}
