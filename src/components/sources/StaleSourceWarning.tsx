import type { SourceStatus } from "../../lib/types";

const COPY: Partial<Record<SourceStatus, string>> = {
  REVIEW_RECOMMENDED:
    "This source was checked more than 90 days ago. Review recommended.",
  POSSIBLY_OUTDATED:
    "This source has not been verified in more than six months. Check the official website before relying on it.",
  STALE:
    "This source has not been verified in more than a year. Treat as stale and verify directly with the official source.",
  PLACEHOLDER:
    "Placeholder source. Replace with an official source before relying on this item.",
  MISSING: "Official source needed before relying on this item.",
};

export function StaleSourceWarning({ status }: { status: SourceStatus }) {
  const message = COPY[status];
  if (!message) return null;
  return (
    <p
      role="note"
      className="rounded-md border border-amber-200 bg-amber-50 px-3 py-2 text-xs text-amber-900"
    >
      {message}
    </p>
  );
}
