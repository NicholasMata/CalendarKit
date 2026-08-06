//
//  MonthGridDay.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 8/5/26.
//

import CalendarExtensions

/// A resolved calendar day together with its context in a rendered month grid.
public struct MonthGridDay: Identifiable {
  /// The calendar day represented by the cell.
  public let calendarDay: CalendarDay

  /// Whether the day falls outside the month being rendered.
  public let isOutsideMonth: Bool

  /// The stable identity of the represented calendar day.
  public var id: CalendarDay.ID {
    calendarDay.id
  }

  /// Creates a month-grid day with explicit display context.
  ///
  /// - Parameters:
  ///   - day: The calendar day represented by the cell.
  ///   - isOutsideMonth: Whether the day falls outside the rendered month.
  public init(day: CalendarDay, isOutsideMonth: Bool = false) {
    self.calendarDay = day
    self.isOutsideMonth = isOutsideMonth
  }

  /// Creates a month-grid day and derives whether it falls outside a month.
  ///
  /// - Parameters:
  ///   - day: The calendar day represented by the cell.
  ///   - month: The month that owns the grid.
  public init(day: CalendarDay, month: CalendarMonth) {
    self.init(
      day: day,
      isOutsideMonth: CalendarMonth.ID(containing: day) != month.id
    )
  }

  static func visibleDays(in month: CalendarMonth) -> [Self] {
    (month.firstWeek.firstDay ... month.lastWeek.lastDay).map {
      Self(day: $0, month: month)
    }
  }
}
