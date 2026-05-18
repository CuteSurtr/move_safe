import { useMemo, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import { CategoryCheckboxGroup } from "../components/builder/CategoryCheckboxGroup";
import { ProfileFlagCheckboxGroup } from "../components/builder/ProfileFlagCheckboxGroup";
import { PurposeSelect } from "../components/builder/PurposeSelect";
import { StateSelect } from "../components/builder/StateSelect";
import { DisclaimerBanner } from "../components/common/DisclaimerBanner";
import { SectionHeader } from "../components/common/SectionHeader";
import type { ProfileFlag } from "../lib/types";
import { encodeBuilderInput } from "../lib/utils/builderQuery";

// Example pre-fill: California → Maryland for nursing school.
const EXAMPLE = {
  originStateId: "state-california",
  destinationStateId: "state-maryland",
  purposeId: "purpose-nursing-school",
  selectedCategoryIds: [
    "cat-drivers-license",
    "cat-vehicle-registration",
    "cat-auto-insurance",
    "cat-housing",
    "cat-nursing-healthcare",
    "cat-state-residency",
    "cat-student-relocation",
    "cat-healthcare-access",
  ],
  selectedProfileFlags: [
    "HAS_CAR",
    "RENTS_HOUSING",
    "MOVING_FOR_SCHOOL",
    "HEALTHCARE_STUDENT",
  ] as ProfileFlag[],
};

export default function BuilderPage() {
  const navigate = useNavigate();
  const [params] = useSearchParams();
  const startFromExample = params.get("example") === "1";

  const [origin, setOrigin] = useState(
    startFromExample ? EXAMPLE.originStateId : ""
  );
  const [destination, setDestination] = useState(
    startFromExample ? EXAMPLE.destinationStateId : ""
  );
  const [purpose, setPurpose] = useState(
    startFromExample ? EXAMPLE.purposeId : ""
  );
  const [categoryIds, setCategoryIds] = useState<string[]>(
    startFromExample ? EXAMPLE.selectedCategoryIds : []
  );
  const [flags, setFlags] = useState<ProfileFlag[]>(
    startFromExample ? EXAMPLE.selectedProfileFlags : []
  );
  const [acceptDisclaimer, setAcceptDisclaimer] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const errors = useMemo(() => {
    const errs: string[] = [];
    if (!origin) errs.push("Select an origin state.");
    if (!destination) errs.push("Select a destination state.");
    if (!purpose) errs.push("Select a purpose.");
    if (categoryIds.length === 0) errs.push("Select at least one category.");
    if (!acceptDisclaimer) errs.push("Please confirm the disclaimer to continue.");
    return errs;
  }, [origin, destination, purpose, categoryIds, acceptDisclaimer]);

  const sameStateNotice = origin && destination && origin === destination;

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSubmitted(true);
    if (errors.length > 0) return;
    const qs = encodeBuilderInput({
      originStateId: origin,
      destinationStateId: destination,
      purposeId: purpose,
      selectedCategoryIds: categoryIds,
      selectedProfileFlags: flags,
    });
    navigate(`/results?${qs}`);
  }

  return (
    <div className="container-page max-w-3xl">
      <SectionHeader
        eyebrow="Checklist builder"
        title="Build your relocation checklist"
        subtitle="Choose your origin and destination, your purpose, and the categories that apply. MoveSafe will generate a list of topics to verify before moving."
      />

      <DisclaimerBanner variant="short" tone="subtle" className="mb-6" />

      <form onSubmit={handleSubmit} className="space-y-6" noValidate>
        <div className="card p-5">
          <div className="grid gap-4 sm:grid-cols-2">
            <StateSelect
              id="origin-state"
              label="Origin state"
              value={origin}
              onChange={setOrigin}
              required
            />
            <StateSelect
              id="destination-state"
              label="Destination state"
              value={destination}
              onChange={setDestination}
              required
              excludeId={origin}
            />
          </div>
          {sameStateNotice && (
            <p className="mt-3 rounded-md border border-amber-200 bg-amber-50 px-3 py-2 text-xs text-amber-900">
              MoveSafe is designed for state-to-state moves. You can still
              build a checklist, but some items may not apply.
            </p>
          )}
          <div className="mt-4">
            <PurposeSelect
              id="purpose"
              value={purpose}
              onChange={setPurpose}
              required
            />
          </div>
        </div>

        <div className="card p-5">
          <CategoryCheckboxGroup
            selected={categoryIds}
            onChange={setCategoryIds}
          />
        </div>

        <div className="card p-5">
          <ProfileFlagCheckboxGroup selected={flags} onChange={setFlags} />
        </div>

        <div className="card p-5">
          <label className="flex items-start gap-2 text-sm text-slate-800">
            <input
              type="checkbox"
              className="mt-0.5 h-4 w-4 rounded border-slate-300 text-brand-700 focus:ring-brand-500"
              checked={acceptDisclaimer}
              onChange={(e) => setAcceptDisclaimer(e.target.checked)}
            />
            <span>
              I understand that MoveSafe provides general information and
              source links, not legal advice.
            </span>
          </label>
        </div>

        {submitted && errors.length > 0 && (
          <div
            role="alert"
            className="rounded-md border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-900"
          >
            <p className="font-semibold">Please fix the following:</p>
            <ul className="mt-1 list-disc pl-5">
              {errors.map((m, i) => (
                <li key={i}>{m}</li>
              ))}
            </ul>
          </div>
        )}

        <div className="flex flex-wrap items-center gap-3">
          <button type="submit" className="btn-primary">
            Generate checklist
          </button>
          <p className="text-xs text-slate-500">
            Your selections aren't saved or shared. The checklist is generated
            locally.
          </p>
        </div>
      </form>
    </div>
  );
}
