import CalendarExtensions
import Foundation

/// The selection and horizontal connection state for a day in a selected range.
public struct DayRangeSelection: Equatable {
  /// Whether the range contains the day.
  public let isSelected: Bool

  /// Whether the selection connects to the preceding day in the same week row.
  public let connectsToPreviousDay: Bool

  /// Whether the selection connects to the following day in the same week row.
  public let connectsToNextDay: Bool

  /// Resolves range-selection context for a calendar day.
  ///
  /// Connections stop at the calendar's week boundaries so a range that spans
  /// multiple weeks renders as a separate continuous segment on each grid row.
  ///
  /// - Parameters:
  ///   - day: The day for which to resolve selection context.
  ///   - range: The selected inclusive range, or `nil` when there is no selection.
  public init(
    day: CalendarDay,
    range: ClosedRange<CalendarDay>?
  ) {
    guard let range, range.contains(day) else {
      isSelected = false
      connectsToPreviousDay = false
      connectsToNextDay = false
      return
    }

    let weekday = day.calendar.component(.weekday, from: day.date)
    let firstWeekday = day.calendar.firstWeekday
    let lastWeekday = ((firstWeekday + 5) % 7) + 1

    isSelected = true
    connectsToPreviousDay = weekday != firstWeekday
      && range.contains(day.advanced(by: -1))
    connectsToNextDay = weekday != lastWeekday
      && range.contains(day.advanced(by: 1))
  }

  /// Resolves range-selection context for a month-grid cell.
  public init(
    cell: MonthGridDay,
    range: ClosedRange<CalendarDay>?
  ) {
    self.init(day: cell.calendarDay, range: range)
  }
}
