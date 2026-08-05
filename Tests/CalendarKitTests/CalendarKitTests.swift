import Foundation
import SwiftUI
import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
@MainActor
func initializesWithResolvedPresentationState() {
  let view = DefaultDayView(
    isToday: false,
    isSelected: true,
    isDimmed: true
  ) {
    Text("1")
  }

  #expect(!view.isToday)
  #expect(view.isSelected)
  #expect(view.isDimmed)
}

@Test
@MainActor
func derivesSingleSelectionFromCalendarDays() {
  var calendar = Calendar(identifier: .gregorian)
  calendar.timeZone = TimeZone(secondsFromGMT: 0)!
  let dayDate = calendar.date(from: DateComponents(
    year: 2026,
    month: 8,
    day: 5
  ))!
  let selectedDate = calendar.date(byAdding: .hour, value: 12, to: dayDate)
  let day = MonthGridDay(
    day: CalendarDay(containing: dayDate, calendar: calendar)
  )

  let selectedView = DefaultDayView(
    cell: day,
    selectedDate: selectedDate
  )
  let unselectedView = DefaultDayView(
    cell: day,
    selectedDate: nil
  )

  #expect(selectedView.isSelected)
  #expect(!unselectedView.isSelected)
}
