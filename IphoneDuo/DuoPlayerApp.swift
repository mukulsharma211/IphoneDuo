import SwiftUI

@main
struct DuoPlayerApp: App {
    // Created once at the root so layout changes never touch the AVPlayer.
    @State private var playback = PlaybackController()

    var body: some Scene {
        WindowGroup {
            VideoListScreen()
                .environment(playback)
        }
    }
}
