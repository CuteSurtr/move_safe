import type { GenerateChecklistInput, ProfileFlag } from "../types";

// Encode/decode builder selections as URL search params so results pages are
// shareable and refreshable.
export function encodeBuilderInput(input: GenerateChecklistInput): string {
  const params = new URLSearchParams();
  params.set("origin", input.originStateId);
  params.set("destination", input.destinationStateId);
  params.set("purpose", input.purposeId);
  if (input.selectedCategoryIds.length) {
    params.set("categories", input.selectedCategoryIds.join(","));
  }
  if (input.selectedProfileFlags.length) {
    params.set("flags", input.selectedProfileFlags.join(","));
  }
  return params.toString();
}

export function decodeBuilderInput(
  search: string
): GenerateChecklistInput | null {
  const params = new URLSearchParams(search);
  const origin = params.get("origin");
  const destination = params.get("destination");
  const purpose = params.get("purpose");
  if (!origin || !destination || !purpose) return null;
  const categories = params.get("categories");
  const flags = params.get("flags");
  return {
    originStateId: origin,
    destinationStateId: destination,
    purposeId: purpose,
    selectedCategoryIds: categories ? categories.split(",").filter(Boolean) : [],
    selectedProfileFlags: flags
      ? (flags.split(",").filter(Boolean) as ProfileFlag[])
      : [],
  };
}
