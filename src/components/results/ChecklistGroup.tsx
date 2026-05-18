import { categoriesById } from "../../lib/data/categories";
import type { ChecklistItemWithSources } from "../../lib/types";
import { ChecklistCard } from "./ChecklistCard";

type Props = {
  categoryId: string;
  items: ChecklistItemWithSources[];
};

export function ChecklistGroup({ categoryId, items }: Props) {
  const category = categoriesById.get(categoryId);
  if (!category || items.length === 0) return null;

  return (
    <section aria-labelledby={`group-${categoryId}`}>
      <div className="mb-2 flex items-baseline justify-between">
        <h2
          id={`group-${categoryId}`}
          className="text-base font-semibold tracking-tight text-slate-900"
        >
          {category.name}
        </h2>
        <span className="text-xs text-slate-500">
          {items.length} {items.length === 1 ? "item" : "items"}
        </span>
      </div>
      {category.isHighRiskCategory && (
        <p className="mb-3 rounded-md border border-rose-200 bg-rose-50 px-3 py-2 text-xs text-rose-900">
          Do not assume rules from your origin state apply. Rules vary across
          state, local, and federal jurisdictions. Verify directly with
          official sources.
        </p>
      )}
      <div className="space-y-2.5">
        {items.map((item) => (
          <ChecklistCard key={item.id} item={item} />
        ))}
      </div>
    </section>
  );
}
