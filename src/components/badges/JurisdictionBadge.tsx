import clsx from "clsx";
import { jurisdictionLabels } from "../../lib/constants";
import type { JurisdictionType } from "../../lib/types";

export function JurisdictionBadge({
  type,
  className,
}: {
  type: JurisdictionType;
  className?: string;
}) {
  return (
    <span
      className={clsx(
        "inline-flex items-center gap-1 rounded-full border border-slate-200 bg-white px-2.5 py-0.5 text-xs font-medium text-slate-700",
        className
      )}
      aria-label={`Jurisdiction: ${jurisdictionLabels[type]}`}
    >
      {jurisdictionLabels[type]}
    </span>
  );
}
