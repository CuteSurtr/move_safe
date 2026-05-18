import { SHORT_DISCLAIMER } from "../../lib/constants";

export function Footer() {
  return (
    <footer className="mt-16 border-t border-slate-200 bg-white">
      <div className="container-page py-6 text-xs text-slate-500">
        <p className="mb-2 font-medium text-slate-700">MoveSafe</p>
        <p>{SHORT_DISCLAIMER}</p>
        <p className="mt-2">
          MoveSafe is a general-information checklist and source-navigation
          tool. It is not a legal advice product and does not determine whether
          any specific conduct is lawful in any particular situation.
        </p>
      </div>
    </footer>
  );
}
