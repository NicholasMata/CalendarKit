# CalendarUI Overview

`CalendarUI` is intended to become the layer for complete calendar views with
strong defaults. It currently contains no public views.

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

No drop-in view is available from `CalendarUI` yet. Compose an interface from
`CalendarKit` today, and adopt this module when its higher-level views become
public.
