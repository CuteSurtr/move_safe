import SwiftUI

/// Navigation routes for the app's NavigationStack.
enum Route: Hashable {
    case builder
    case results
}

struct ContentView: View {
    @StateObject private var input = BuilderInputStore()
    @StateObject private var progress = ProgressStore()
    @EnvironmentObject private var localeStore: LocaleStore
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            LandingView(path: $path)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .builder:
                        BuilderView(path: $path)
                    case .results:
                        ResultsView(path: $path)
                    }
                }
        }
        .environmentObject(input)
        .environmentObject(progress)
        .onAppear(perform: applyScreenshotLaunchArgs)
    }

    /// Deep-links the app to a specific screen when launched with a
    /// `--screenshot-*` argument. Used by tooling that captures simulator
    /// screenshots for the README - no effect under normal launch.
    ///
    /// `--screenshot-lang-<code>` (combinable with the screen flags) forces
    /// the app to render in that language regardless of device locale, so
    /// screenshot runs are reproducible. Codes: `en`, `es`, `ko`, `ja`,
    /// `zh-hans`, `zh-hant`, `wuu`.
    private func applyScreenshotLaunchArgs() {
        let args = ProcessInfo.processInfo.arguments
        let langMap: [(String, AppLanguage)] = [
            ("--screenshot-lang-en", .english),
            ("--screenshot-lang-es", .spanish),
            ("--screenshot-lang-ko", .korean),
            ("--screenshot-lang-ja", .japanese),
            ("--screenshot-lang-zh-hans", .simplifiedChinese),
            ("--screenshot-lang-zh-hant", .traditionalChinese),
            ("--screenshot-lang-wuu", .wuChinese),
        ]
        for (flag, lang) in langMap where args.contains(flag) {
            localeStore.preference = .override(lang)
            L.currentLanguage = lang
            break
        }
        if args.contains("--screenshot-results") {
            input.loadExample()
            input.acceptedDisclaimer = true
            path = [.builder, .results]
        } else if args.contains("--screenshot-builder") {
            input.loadExample()
            input.acceptedDisclaimer = true
            path = [.builder]
        } else if args.contains("--screenshot-dreamer-alert") {
            input.loadExample()
            input.acceptedDisclaimer = true
            input.selectedProfileFlags.remove(.dreamer)
            path = [.builder]
            // Insert the flag after BuilderView mounts so its onChange handler
            // fires and presents the alert for the screenshot.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                input.selectedProfileFlags.insert(.dreamer)
            }
        } else if args.contains("--screenshot-greencard-alert") {
            input.loadExample()
            input.acceptedDisclaimer = true
            input.selectedProfileFlags.remove(.greenCardHolder)
            path = [.builder]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                input.selectedProfileFlags.insert(.greenCardHolder)
            }
        } else if args.contains("--screenshot-visa-alert") {
            input.loadExample()
            input.acceptedDisclaimer = true
            input.selectedProfileFlags.remove(.visaHolder)
            path = [.builder]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                input.selectedProfileFlags.insert(.visaHolder)
            }
        }
    }
}

#Preview {
    ContentView()
}
