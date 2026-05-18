import type { Purpose, State } from "../../lib/types";

type Props = {
  origin: State;
  destination: State;
  purpose: Purpose;
  totalItems: number;
};

export function ResultsSummary({
  origin,
  destination,
  purpose,
  totalItems,
}: Props) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white px-5 py-4">
      <p className="text-xs font-semibold uppercase tracking-wide text-brand-700">
        Your checklist
      </p>
      <h1 className="mt-1 text-2xl font-semibold tracking-tight text-slate-900">
        Moving from {origin.name} to {destination.name}
      </h1>
      <p className="mt-1 text-sm text-slate-700">
        Purpose:{" "}
        <span className="font-medium text-slate-900">{purpose.name}</span>
      </p>
      <p className="mt-2 text-sm text-slate-600">
        {totalItems} {totalItems === 1 ? "topic" : "topics"} to verify before
        moving. This checklist is not a legal conclusion.
      </p>
    </div>
  );
}
