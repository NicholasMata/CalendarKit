# Composing Month Grids

`DaysOfMonthGrid` is the primary month-grid primitive in `CalendarKit`.

## Overview

`DaysOfMonthGrid` renders a seven-column calendar grid for a single month, including leading and trailing days from adjacent months when needed.

The view takes a calendar month value and a content closure:

```swift
DaysOfMonthGrid(month: month) { cell in
  DefaultDayView(cell: cell, selectedDate: selectedDate)
}
```

This approach keeps the grid generic while allowing the caller to decide how each day cell should look and behave.

The grid always produces complete weeks. Leading and trailing cells have
`isOutsideMonth == true`; they remain available so custom content can dim
adjacent dates or replace them with transparent placeholders.

## Layout Helpers

Use ``MonthGridUtil`` to compute the height of a month grid for a known day height.

Use ``MinimizeDaysOfMonthGrid`` to animate a month grid toward a single visible week row.

The modifier expects `progress` in the range `0...1` and a zero-based week row.
Both the grid and minimization modifier read their row height from the same
environment value. Set a custom height on the complete composition:

```swift
DaysOfMonthGrid(month: month) { cell in
  DefaultDayView(cell: cell, selectedDate: selectedDate)
}
.minimizeMonthGrid(progress: progress, toWeek: selectedWeek)
.monthGridDayHeight(48)
```

Apply `monthGridDayHeight(_:)` after `minimizeMonthGrid(progress:toWeek:)` so
the environment value reaches both the modifier and the grid. The default is
``MonthGridLayout/defaultDayHeight``.
