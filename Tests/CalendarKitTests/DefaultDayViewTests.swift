import Foundation
import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
func derivesPresentationFromMonthGridDay() {
  let calendar = gregorianCalendar()
  let date = calendar.date(from: DateComponents(
    year: 2026,
    month: 8,
    day: 5
  ))!
  let cell = MonthGridDay(
    day: CalendarDay(containing: date, calendar: calendar),
    isOutsideMonth: true
  )
  let presentation = DefaultDayPresentation(
    cell: cell,
    isSelected: true,
    today: date
  )

  #expect(presentation == DefaultDayPresentation(
    isToday: true,
    isSelected: true,
    isDimmed: true
  ))
}

@Test
func derivesSingleSelectionFromCalendarDays() {
  let calendar = gregorianCalendar()
  let dayDate = calendar.date(from: DateComponents(
    year: 2026,
    month: 8,
    day: 5
  ))!
  let selectedDate = calendar.date(byAdding: .hour, value: 12, to: dayDate)
  let cell = MonthGridDay(
    day: CalendarDay(containing: dayDate, calendar: calendar),
    isOutsideMonth: true
  )
  let nextDay = calendar.date(byAdding: .day, value: 1, to: dayDate)!

  let selectedPresentation = DefaultDayPresentation(
    cell: cell,
    selectedDate: selectedDate,
    today: nextDay
  )
  let unselectedPresentation = DefaultDayPresentation(
    cell: cell,
    selectedDate: nil,
    today: nextDay
  )

  #expect(selectedPresentation == DefaultDayPresentation(
    isToday: false,
    isSelected: true,
    isDimmed: true
  ))
  #expect(!unselectedPresentation.isSelected)
}
