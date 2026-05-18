import type { Source, SourceStatus } from "../types";
import { daysSince, parseDate } from "./dateUtils";

// Staleness logic (spec section 20):
//   - No date:    MISSING
//   - Placeholder: PLACEHOLDER
//   - 0-90 days:   CURRENT
//   - 91-180:     REVIEW_RECOMMENDED
//   - 181-365:    POSSIBLY_OUTDATED
//   - 365+:       STALE
export function getSourceStatus(
  source: Pick<Source, "lastChecked" | "status">,
  reference: Date = new Date()
): SourceStatus {
  if (source.status === "PLACEHOLDER") return "PLACEHOLDER";
  if (source.status === "MISSING") return "MISSING";

  const date = parseDate(source.lastChecked);
  if (!date) return "MISSING";

  const days = daysSince(date, reference);
  if (days <= 90) return "CURRENT";
  if (days <= 180) return "REVIEW_RECOMMENDED";
  if (days <= 365) return "POSSIBLY_OUTDATED";
  return "STALE";
}

export function isSourceStale(status: SourceStatus): boolean {
  return (
    status === "REVIEW_RECOMMENDED" ||
    status === "POSSIBLY_OUTDATED" ||
    status === "STALE"
  );
}

export function isSourcePlaceholderOrMissing(status: SourceStatus): boolean {
  return status === "PLACEHOLDER" || status === "MISSING";
}
