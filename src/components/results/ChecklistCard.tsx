import { useState } from "react";
import { categoriesById } from "../../lib/data/categories";
import type { ChecklistItemWithSources } from "../../lib/types";
import { JurisdictionBadge } from "../badges/JurisdictionBadge";
import { RiskBadge } from "../badges/RiskBadge";
import { SourceLink } from "../sources/SourceLink";
import { StaleSourceWarning } from "../sources/StaleSourceWarning";

const orderForWarning = [
  "MISSING",
  "PLACEHOLDER",
  "STALE",
  "POSSIBLY_OUTDATED",
  "REVIEW_RECOMMENDED",
] as const;

export function ChecklistCard({
  item,
  defaultOpen = false,
}: {
  item: ChecklistItemWithSources;
  defaultOpen?: boolean;
}) {
  const [open, setOpen] = useState(defaultOpen);
  const category = categoriesById.get(item.categoryId);

  // Pick the most-concerning status across sources for the inline warning.
  const worst = item.sources
    .map((s) => s.computedStatus)
    .sort(
      (a, b) =>
        orderForWarning.indexOf(a as never) -
        orderForWarning.indexOf(b as never)
    )[0];

  const showInlineWarning =
    worst && (orderForWarning as readonly string[]).includes(worst);

  const contentId = `checklist-item-${item.id}-content`;

  return (
    <article className="card overflow-hidden">
      <button
        type="button"
        className="flex w-full items-start gap-3 px-4 py-3 text-left transition hover:bg-slate-50"
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        aria-controls={contentId}
      >
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <RiskBadge level={item.riskLevel} />
            <JurisdictionBadge type={item.jurisdictionType} />
            {category && (
              <span className="text-xs text-slate-500">{category.name}</span>
            )}
          </div>
          <h3 className="mt-1.5 text-base font-semibold text-slate-900">
            {item.title}
          </h3>
          <p className="mt-1 text-sm text-slate-600">{item.description}</p>
        </div>
        <span
          aria-hidden
          className={`mt-1 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-slate-100 text-slate-600 transition ${
            open ? "rotate-180" : ""
          }`}
        >
          <svg
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="h-3 w-3"
          >
            <path d="M6 9l6 6 6-6" />
          </svg>
        </span>
      </button>
      {open && (
        <div
          id={contentId}
          className="border-t border-slate-100 bg-slate-50/60 px-4 py-4"
        >
          <div className="space-y-4">
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Why this matters
              </p>
              <p className="mt-1 text-sm text-slate-800">{item.whyItMatters}</p>
            </div>
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                What to verify
              </p>
              <ul className="mt-1 list-disc space-y-1 pl-5 text-sm text-slate-800">
                {item.whatToVerify.map((p, i) => (
                  <li key={i}>{p}</li>
                ))}
              </ul>
            </div>
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Official sources
              </p>
              {item.sources.length === 0 ? (
                <p className="mt-1 rounded-md border border-slate-200 bg-white px-3 py-2 text-xs text-slate-600">
                  Official source needed before relying on this item.
                </p>
              ) : (
                <ul className="mt-2 space-y-2">
                  {item.sources.map((s) => (
                    <SourceLink key={s.id} source={s} />
                  ))}
                </ul>
              )}
              {showInlineWarning && (
                <div className="mt-2">
                  <StaleSourceWarning status={worst} />
                </div>
              )}
            </div>
            {item.safeLanguageNotes && (
              <p className="text-xs text-slate-500">
                Note for editors: {item.safeLanguageNotes}
              </p>
            )}
            <p className="text-xs text-slate-500">
              General information only. Verify with the relevant official
              source. Not legal advice.
            </p>
          </div>
        </div>
      )}
    </article>
  );
}
