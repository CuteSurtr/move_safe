type Props = {
  eyebrow?: string;
  title: string;
  subtitle?: string;
};

export function SectionHeader({ eyebrow, title, subtitle }: Props) {
  return (
    <div className="mb-4">
      {eyebrow && (
        <p className="text-xs font-semibold uppercase tracking-wide text-brand-700">
          {eyebrow}
        </p>
      )}
      <h2 className="text-xl font-semibold tracking-tight text-slate-900">
        {title}
      </h2>
      {subtitle && (
        <p className="mt-1 text-sm text-slate-600">{subtitle}</p>
      )}
    </div>
  );
}
