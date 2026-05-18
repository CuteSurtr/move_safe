export function HighRiskWarning() {
  return (
    <div
      role="note"
      aria-label="High-risk warning"
      className="rounded-lg border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-900"
    >
      <p className="font-semibold">High-risk categories require separate verification.</p>
      <p className="mt-1 text-rose-900/90">
        Some items may be regulated differently across state lines and may
        involve state law, local ordinances, federal law, or agency rules.
        MoveSafe does not determine whether possession, transportation, or use
        is lawful in any specific situation. Verify directly with official
        sources and consult a licensed attorney or relevant agency if needed.
      </p>
    </div>
  );
}
