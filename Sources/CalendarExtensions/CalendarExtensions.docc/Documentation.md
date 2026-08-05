# ``CalendarExtensions``

A Foundation-first package that provides calendar-aware domain models and date utilities for building calendar interfaces.

@Metadata {
  @PageImage(
    purpose: card,
    source: "calendar-extensions-card",
    alt: "A composed calendar interface with a selected date"
  )
  @PageImage(
    purpose: icon,
    source: "calendar-extensions-icon",
    alt: "CalendarExtensions"
  )
  @PageColor(green)
}

## Overview

`CalendarExtensions` contains the non-SwiftUI layer of the project.

Use this package when you need:

- Calendar-aware period models such as ``CalendarMonth``, ``CalendarWeek``, and ``CalendarDay``
- Utilities that respect `Calendar.firstWeekday`
- Foundation-level data models that can be shared by multiple UI implementations

The package is designed to support the SwiftUI layers above it without depending on SwiftUI itself.

Many of the utilities in this package exist specifically to support calendar interfaces that need to adapt to a calendar's configured first weekday. This affects:

- The ordering of weekday symbols
- The leading and trailing overflow days in a month grid
- The number of visible week rows in a month grid
- The boundaries used for week-based period values

Create values through a configured calendar so locale, time zone, and week
rules travel with the result:

```swift
var calendar = Calendar(identifier: .gregorian)
calendar.locale = Locale(identifier: "en_US")
calendar.timeZone = TimeZone(identifier: "America/Los_Angeles")!
calendar.firstWeekday = 2

let month = calendar.month(from: Date())
let visibleWeeks = month.numberOfWeeks
```

### Topics

#### Essentials

- <doc:WorkingWithCalendarPeriods>
- <doc:MonthGridCalculations>

#### Period Models

- ``CalendarMonth``
- ``CalendarWeek``
- ``CalendarDay``
- ``Day``

#### Calendar Utilities

- Creating days, weeks, and months from a configured `Calendar`
- Ordering localized weekday symbols by `Calendar.firstWeekday`
- Constructing dates from calendar components

#### Supporting Values

- ``CalendarMonth/ID``
- ``CalendarWeek/ID``
