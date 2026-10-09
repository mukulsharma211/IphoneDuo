# DuoPlayer

Minimal SwiftUI sample showing how one video-player screen adapts on a regular
iPhone and on iPhone Duo (closed, open, rotated, half-folded) while the video
keeps playing. Layout comes only from size classes and the fold region, never
from device models or orientation.

## Layout per state

| State                 | Size classes            | Layout                                   |
|-----------------------|-------------------------|------------------------------------------|
| Closed, portrait      | compact W / regular H   | player on top, list below                |
| Closed, landscape     | compact H               | full-screen player only                  |
| Open, flat (any rot.) | regular W / regular H   | player + list, side by side or stacked   |
| Half-folded           | fold region is active   | player above the fold, list below it     |
| Open <-> close        | app moves displays      | playback continues, only layout changes  |

A regular iPhone only ever hits the first two rows.

## How playback survives

`PlaybackController` (`@MainActor @Observable`) owns the single `AVPlayer`. It is
created once with `@State` in `DuoPlayerApp` and injected with `.environment()`.
Views only host it in `VideoPlayer(player:)`, so layout changes never recreate it.

## Requirements

- Xcode 27.1, iOS 27.1 SDK, deployment target iOS 27.1
- No third-party dependencies

## Trying each state (Xcode Device Hub)

Run the app, then open **Window > Device Hub** and pick the simulator.

Regular iPhone simulator (e.g. iPhone 18 Pro):
1. Portrait: player on top, list below.
2. Rotate (Device Hub rotate controls): landscape shows the full-screen player only.

iPhone Duo simulator:
1. **Closed** (outer display): behaves like the regular iPhone; try portrait and landscape.
2. **Open**: inner display is regular x regular; player + list side by side. Rotate: the layout stays split/stacked.
3. **Half-folded**: set the hinge to a half-open posture. Player sits above the fold, list below it, nothing crosses it.
4. Switch closed <-> open while a video plays: the position carries on.
