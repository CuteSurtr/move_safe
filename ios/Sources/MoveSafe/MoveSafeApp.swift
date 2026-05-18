import SwiftUI

@main
struct MoveSafeApp: App {
    @StateObject private var localeStore = LocaleStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(localeStore)
                .localizedFor(localeStore.effectiveLanguage)
                .onAppear {
                    L.currentLanguage = localeStore.effectiveLanguage
                }
                .onChange(of: localeStore.effectiveLanguage) { _, new in
                    L.currentLanguage = new
                }
        }
    }
}
