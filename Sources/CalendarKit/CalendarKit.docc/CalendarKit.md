# ``CalendarKit``

Composable SwiftUI building blocks for creating custom calendar interfaces.


@Metadata {
  @PageImage(
    purpose: card,
    source: "calendar-kit-card",
    alt: "A composed calendar interface with a selected date"
  )
  @PageImage(
    purpose: icon,
    source: "calendar-kit-icon",
    alt: "CalendarKit"
  )
  @PageColor(purple)
}

## Overview

`CalendarKit` sits above `CalendarExtensions` and provides reusable SwiftUI views that developers can compose into their own calendar experiences.

Use this package when you want:

- SwiftUI primitives for rendering calendar data
- Control over layout, composition, and interaction
- Building blocks rather than fully opinionated calendar screens

`CalendarKit` depends on `CalendarExtensions` for its domain models and date calculations.

### Topics

#### Essentials

- <doc:CalendarKitEssentials>
- <doc:ComposingMonthGrids>

#### Core Views

- ``WeekdayLabels``
- ``DaysOfMonthGrid``
- ``DefaultDayView``
- ``MonthGridUtil``
- ``MinimizeDaysOfMonthGrid``
