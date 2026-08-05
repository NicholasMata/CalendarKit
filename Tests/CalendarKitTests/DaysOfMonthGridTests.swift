import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
@MainActor
func calculatesMonthGridHeightForFourAndSixWeekMonths() {
  let calendar = gregorianCalendar(firstWeekday: 1)
  let february = CalendarMonth(2, year: 2026, calendar: calendar)
  let august = CalendarMonth(8, year: 2026, calendar: calendar)

  #expect(february.numberOfWeeks == 4)
  #expect(MonthGridUtil.height(for: february, using: 48) == 192)
  #expect(MonthGridUtil.height(for: august, using: 48) == 288)
  #expect(MonthGridUtil.height(
    for: august.startDate,
    using: 48,
    calendar: calendar
  ) == 288)
}
