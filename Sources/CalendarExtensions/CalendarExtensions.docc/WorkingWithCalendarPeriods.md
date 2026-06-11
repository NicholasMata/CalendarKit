# Working With Calendar Periods

Use the period types in `CalendarExtensions` when you want explicit calendar-domain values instead of working directly with `Date`.

## Overview

The package provides three primary period models:

- ``CalendarDay`` for a single calendar day
- ``CalendarWeek`` for a calendar week
- ``CalendarMonth`` for a calendar month

Each type resolves its public values when it is created so it can be used efficiently in higher-level UI code.

When a period depends on week boundaries or month-grid layout, the resolved values reflect the `Calendar` used to create it, including that calendar's ``Calendar/firstWeekday`` setting.

## Creating Period Values

Create period values from a `Calendar` to ensure they use the correct calendar configuration:

```swift
let calendar = Calendar.current
let month = calendar.month(from: Date())
let week = calendar.week(from: Date())
let day = calendar.day(from: Date())
```

This is especially important when the user or app uses a non-default `firstWeekday`, because values such as ``CalendarWeek`` and ``CalendarMonth/numberOfWeeks`` depend on that configuration.

You can also construct period values from their identifiers:

```swift
let month = CalendarMonth(id: .init(monthNumber: 5, year: 2026), calendar: calendar)
let week = CalendarWeek(id: .init(weekOfYear: 21, yearForWeekOfYear: 2026), calendar: calendar)
```

## Choosing The Right Level

Use `CalendarDay` when rendering or selecting individual days.

Use `CalendarWeek` when working with week-based layouts or week navigation.

Use `CalendarMonth` when deriving month grids, month headers, or month-level navigation.
