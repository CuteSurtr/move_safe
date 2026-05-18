type Props = {
  title: string;
  description?: string;
  action?: React.ReactNode;
};

export function EmptyState({ title, description, action }: Props) {
  return (
    <div className="card flex flex-col items-center justify-center gap-2 px-6 py-10 text-center">
      <p className="text-base font-semibold text-slate-800">{title}</p>
      {description && (
        <p className="max-w-md text-sm text-slate-600">{description}</p>
      )}
      {action}
    </div>
  );
}
