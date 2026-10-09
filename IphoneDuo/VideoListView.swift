import SwiftUI

/// Reusable list, used by the home screen and as the second pane of the player.
struct VideoListView: View {
    var onSelect: (Video) -> Void

    var body: some View {
        List(Video.samples) { video in
            Button {
                onSelect(video)
            } label: {
                VStack(alignment: .leading) {
                    Text(video.title).font(.headline)
                    Text(video.subtitle).font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .tint(.primary)
        }
        .listStyle(.plain)
    }
}
