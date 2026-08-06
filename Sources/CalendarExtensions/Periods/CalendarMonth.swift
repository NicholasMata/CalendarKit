//
//  CalendarMonth.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import Foundation

/// A resolved calendar month value derived from a specific `Calendar`.
///
/// `CalendarMonth` stores month-level boundaries, derived day and week values, and
/// grid-oriented facts such as the number of visible week rows in the month.
public struct CalendarMonth: Strideable, Comparable, Hashable, Identifiable {
  /// A lightweight identifier for a calendar month.
  public struct ID: Hashable {
    /// The month component for the represented month.
    public let monthNumber: Int
    /// The year component for the represented month.
    public let year: Int

    /// Creates a month identifier from month and year components.
    public init(monthNumber: Int, year: Int) {
      self.monthNumber = monthNumber
      self.year = year
    }

    /// Creates a month identifier from a calendar day.
    public init(day: CalendarDay) {
      self.init(monthNumber: day.monthNumber, year: day.year)
    }

    /// Returns a new month identifier offset by the specified number of months.
    ///
    /// - Parameters:
    ///   - value: The number of months to add. Negative values move backward.
    ///   - calendar: The calendar used to interpret month boundaries.
    public func add(month value: Int, calendar: Calendar = Calendar.current) -> Self {
      CalendarMonth(id: self, calendar: calendar)
        .advanced(by: value)
        .id
    }

    /// Returns a new month identifier offset by the specified number of years.
    ///
    /// - Parameters:
    ///   - value: The number of years to add. Negative values move backward.
    ///   - calendar: The calendar used to interpret month boundaries.
    public func add(year value: Int, calendar: Calendar = Calendar.current) -> Self {
      CalendarMonth(id: self, calendar: calendar)
        .advanced(by: value * 12)
        .id
    }
  }

  public typealias Stride = Int

  /// The stable identity for the month.
  public let id: ID
  /// The start of the represented month.
  public let startDate: Date
  /// The final instant contained in the represented month.
  public let endDate: Date
  /// The month component for the represented month.
  public let monthNumber: Int
  /// The number of visible week rows required to render the month as a month grid.
  public let numberOfWeeks: Int
  /// The number of days in the represented month.
  public let daysInMonth: Int
  /// The year component for the represented month.
  public let year: Int
  /// The first day contained in the represented month.
  public let firstDay: CalendarDay
  /// The last day contained in the represented month.
  public let lastDay: CalendarDay
  /// The first week touched by the represented month.
  public let firstWeek: CalendarWeek
  /// The last week touched by the represented month.
  public let lastWeek: CalendarWeek

  /// The calendar used to derive this month value.
  public let calendar: Calendar

  /// Creates a month value from a month identifier and calendar.
  public init(id: ID, calendar: Calendar = Calendar.current) {
    self.init(containing: .init(month: id.monthNumber, year: id.year, calendar: calendar), calendar: calendar)
  }

  /// Creates a month value from month and year components.
  public init(_ month: Int, year: Int, calendar: Calendar = Calendar.current) {
    self.init(containing: .init(month: month, year: year, calendar: calendar), calendar: calendar)
  }

  /// Creates a month value for the month containing the supplied date.
  ///
  /// - Parameters:
  ///   - date: Any date within the month to resolve.
  ///   - calendar: The calendar used to determine the month's boundaries and derived values.
  public init(containing date: Date, calendar: Calendar = Calendar.current) {
    let interval = calendar.dateInterval(of: .month, for: date)
    let startDate = interval?.start ?? calendar.startOfDay(for: date)
    let endDate = interval?.end.addingTimeInterval(-1) ?? startDate
    let monthNumber = calendar.component(.month, from: startDate)
    let year = calendar.component(.year, from: startDate)
    let firstDay = CalendarDay(containing: startDate, calendar: calendar)
    let lastDay = CalendarDay(containing: endDate, calendar: calendar)
    let firstWeek = CalendarWeek(containing: startDate, calendar: calendar)
    let lastWeek = CalendarWeek(containing: endDate, calendar: calendar)
    let daysInMonth = (firstDay...lastDay).count
    let numberOfWeeks = (firstWeek...lastWeek).count

    self.id = ID(monthNumber: monthNumber, year: year)
    self.startDate = startDate
    self.endDate = endDate
    self.monthNumber = monthNumber
    self.numberOfWeeks = numberOfWeeks
    self.daysInMonth = daysInMonth
    self.year = year
    self.firstDay = firstDay
    self.lastDay = lastDay
    self.firstWeek = firstWeek
    self.lastWeek = lastWeek

    self.calendar = calendar
  }

  /// Returns a new month by advancing the receiver by the specified number of months.
  public func advanced(by n: Int) -> CalendarMonth {
    let nextDate = calendar.date(byAdding: .month, value: n, to: startDate) ?? startDate
    return CalendarMonth(containing: nextDate, calendar: calendar)
  }

  /// Returns the number of whole calendar months from this month to another month.
  ///
  /// The result uses the receiver's calendar semantics.
  public func distance(to other: CalendarMonth) -> Int {
    return calendar.dateComponents([.month], from: startDate, to: other.startDate).month ?? 0
  }

  /// Returns the zero-based visible week-row index containing the supplied day.
  ///
  /// Leading and trailing days from adjacent months return an index when they appear
  /// in this month's visible grid. Days outside the visible grid return `nil`.
  ///
  /// - Parameter day: The day whose visible week-row index to find.
  public func weekIndex(containing day: CalendarDay) -> Int? {
    let week = CalendarWeek(containing: day.date, calendar: calendar)

    guard firstWeek <= week, week <= lastWeek else {
      return nil
    }

    return firstWeek.distance(to: week)
  }

  /// Compares two month values by their normalized start dates.
  public static func < (lhs: CalendarMonth, rhs: CalendarMonth) -> Bool {
    return lhs.startDate < rhs.startDate
  }
}
