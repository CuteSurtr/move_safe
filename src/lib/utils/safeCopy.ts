// Safe-copy rules for MoveSafe.
//
// MoveSafe is a source-first checklist and risk-awareness tool. It does not
// give legal advice and does not draw legal conclusions about specific
// situations.
//
// Any future content added to MoveSafe should follow these rules. The app
// should help users verify topics, not decide legal status.
//
// Allowed phrases:
//   - "Verify"
//   - "Check"
//   - "Review official sources"
//   - "May vary"
//   - "May apply"
//   - "Can depend on"
//   - "Rules differ by jurisdiction"
//   - "This checklist is not a legal conclusion"
//   - "Consult a licensed attorney"
//   - "Consult the relevant agency"
//   - "Do not assume"
//
// Avoid phrases in checklist or results copy:
//   - "Legal", "illegal", "allowed", "permitted", "prohibited"
//   - "Safe", "guaranteed"
//   - "You can" / "You cannot"
//   - "You should do X to avoid penalties"
//
// The word "legal information" is acceptable inside disclaimers, but
// checklist-item text should avoid sounding like a legal conclusion.

export const ALLOWED_PHRASES = [
  "verify",
  "check",
  "review official sources",
  "may vary",
  "may apply",
  "can depend on",
  "rules differ by jurisdiction",
  "this checklist is not a legal conclusion",
  "consult a licensed attorney",
  "consult the relevant agency",
  "do not assume",
];

export const AVOID_PHRASES = [
  "legal",
  "illegal",
  "allowed",
  "permitted",
  "prohibited",
  "safe",
  "guaranteed",
  "you can",
  "you cannot",
  "avoid penalties",
];

// Lightweight dev helper. Returns AVOID_PHRASES present in given text.
// Not enforced at runtime - intended as a manual review aid during seeding.
export function findUnsafePhrases(text: string): string[] {
  const lower = text.toLowerCase();
  return AVOID_PHRASES.filter((p) => lower.includes(p));
}
