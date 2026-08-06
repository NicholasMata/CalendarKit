import Foundation
import Testing

@testable import CalendarExtensions

@Test
func derivesContainingWeekFromDay() {
  let calendar = testGregorianCalendar(firstWeekday: 2)
  let day = CalendarDay(
    containing: calendar.date(from: DateComponents(
      year: 2026,
      month: 8,
      day: 5
    ))!,
    calendar: calendar
  )

  #expect(day.week == CalendarWeek(containing: day))
  #expect(day.week.firstDay.dayOfMonth == 3)
  #expect(day.week.lastDay.dayOfMonth == 9)
}
