# CalendarKit Example

`CalendarKitExample` is a SwiftUI application that demonstrates CalendarKit components with deterministic sample data. Open `CalendarKitExample.xcodeproj` in Xcode and run the shared `CalendarKitExample` scheme.

The root screen is a scrollable `LazyVStack` containing links to each example:

- Single-day selection
- Multiple-day selection
- Range selection with individual and continuous styles
- A collapsible month grid
- Weekday label formats

## Run the UI tests

Select the `CalendarKitExample` scheme in Xcode and run its tests, or provide an installed Simulator destination on the command line:

```sh
xcodebuild \
  -project Example/CalendarKitExample.xcodeproj \
  -scheme CalendarKitExample \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  test
```

## Capture media

With the application running in Simulator, use Apple's `simctl` utility to capture a screenshot:

```sh
xcrun simctl io booted screenshot calendar-kit-example.png
```

Record a video and press Control-C when the demonstration is complete:

```sh
xcrun simctl io booted recordVideo calendar-kit-example.mov
```
