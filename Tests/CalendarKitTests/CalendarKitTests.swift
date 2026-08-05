import Foundation
import SwiftUI
import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
@MainActor
func formatsWeekdayLabelsFromConfiguredFirstWeekday() {
  var calendar = Calendar(identifier: .gregorian)
  calendar.locale = Locale(identifier: "en_US")
  calendar.firstWeekday = 2

  #expect(WeekdayLabels.weekdaySymbols(
    with: .abbreviated,
    using: calendar
  ) == ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
  #expect(WeekdayLabels.weekdaySymbols(
    with: .wide,
    using: calendar
  ) == [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday",
    "Sunday",
  ])
  #expect(WeekdayLabels.weekdaySymbols(
    with: .oneDigit,
    using: calendar
  ) == ["2", "3", "4", "5", "6", "7", "1"])
  #expect(WeekdayLabels.weekdaySymbols(
    with: .twoDigits,
    using: calendar
  ) == ["02", "03", "04", "05", "06", "07", "01"])
}

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
