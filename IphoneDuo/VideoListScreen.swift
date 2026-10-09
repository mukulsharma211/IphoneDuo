import SwiftUI

struct VideoListScreen: View {
    @State private var selected: Video?

    var body: some View {
        NavigationStack {
            VideoListView { selected = $0 }
                .navigationTitle("Videos")
                .navigationDestination(item: $selected) { video in
                    PlayerScreen(video: video)
                }
        }
    }
}
