//
//  Day.swift
//
//
//  Created by Nicholas Mata on 9/16/24.
//

import Foundation

/// A lightweight day value for use in calendar UI rendering.
///
/// `Day` is intentionally simpler than ``CalendarDay`` and is designed for display-focused
/// uses such as day cells in a month grid.
public struct Day: Hashable {
  /// The display string used for the day cell.
  public var shortSymbol: String
  /// The represented date.
  public var date: Date

  /// Indicates whether the day falls outside the primary month being rendered.
  public var ignored: Bool

  /// Creates a display-oriented day value.
  public init(shortSymbol: String, date: Date, ignored: Bool = false) {
    self.shortSymbol = shortSymbol
    self.date = date
    self.ignored = ignored
  }
  
  /// Creates a display-oriented day from a resolved calendar day.
  public init(day: CalendarDay, ignored: Bool = false) {
    self.init(shortSymbol: String(day.dayOfMonth), date: day.date, ignored: ignored)
  }
  
  /// Creates a display-oriented day and marks it as ignored when it falls outside the supplied month.
  public init(day: CalendarDay, month: CalendarMonth) {
    self.init(day: day, ignored: CalendarMonth.ID(day: day) != month.id)
  }
}
