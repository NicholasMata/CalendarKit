import Foundation
import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
func resolvesConnectionsWithinWeekRow() {
  let calendar = gregorianCalendar(firstWeekday: 1)
  let start = CalendarDay(
    containing: calendar.date(from: DateComponents(
      year: 2026,
      month: 8,
      day: 2
    ))!,
    calendar: calendar
  )
  let range = start.closedRange(to: start.advanced(by: 4))

  let first = DayRangeSelection(day: start, range: range)
  let middle = DayRangeSelection(day: start.advanced(by: 2), range: range)
  let last = DayRangeSelection(day: start.advanced(by: 4), range: range)

  #expect(first.isSelected)
  #expect(!first.connectsToPreviousDay)
  #expect(first.connectsToNextDay)
  #expect(middle.isSelected)
  #expect(middle.connectsToPreviousDay)
  #expect(middle.connectsToNextDay)
  #expect(last.isSelected)
  #expect(last.connectsToPreviousDay)
  #expect(!last.connectsToNextDay)
}

@Test
func breaksConnectionsAtWeekBoundaries() {
  let calendar = gregorianCalendar(firstWeekday: 1)
  let saturday = CalendarDay(
    containing: calendar.date(from: DateComponents(
      year: 2026,
      month: 8,
      day: 1
    ))!,
    calendar: calendar
  )
  let sunday = saturday.advanced(by: 1)
  let range = saturday.closedRange(to: sunday)

  #expect(!DayRangeSelection(day: saturday, range: range).connectsToNextDay)
  #expect(!DayRangeSelection(day: sunday, range: range).connectsToPreviousDay)
}

@Test
func leavesDaysOutsideRangeDisconnected() {
  let day = CalendarDay(
    containing: Date(timeIntervalSinceReferenceDate: 0),
    calendar: gregorianCalendar()
  )
  let selection = DayRangeSelection(
    day: day,
    range: day.advanced(by: 1).closedRange(to: day.advanced(by: 2))
  )

  #expect(!selection.isSelected)
  #expect(!selection.connectsToPreviousDay)
  #expect(!selection.connectsToNextDay)
}
