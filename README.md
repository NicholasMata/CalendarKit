<p align="center">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="Sources/CalendarKit/CalendarKit.docc/Resources/calendar-kit-card~dark.png"
    >
    <img
      src="Sources/CalendarKit/CalendarKit.docc/Resources/calendar-kit-card.png"
      alt="Composable CalendarKit interface components"
    >
  </picture>
</p>

# CalendarKit

[![Swift](https://img.shields.io/badge/Swift-6.0-orange?style=flat-square)](https://www.swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_17%2B_%7C_macOS_15%2B-blue?style=flat-square)](#requirements)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](#installation)
[![Documentation](https://img.shields.io/badge/Documentation-DocC-blue?style=flat-square)](https://nicholasmata.github.io/CalendarKit/documentation/)
[![Deploy DocC](https://github.com/NicholasMata/CalendarKit/actions/workflows/deploy-docc.yml/badge.svg)](https://github.com/NicholasMata/CalendarKit/actions/workflows/deploy-docc.yml)

CalendarKit is a layered Swift package for building calendar experiences on
Apple platforms. It separates calendar-aware date modeling from SwiftUI layout
so you can use the Foundation utilities on their own or compose a custom
calendar interface from reusable views.

CalendarKit currently provides:

- Calendar-aware day, week, and month values
- Period navigation and month-grid calculations that respect the configured
  calendar
- Localized weekday labels ordered by `Calendar.firstWeekday`
- A generic seven-column SwiftUI month grid
- Default selectable day cells and month-grid layout helpers
- A modifier for collapsing a month grid toward a selected week

## Documentation

Browse the complete API reference and guides on the
[CalendarKit documentation site](https://nicholasmata.github.io/CalendarKit/documentation/).
The site combines all three package modules into one searchable DocC archive.

## Package Structure

The package is organized into three layers:

- **CalendarExtensions** provides Foundation-only period models, calendar math,
  and date utilities. It has no SwiftUI dependency.
- **CalendarKit** provides composable SwiftUI building blocks such as
  `WeekdayLabels`, `DaysOfMonthGrid`, and `DefaultDayView`.
- **CalendarUI** is reserved for higher-level, opinionated calendar experiences
  built from CalendarKit. It does not currently expose a public view.

Use `CalendarExtensions` for calendar-domain logic or import both
`CalendarExtensions` and `CalendarKit` when building a custom interface.

## Requirements

- Swift 6.0 or later
- iOS 17 or later
- macOS 15 or later

## Installation

In Xcode:

1. Open your app project.
2. Choose **File → Add Package Dependencies**.
3. Enter the repository URL:

   ```text
   https://github.com/NicholasMata/CalendarKit.git
   ```

4. Set the dependency rule to **Branch** and enter `main`. The package does not
   publish tagged releases yet.
5. Add `CalendarKit` and `CalendarExtensions` to your app target.

Import `CalendarKit` for the SwiftUI components and `CalendarExtensions` for
calendar period values and utilities. `CalendarUI` currently has no public
views, so most apps do not need to add that product yet.

## Quick Start

Create a calendar month and provide the content for each visible day:

```swift
import CalendarExtensions
import CalendarKit
import SwiftUI

struct MonthExample: View {
  @State private var selectedDate: Date?

  private let calendar = Calendar.current

  var body: some View {
    let month = CalendarMonth(containing: .now, calendar: calendar)

    VStack(spacing: 16) {
      WeekdayLabels(using: calendar)

      DaysOfMonthGrid(month: month) { day in
        DefaultDayView(
          day: day,
          selectedDate: selectedDate,
          calendar: calendar
        )
        .onTapGesture {
          selectedDate = day.date
        }
        .allowsHitTesting(!day.ignored)
      }
    }
  }
}
```

`DaysOfMonthGrid` includes the leading and trailing dates needed to render
complete weeks. Those cells have `day.ignored == true`, allowing you to hide,
dim, or disable them according to your interface's selection rules.

## Building the Documentation

Generate the combined DocC archive and static site locally:

```sh
DOCC_HOSTING_BASE_PATH="" zsh ./docs/build-docc-site.sh
python3 -m http.server 8080 --directory .build/docc/site
```

Open <http://localhost:8080/documentation/>. More details are available in
[docs/README.md](docs/README.md).

The [Deploy DocC workflow](.github/workflows/deploy-docc.yml) publishes the
same merged site to GitHub Pages when documentation-related files change on
`main`.
