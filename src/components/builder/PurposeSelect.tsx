import { purposes } from "../../lib/data/purposes";

type Props = {
  id: string;
  value: string;
  onChange: (id: string) => void;
  required?: boolean;
};

export function PurposeSelect({ id, value, onChange, required }: Props) {
  return (
    <div>
      <label htmlFor={id} className="label">
        Purpose
        {required && <span aria-hidden className="ml-0.5 text-rose-600">*</span>}
      </label>
      <select
        id={id}
        className="select mt-1"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        required={required}
      >
        <option value="">Select a purpose…</option>
        {purposes.map((p) => (
          <option key={p.id} value={p.id}>
            {p.name}
          </option>
        ))}
      </select>
      {value && (
        <p className="helper mt-1">
          {purposes.find((p) => p.id === value)?.description}
        </p>
      )}
    </div>
  );
}
