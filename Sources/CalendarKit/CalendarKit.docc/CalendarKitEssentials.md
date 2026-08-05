# CalendarKit Essentials

Use `CalendarKit` to assemble custom calendar UIs from small SwiftUI pieces.

## Overview

The package focuses on a few core responsibilities:

- Rendering weekday labels in calendar order
- Rendering a month grid from a calendar month value
- Providing lightweight helpers for layout and grid minimization

`CalendarKit` is intended to be composable. It does not need to own every scroll container or final screen-level experience.

## Typical Composition

A common month view composition looks like this:

```swift
VStack(spacing: 16) {
  WeekdayLabels(using: calendar)
  DaysOfMonthGrid(month: month) { day in
    DefaultDayView(day: day, selectedDate: selectedDate, calendar: calendar)
  }
}
```

`DaysOfMonthGrid` supplies a `Day` for every visible cell, including overflow
days from adjacent months. Use `day.ignored` to style or disable those cells.

## Adding Selection

Keep selection state in the containing view and update it from each day cell:

```swift
@State private var selectedDate: Date?

DaysOfMonthGrid(month: month) { day in
  DefaultDayView(
    day: day,
    selectedDate: selectedDate,
    calendar: month.calendar
  )
  .onTapGesture {
    selectedDate = day.date
  }
  .allowsHitTesting(!day.ignored)
}
```

The grid owns layout, while your container owns interaction and state. This
keeps custom selection rules and accessibility behavior under your control.

## Relationship To CalendarUI

Use `CalendarKit` when you want to build your own calendar layout.

Use `CalendarUI` when you want ready-made, opinionated views built on top of these primitives.
