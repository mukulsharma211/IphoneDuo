import AVFoundation
import Observation

/// Owns the only AVPlayer in the app. Views never create players, so layout
/// changes (fold, unfold, rotate) cannot restart playback.
@MainActor @Observable
final class PlaybackController {
    let player = AVPlayer()
    private(set) var current: Video?

    func play(_ video: Video) {
        // Re-selecting the current video keeps the existing position.
        guard video != current else { return }
        current = video
        player.replaceCurrentItem(with: AVPlayerItem(url: video.url))
        player.play()
    }

    /// Closes the player when leaving the screen.
    func stop() {
        player.pause()
        player.replaceCurrentItem(with: nil)
        current = nil
    }
}
