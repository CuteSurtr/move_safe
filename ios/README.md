# MoveSafe iOS

A native SwiftUI port of the MoveSafe MVP. It mirrors the web app's three screens (Landing, Builder, Results) and uses the same seed data, the same safe-copy rules, and the same staleness logic.

See the parent project's [README](../README.md) for the broader product and safety philosophy. The short version: MoveSafe is a source-first relocation checklist, not legal advice. The app's copy follows the rules documented in `Sources/MoveSafe/Utils/SafeCopy.swift` (mirrored from `src/lib/utils/safeCopy.ts` in the web codebase).

## Requirements

- macOS with Xcode 15 or 16 installed (Mac App Store)
- [xcodegen](https://github.com/yonaskolb/XcodeGen) to generate the Xcode project from `project.yml`

## Build and run

```sh
# from this directory:
brew install xcodegen        # one-time
xcodegen generate            # creates MoveSafe.xcodeproj
open MoveSafe.xcodeproj
```

Then choose an iOS Simulator (e.g. iPhone 15) in Xcode and press Run. Minimum deployment target is iOS 17.0.

## Folder structure

```
ios/
  project.yml                       xcodegen config
  Sources/MoveSafe/
    MoveSafeApp.swift               @main entry
    ContentView.swift               NavigationStack + routes
    Models/                         Enums + value types
    Data/                           Static seed data (states, purposes, categories, sources, items)
    Engine/                         ChecklistEngine, SourceStatusEngine, BuilderInputStore
    Utils/                          DateUtils, SafeCopy + Disclaimers
    Views/
      Landing/                      Landing screen
      Builder/                      Builder screen
      Results/                      Results screen + RiskOverview, FilterBar, ChecklistCard, etc.
      Components/                   Badges, banners, SourceLink, EmptyState, SectionHeader, Card
    Resources/Assets.xcassets/      AccentColor + AppIcon placeholder
```

## Data and connectivity

The app uses **local seed data only** - there is no network call, no backend, and no analytics.

Builder selections and per-item completion are persisted to `UserDefaults` so they survive app relaunch. Keys live in `Sources/MoveSafe/Engine/PersistenceKeys.swift`. The user can wipe selections via the Builder's overflow menu ("Reset all selections") and can wipe item-completion progress via the "Reset progress" button on the Results screen.

The seed in `Sources/MoveSafe/Data/` covers all 50 US states + DC. The 16 core checklist items match the web codebase exactly (same IDs, risk levels, source IDs, `lastChecked` dates). The iOS app has an additional 33 immigration-status items appended in a dedicated section of `ChecklistItems.swift` and surfaced when the user ticks the corresponding profile flag in the Builder:

- 12 items from the Dreamer / LPR research pass (`ios/research/dreamer_greencard_items.json`) - most apply to all three immigration profiles; two are LPR-only (Medicaid five-year bar, state-funded benefits).
- 21 items from the visa-holder research pass (`ios/research/visa_items.json`) - 15 federal-scope items covering USCIS AR-11, F-1/J-1 SEVIS reporting, OPT/STEM-OPT updates, H-1B LCA amendment (Matter of Simeio Solutions), L-1/O-1 worksite amendments, J-1 program-sponsor reporting, IRS substantial presence test, dual-status year, FICA exemption for F-1/J-1, Selective Service for nonimmigrants, ACA marketplace for lawfully-present non-citizens, Medicare / Medicaid eligibility nuances; 6 state-variation items covering DMV documents for nonimmigrants, REAL ID tied to I-94, license-renewal cycles tied to I-94, in-state tuition classification, professional licensing documentation (including NLC primary-state-of-residency), and state tax residency for nonresident aliens.

Each item lists 3-10 verified `.gov` source URLs. The dates on bound generic sources are deliberately spread across the staleness buckets so the UI demonstrates each `SourceStatus` (CURRENT / REVIEW_RECOMMENDED / POSSIBLY_OUTDATED / STALE / PLACEHOLDER / MISSING).

## Features

- **Three screens**: Landing → Builder → Results
- **Saved selections**: persisted across launches; Landing offers "Continue my checklist" when state is present
- **Item-level progress**: tap the circle on any checklist card to mark verified. Strikethrough + dim + progress bar at top of results.
- **Share**: top-right toolbar button on Results opens the iOS share sheet with a plain-text export of the checklist (title, items, what-to-verify, official source URLs, full disclaimer). Filters and the share sheet honor the current visible filtered view.
- **Filters**: by risk level, high-risk only, stale/placeholder sources only.
- **50 states**: every US state plus DC is selectable as origin or destination.
- **Localization**: ships in English and neutral US Spanish (es-419). Auto-detects the device language; user can override via Settings (gear icon, top-right of Landing).

## Localization

The app uses a custom translation layer (`Sources/MoveSafe/Localization/`) keyed by English source text. `L.t("...")` at every UI call site looks up the current effective language and returns the Spanish translation if available, falling back to English otherwise.

- `LocaleStore` is the source of truth for the active language. Reads from `Locale.current` by default; user override is persisted to `UserDefaults`.
- `TranslationsData_UI.swift` holds the UI chrome strings (button labels, screen titles, banners, alerts) - hand-curated.
- `TranslationsData_Enums.swift` holds RiskLevel/JurisdictionType/SourceType/SourceStatus/ProfileFlag labels and the four Disclaimers strings.
- `TranslationsData_Meta.swift`, `TranslationsData_Items.swift`, `TranslationsData_Sources.swift` are generated from the corresponding `meta_es.json` / `items_es.json` / `sources_es.json` artifacts (produced once by a translation pass; re-run the merge script to regenerate).
- US state names stay in English (proper nouns and identifiers).
- US agency abbreviations (USCIS, IRS, SEVIS, DSO, REAL ID, etc.) stay in English in both locales, consistent with how Spanish-language US-immigration content is typically written.
- Safe-copy rules apply in both languages; the CI lint scans for forbidden cognates (`ilegal`, `permitido`, `prohibido`, `garantizado`, `para evitar sanciones/multas`).

To add a third language later, add a new case to `AppLanguage`, drop in `TranslationsData_*_<lang>` tables, extend `Translations.swift`'s merge, and tighten the CI safe-copy lint with that language's forbidden cognates.

## Notes for editors

- All on-screen copy must follow the safe-copy rules. See `Sources/MoveSafe/Utils/SafeCopy.swift` for the allowed and avoided phrases.
- The disclaimer banner appears on every screen - do not remove.
- High-risk categories (firearms / cannabis / controlled substances / prescription transport) get "Do not assume" language and never receive a summary. They only direct users to official sources.
- The iOS codebase is intentionally separate from the web codebase (`../src/`). When updating seed data, update both.

## Out of scope (do not add without product review)

- User accounts / multi-device sync
- PDF export beyond what the system share sheet already offers
- Networking, telemetry, or admin tools
- Tactical guidance for any regulated item
- AI-generated legal advice or eligibility determinations
