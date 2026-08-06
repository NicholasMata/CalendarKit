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

@Test
func createsChronologicalClosedRangeInEitherDirection() {
  let calendar = testGregorianCalendar()
  let earlier = CalendarDay(
    containing: calendar.date(from: DateComponents(
      year: 2026,
      month: 8,
      day: 5
    ))!,
    calendar: calendar
  )
  let later = earlier.advanced(by: 7)

  #expect(earlier.closedRange(to: later) == earlier ... later)
  #expect(later.closedRange(to: earlier) == earlier ... later)
  #expect(earlier.closedRange(to: earlier) == earlier ... earlier)
}
