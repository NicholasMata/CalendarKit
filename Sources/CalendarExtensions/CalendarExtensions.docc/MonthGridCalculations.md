# Month Grid Calculations

`CalendarExtensions` includes helpers for building month grids that respect a calendar's `firstWeekday`.

## Overview

Month-grid calculations are used to derive:

- The number of week rows in a month grid
- Leading and trailing overflow days
- Ordered weekday labels for the current calendar configuration

The package exposes these calculations both as `Calendar` conveniences and as data derived by ``CalendarMonth``.

These calculations are calendar-sensitive. Changing `Calendar.firstWeekday` changes:

- Which weekday column appears first
- How many leading days are needed before the first day of the month
- Which trailing days are needed to complete the final row
- How many week rows the month grid occupies

## Using `CalendarMonth`

When you already have a month model, prefer using the resolved values on ``CalendarMonth``:

```swift
let month = CalendarMonth(containing: Date(), calendar: .current)
let weekCount = month.numberOfWeeks
let firstWeek = month.firstWeek
let lastWeek = month.lastWeek
```

Build the complete visible grid from the first and last resolved weeks:

```swift
let visibleDays = Array(month.firstWeek.firstDay ... month.lastWeek.lastDay)
```

Days outside the month are useful layout placeholders. Compare each day's
month and year with the resolved month when deciding whether to dim it, hide it,
or allow selection.
