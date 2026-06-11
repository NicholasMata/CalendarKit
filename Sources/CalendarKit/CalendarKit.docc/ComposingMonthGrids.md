# Composing Month Grids

`DaysOfMonthGrid` is the primary month-grid primitive in `CalendarKit`.

## Overview

`DaysOfMonthGrid` renders a seven-column calendar grid for a single month, including leading and trailing days from adjacent months when needed.

The view takes a ``CalendarMonth`` value and a content closure:

```swift
DaysOfMonthGrid(month: month) { day in
  DefaultDayView(day: day, selectedDate: selectedDate, calendar: month.calendar)
}
```

This approach keeps the grid generic while allowing the caller to decide how each day cell should look and behave.

## Layout Helpers

Use ``MonthGridUtil`` to compute the height of a month grid for a known day height.

Use ``MinimizeDaysOfMonthGrid`` to animate a month grid toward a single visible week row.
