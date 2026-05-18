import { profileFlagLabels, profileFlagOrder } from "../../lib/constants";
import type { ProfileFlag } from "../../lib/types";

type Props = {
  selected: ProfileFlag[];
  onChange: (flags: ProfileFlag[]) => void;
};

export function ProfileFlagCheckboxGroup({ selected, onChange }: Props) {
  const selectedSet = new Set(selected);

  function toggle(flag: ProfileFlag) {
    const next = new Set(selectedSet);
    if (next.has(flag)) next.delete(flag);
    else next.add(flag);
    onChange(Array.from(next));
  }

  return (
    <fieldset>
      <legend className="label">Optional profile</legend>
      <p className="helper mt-1">
        Helps tailor the checklist. None of these flags create legal
        conclusions.
      </p>
      <div className="mt-3 grid gap-2 sm:grid-cols-2">
        {profileFlagOrder.map((flag) => {
          const checked = selectedSet.has(flag);
          return (
            <label
              key={flag}
              className={`flex cursor-pointer items-center gap-2 rounded-md border p-2.5 text-sm transition ${
                checked
                  ? "border-brand-400 bg-brand-50"
                  : "border-slate-200 bg-white hover:bg-slate-50"
              }`}
            >
              <input
                type="checkbox"
                className="h-4 w-4 rounded border-slate-300 text-brand-700 focus:ring-brand-500"
                checked={checked}
                onChange={() => toggle(flag)}
              />
              <span className="text-slate-800">{profileFlagLabels[flag]}</span>
            </label>
          );
        })}
      </div>
    </fieldset>
  );
}
