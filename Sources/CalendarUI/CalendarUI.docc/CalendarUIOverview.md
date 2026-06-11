# CalendarUI Overview

`CalendarUI` is intended for developers who want complete calendar views with strong defaults.

## Overview

Where `CalendarKit` provides composable pieces like month grids and weekday labels, `CalendarUI` is the place for full experiences such as:

- monthly calendar screens
- weekly calendar screens
- date-picking views
- opinionated navigation and selection flows

This package should depend on `CalendarKit` for rendering primitives and on `CalendarExtensions` for calendar-domain models.

## Choosing Between Packages

Choose `CalendarExtensions` when you need only Foundation-level calendar logic.

Choose `CalendarKit` when you want to compose your own SwiftUI calendar layout.

Choose `CalendarUI` when you want a drop-in calendar experience with defaults already defined.
