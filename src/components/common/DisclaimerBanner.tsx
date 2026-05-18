import clsx from "clsx";
import { MAIN_DISCLAIMER, SHORT_DISCLAIMER } from "../../lib/constants";

type Props = {
  variant?: "full" | "short";
  tone?: "neutral" | "subtle";
  className?: string;
};

export function DisclaimerBanner({
  variant = "short",
  tone = "neutral",
  className,
}: Props) {
  const message = variant === "full" ? MAIN_DISCLAIMER : SHORT_DISCLAIMER;
  return (
    <div
      role="note"
      aria-label="Disclaimer"
      className={clsx(
        "rounded-md border px-4 py-3 text-sm",
        tone === "neutral"
          ? "border-amber-200 bg-amber-50 text-amber-900"
          : "border-slate-200 bg-slate-50 text-slate-700",
        className
      )}
    >
      <div className="flex items-start gap-2">
        <span aria-hidden className="mt-0.5">
          <svg
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="h-4 w-4"
          >
            <path d="M12 9v4" />
            <path d="M12 17h.01" />
            <path d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0Z" />
          </svg>
        </span>
        <p>{message}</p>
      </div>
    </div>
  );
}
