# ``CalendarUI``

Opinionated SwiftUI calendar views built on top of `CalendarKit`.

@Metadata {
  @PageImage(
    purpose: card,
    source: "calendar-ui-card",
    alt: "A composed calendar interface with a selected date"
  )
  @PageImage(
    purpose: icon,
    source: "calendar-ui-icon",
    alt: "CalendarUI"
  )
  @PageColor(orange)
}

## Overview

`CalendarUI` is the highest-level layer in the project.

`CalendarUI` is reserved for ready-made calendar views rather than primitives
assembled by clients. The module does not currently expose a public view; use
`CalendarKit` for the available SwiftUI components while this layer evolves.

This package is the future home of full prebuilt calendar experiences that sit
above the lower-level `CalendarKit` building blocks.

### Topics

#### Essentials

- <doc:CalendarUIOverview>
