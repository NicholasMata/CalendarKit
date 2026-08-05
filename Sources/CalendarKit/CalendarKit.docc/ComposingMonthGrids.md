# Composing Month Grids

`DaysOfMonthGrid` is the primary month-grid primitive in `CalendarKit`.

## Overview

`DaysOfMonthGrid` renders a seven-column calendar grid for a single month, including leading and trailing days from adjacent months when needed.

The view takes a calendar month value and a content closure:

```swift
DaysOfMonthGrid(month: month) { day in
  DefaultDayView(day: day, selectedDate: selectedDate, calendar: month.calendar)
}
```

This approach keeps the grid generic while allowing the caller to decide how each day cell should look and behave.

The grid always produces complete weeks. Leading and trailing cells have
`day.ignored == true`; they remain available so custom content can dim adjacent
dates or replace them with transparent placeholders.

## Layout Helpers

Use ``MonthGridUtil`` to compute the height of a month grid for a known day height.

Use ``MinimizeDaysOfMonthGrid`` to animate a month grid toward a single visible week row.

The modifier expects `progress` in the range `0...1` and a zero-based week row.
Pass the same day height used by your custom cell when it differs from
``DefaultDayView/height``.
