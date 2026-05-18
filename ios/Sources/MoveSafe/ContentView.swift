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
    }
}

#Preview {
    ContentView()
}
