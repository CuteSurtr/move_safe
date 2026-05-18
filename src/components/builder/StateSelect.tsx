import { states } from "../../lib/data/states";

type Props = {
  id: string;
  label: string;
  value: string;
  onChange: (id: string) => void;
  required?: boolean;
  excludeId?: string;
};

export function StateSelect({
  id,
  label,
  value,
  onChange,
  required,
  excludeId,
}: Props) {
  return (
    <div>
      <label htmlFor={id} className="label">
        {label}
        {required && <span aria-hidden className="ml-0.5 text-rose-600">*</span>}
      </label>
      <select
        id={id}
        className="select mt-1"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        required={required}
      >
        <option value="">Select a state…</option>
        {states.map((s) => (
          <option key={s.id} value={s.id} disabled={s.id === excludeId}>
            {s.name}
          </option>
        ))}
      </select>
    </div>
  );
}
