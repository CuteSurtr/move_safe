import { Link, NavLink } from "react-router-dom";
import clsx from "clsx";

export function Header() {
  return (
    <header className="border-b border-slate-200 bg-white">
      <div className="container-page flex h-14 items-center justify-between">
        <Link to="/" className="flex items-center gap-2 no-underline">
          <span
            aria-hidden
            className="inline-flex h-7 w-7 items-center justify-center rounded-md bg-brand-700 text-white"
          >
            <svg
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="h-4 w-4"
            >
              <path d="M5 12l5 5L20 7" />
            </svg>
          </span>
          <span className="text-base font-semibold tracking-tight text-slate-900">
            MoveSafe
          </span>
        </Link>
        <nav className="flex items-center gap-1">
          <NavItem to="/" end>
            Home
          </NavItem>
          <NavItem to="/builder">Builder</NavItem>
        </nav>
      </div>
    </header>
  );
}

function NavItem({
  to,
  end,
  children,
}: {
  to: string;
  end?: boolean;
  children: React.ReactNode;
}) {
  return (
    <NavLink
      to={to}
      end={end}
      className={({ isActive }) =>
        clsx(
          "rounded-md px-3 py-1.5 text-sm font-medium no-underline transition",
          isActive
            ? "bg-brand-50 text-brand-800"
            : "text-slate-600 hover:bg-slate-100 hover:text-slate-900"
        )
      }
    >
      {children}
    </NavLink>
  );
}
