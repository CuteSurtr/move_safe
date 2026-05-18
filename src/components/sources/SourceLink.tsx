import { formatDate } from "../../lib/utils/dateUtils";
import type { Source, SourceStatus } from "../../lib/types";
import { SourceStatusBadge } from "./SourceStatusBadge";

type Props = {
  source: Source & { computedStatus: SourceStatus };
};

export function SourceLink({ source }: Props) {
  const isPlaceholderOrMissing =
    source.computedStatus === "PLACEHOLDER" ||
    source.computedStatus === "MISSING";

  return (
    <li className="rounded-md border border-slate-200 bg-white p-3">
      <div className="flex flex-wrap items-start justify-between gap-2">
        <div className="min-w-0">
          <p className="text-sm font-medium text-slate-900">{source.title}</p>
          {source.agencyName && (
            <p className="text-xs text-slate-600">{source.agencyName}</p>
          )}
        </div>
        <SourceStatusBadge status={source.computedStatus} />
      </div>
      <div className="mt-2 flex flex-wrap items-center gap-x-3 gap-y-1 text-xs text-slate-600">
        <span>
          Last verified:{" "}
          <span className="font-medium text-slate-800">
            {formatDate(source.lastChecked)}
          </span>
        </span>
        {!isPlaceholderOrMissing && source.url && source.url !== "#" ? (
          <a
            href={source.url}
            target="_blank"
            rel="noopener noreferrer"
            className="font-medium text-brand-700 hover:text-brand-800"
          >
            Open official source →
          </a>
        ) : (
          <span className="font-medium text-slate-500">
            Placeholder - replace with official source
          </span>
        )}
      </div>
      {source.notes && (
        <p className="mt-2 text-xs text-slate-500">{source.notes}</p>
      )}
    </li>
  );
}
