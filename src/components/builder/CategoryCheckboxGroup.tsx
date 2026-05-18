import { categories } from "../../lib/data/categories";

type Props = {
  selected: string[];
  onChange: (ids: string[]) => void;
};

export function CategoryCheckboxGroup({ selected, onChange }: Props) {
  const selectedSet = new Set(selected);

  function toggle(id: string) {
    const next = new Set(selectedSet);
    if (next.has(id)) next.delete(id);
    else next.add(id);
    onChange(Array.from(next));
  }

  return (
    <fieldset>
      <legend className="label">Categories</legend>
      <p className="helper mt-1">
        Select one or more. You can change these later.
      </p>
      <div className="mt-3 grid gap-2 sm:grid-cols-2">
        {categories.map((c) => {
          const isHighRisk = c.isHighRiskCategory;
          const checked = selectedSet.has(c.id);
          return (
            <label
              key={c.id}
              className={`flex cursor-pointer items-start gap-2 rounded-md border p-3 text-sm transition ${
                checked
                  ? "border-brand-400 bg-brand-50"
                  : "border-slate-200 bg-white hover:bg-slate-50"
              }`}
            >
              <input
                type="checkbox"
                className="mt-0.5 h-4 w-4 rounded border-slate-300 text-brand-700 focus:ring-brand-500"
                checked={checked}
                onChange={() => toggle(c.id)}
              />
              <span className="min-w-0">
                <span className="flex items-center gap-2">
                  <span className="font-medium text-slate-900">{c.name}</span>
                  {isHighRisk && (
                    <span className="inline-flex items-center rounded-full border border-rose-200 bg-rose-50 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-rose-800">
                      Do not assume
                    </span>
                  )}
                </span>
                <span className="mt-0.5 block text-xs text-slate-600">
                  {c.description}
                </span>
              </span>
            </label>
          );
        })}
      </div>
    </fieldset>
  );
}
