import Foundation

struct Video: Identifiable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let url: URL

    static let samples: [Video] = [
        Video(id: 1, title: "Tears of Steel", subtitle: "HLS",
              url: URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!),
        Video(id: 2, title: "Bip Bop", subtitle: "fMP4 HLS",
              url: URL(string: "https://hls-harbor-livepush.akamaized.net/live_cdn/nsqIStpj8PaG-Ev/emcQJ0pGpremocy/index.m3u8")!),
        Video(id: 3, title: "Tears of Steel", subtitle: "MP4 over HLS",
              url: URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!),
        Video(id: 4, title: "Akamai Live", subtitle: "Live HLS (test)",
              url: URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!),
        Video(id: 5, title: "Akamai Live", subtitle: "Live HLS (eight)",
              url: URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!),
    ]
}
