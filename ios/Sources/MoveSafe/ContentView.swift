import SwiftUI

/// Navigation routes for the app's NavigationStack.
enum Route: Hashable {
    case builder
    case results
}

struct ContentView: View {
    @StateObject private var input = BuilderInputStore()
    @StateObject private var progress = ProgressStore()
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
    /// screenshots for the README — no effect under normal launch.
    private func applyScreenshotLaunchArgs() {
        let args = ProcessInfo.processInfo.arguments
        if args.contains("--screenshot-results") {
            input.loadExample()
            input.acceptedDisclaimer = true
            path = [.builder, .results]
        } else if args.contains("--screenshot-builder") {
            input.loadExample()
            input.acceptedDisclaimer = true
            path = [.builder]
        }
    }
}

#Preview {
    ContentView()
}
