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

The app uses **local seed data only** — there is no network call, no backend, and no analytics.

Builder selections and per-item completion are persisted to `UserDefaults` so they survive app relaunch. Keys live in `Sources/MoveSafe/Engine/PersistenceKeys.swift`. The user can wipe selections via the Builder's overflow menu ("Reset all selections") and can wipe item-completion progress via the "Reset progress" button on the Results screen.

The seed in `Sources/MoveSafe/Data/` covers all 50 US states + DC and matches the web codebase's checklist items exactly: same IDs, same risk levels, same source IDs, same `lastChecked` dates. The dates are deliberately spread across the staleness buckets so the UI demonstrates each `SourceStatus` (CURRENT / REVIEW_RECOMMENDED / POSSIBLY_OUTDATED / STALE / PLACEHOLDER / MISSING).

## Features

- **Three screens**: Landing → Builder → Results
- **Saved selections**: persisted across launches; Landing offers "Continue my checklist" when state is present
- **Item-level progress**: tap the circle on any checklist card to mark verified. Strikethrough + dim + progress bar at top of results.
- **Share**: top-right toolbar button on Results opens the iOS share sheet with a plain-text export of the checklist (title, items, what-to-verify, official source URLs, full disclaimer). Filters and the share sheet honor the current visible filtered view.
- **Filters**: by risk level, high-risk only, stale/placeholder sources only.
- **50 states**: every US state plus DC is selectable as origin or destination.

## Notes for editors

- All on-screen copy must follow the safe-copy rules. See `Sources/MoveSafe/Utils/SafeCopy.swift` for the allowed and avoided phrases.
- The disclaimer banner appears on every screen — do not remove.
- High-risk categories (firearms / cannabis / controlled substances / prescription transport) get "Do not assume" language and never receive a summary. They only direct users to official sources.
- The iOS codebase is intentionally separate from the web codebase (`../src/`). When updating seed data, update both.

## Out of scope (do not add without product review)

- User accounts / multi-device sync
- PDF export beyond what the system share sheet already offers
- Networking, telemetry, or admin tools
- Tactical guidance for any regulated item
- AI-generated legal advice or eligibility determinations
