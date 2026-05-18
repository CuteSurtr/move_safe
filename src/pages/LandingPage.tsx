import { Link } from "react-router-dom";
import { DisclaimerBanner } from "../components/common/DisclaimerBanner";

const exampleCategories = [
  "Driver's license",
  "Vehicle registration",
  "Auto insurance",
  "Housing / renter basics",
  "Pets",
  "Employment paperwork",
  "Professional licensure",
  "Nursing / healthcare licensure",
  "State residency basics",
  "Taxes / filing awareness",
  "Student relocation",
  "Healthcare access",
];

export default function LandingPage() {
  return (
    <div className="container-page">
      <section className="grid gap-8 py-6 sm:py-10 md:grid-cols-[1.4fr,1fr]">
        <div>
          <p className="text-xs font-semibold uppercase tracking-wide text-brand-700">
            Cross-state relocation checklist
          </p>
          <h1 className="mt-2 text-3xl font-semibold tracking-tight text-slate-900 sm:text-4xl">
            Moving across state lines? Know what to verify before you go.
          </h1>
          <p className="mt-4 text-base text-slate-700">
            Build a state-to-state checklist for licenses, vehicles, housing,
            pets, work, school, healthcare licensure, and other rules that may
            change when you move.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/builder" className="btn-primary no-underline">
              Build my checklist
            </Link>
            <Link to="/builder?example=1" className="btn-secondary no-underline">
              View example checklist
            </Link>
          </div>
          <p className="mt-5 max-w-xl text-sm text-slate-600">
            MoveSafe is a source-first checklist tool. It links you to official
            resources and highlights topics to verify. It does not provide
            legal advice.
          </p>
        </div>
        <div className="card flex flex-col gap-3 p-5">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            How it works
          </p>
          <ol className="space-y-3 text-sm text-slate-800">
            <li className="flex gap-2">
              <span className="mt-0.5 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-700 text-[11px] font-semibold text-white">
                1
              </span>
              <span>Choose your origin and destination state.</span>
            </li>
            <li className="flex gap-2">
              <span className="mt-0.5 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-700 text-[11px] font-semibold text-white">
                2
              </span>
              <span>Pick a purpose and the categories that apply.</span>
            </li>
            <li className="flex gap-2">
              <span className="mt-0.5 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-700 text-[11px] font-semibold text-white">
                3
              </span>
              <span>
                Get a grouped checklist with risk badges and links to official
                sources.
              </span>
            </li>
          </ol>
        </div>
      </section>

      <section className="grid gap-4 py-4 md:grid-cols-2">
        <div className="card p-5">
          <h2 className="text-base font-semibold text-slate-900">
            What MoveSafe does
          </h2>
          <ul className="mt-3 list-disc space-y-1.5 pl-5 text-sm text-slate-700">
            <li>Generates a checklist of topics to verify before moving</li>
            <li>Links to official state agency sources</li>
            <li>Flags risk levels so you know where to focus</li>
            <li>Highlights stale or placeholder sources</li>
            <li>Treats high-risk categories with a "Do not assume" label</li>
          </ul>
        </div>
        <div className="card p-5">
          <h2 className="text-base font-semibold text-slate-900">
            What MoveSafe does not do
          </h2>
          <ul className="mt-3 list-disc space-y-1.5 pl-5 text-sm text-slate-700">
            <li>Provide legal advice or attorney-client services</li>
            <li>Determine whether a specific act is lawful</li>
            <li>Decide your residency, eligibility, or tax status</li>
            <li>Help avoid enforcement or recommend workarounds</li>
            <li>Replace official agency or licensed-professional guidance</li>
          </ul>
        </div>
      </section>

      <section className="py-4">
        <h2 className="text-base font-semibold text-slate-900">
          Example checklist categories
        </h2>
        <div className="mt-3 flex flex-wrap gap-2">
          {exampleCategories.map((c) => (
            <span
              key={c}
              className="rounded-full border border-slate-200 bg-white px-3 py-1 text-xs font-medium text-slate-700"
            >
              {c}
            </span>
          ))}
        </div>
      </section>

      <section className="py-6">
        <DisclaimerBanner variant="full" tone="subtle" />
      </section>
    </div>
  );
}
