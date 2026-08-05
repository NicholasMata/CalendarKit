import Foundation
import Testing

@testable import CalendarKit

@Test
@MainActor
func formatsWeekdayLabelsFromConfiguredFirstWeekday() {
  let calendar = gregorianCalendar(firstWeekday: 2)

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
  #expect(WeekdayLabels.weekdaySymbols(
    with: .short,
    using: calendar
  ) == ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"])
  #expect(WeekdayLabels.weekdaySymbols(
    with: .narrow,
    using: calendar
  ) == ["M", "T", "W", "T", "F", "S", "S"])
}
