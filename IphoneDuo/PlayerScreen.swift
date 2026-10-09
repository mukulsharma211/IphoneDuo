import AVKit
import SwiftUI

struct PlayerScreen: View {
    let video: Video

    @Environment(PlaybackController.self) private var playback
    @Environment(\.horizontalSizeClass) private var hSize
    @Environment(\.verticalSizeClass) private var vSize
    @Environment(\.dismiss) private var dismiss
    @State private var isFullScreen = false

    private var showsOnlyPlayer: Bool { isFullScreen || vSize == .compact }

    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(showsOnlyPlayer ? .hidden : .automatic, for: .navigationBar)
            .overlay(alignment: .topLeading) {
                // The navigation bar is hidden while only the player shows, so offer a way back.
                if showsOnlyPlayer {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .padding()
                }
            }
            .onAppear { playback.play(video) }
            .onDisappear { playback.stop() }
    }

    @ViewBuilder
    private var content: some View {
        if showsOnlyPlayer {
            player.ignoresSafeArea()
        } else if hSize == .regular && vSize == .regular {
            GeometryReader { proxy in
                if let fold = proxy.reservedRegions(kind: .division).first {
                    // Half-folded: nothing crosses the fold.
                    VStack(spacing: 0) {
                        player.frame(height: fold.frame.minY)
                        Color.clear.frame(height: fold.frame.height)
                        list
                    }
                } else {
                    ArrangementView {
                        player
                    } secondary: {
                        list
                    }
                    .arrangementViewStyle(.split)
                }
            }
        } else {
            VStack(spacing: 0) {
                player.aspectRatio(16 / 9, contentMode: .fit)
                list.scrollContentBackground(.hidden)
            }
            .background(
                LinearGradient(colors: [.indigo.opacity(0.5), .purple.opacity(0.25), .clear],
                               startPoint: .top, endPoint: .bottom)
            )
        }
    }

    private var player: some View {
        VideoPlayer(player: playback.player)
            .overlay(alignment: .bottomTrailing) {
                // Landscape on a phone is already full screen; the button is for the other layouts.
                if vSize != .compact {
                    Button {
                        isFullScreen.toggle()
                    } label: {
                        Image(systemName: isFullScreen
                              ? "arrow.down.right.and.arrow.up.left"
                              : "arrow.up.left.and.arrow.down.right")
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .padding()
                }
            }
    }

    private var list: some View {
        VideoListView { playback.play($0) }
    }
}
