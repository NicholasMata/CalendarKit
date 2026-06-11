//
//  CalendarWeek.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import Foundation

/// A resolved calendar week value derived from a specific `Calendar`.
///
/// `CalendarWeek` respects the source calendar's week rules, including `firstWeekday`
/// and `minimumDaysInFirstWeek`, when determining its boundaries and identifier.
public struct CalendarWeek: Strideable, Comparable, Hashable, Identifiable {
  /// A lightweight identifier for a calendar week.
  public struct ID: Hashable {
    /// The week-of-year component for the represented week.
    public let weekOfYear: Int
    /// The week-based year component for the represented week.
    public let yearForWeekOfYear: Int

    /// Creates a week identifier from week-of-year components.
    public init(weekOfYear: Int, yearForWeekOfYear: Int) {
      self.weekOfYear = weekOfYear
      self.yearForWeekOfYear = yearForWeekOfYear
    }

    /// Returns a new week identifier offset by the specified number of weeks.
    ///
    /// - Parameters:
    ///   - value: The number of weeks to add. Negative values move backward.
    ///   - calendar: The calendar used to interpret week boundaries.
    public func add(week value: Int, calendar: Calendar = .current) -> Self {
      CalendarWeek(id: self, calendar: calendar)
        .advanced(by: value)
        .id
    }
  }

  public typealias Stride = Int

  /// The stable identity for the week.
  public let id: ID
  /// The start of the represented week.
  public let startDate: Date
  /// The final instant contained in the represented week.
  public let endDate: Date
  /// The week-of-year component for the represented week.
  public let weekOfYear: Int
  /// The week-based year component for the represented week.
  public let yearForWeekOfYear: Int
  /// The first day contained in the represented week.
  public let firstDay: CalendarDay
  /// The last day contained in the represented week.
  public let lastDay: CalendarDay
  /// The calendar used to derive this week value.
  public let calendar: Calendar

  /// Creates a week value from a week identifier and calendar.
  public init(id: ID, calendar: Calendar = Calendar.current) {
    var components = DateComponents()
    components.weekOfYear = id.weekOfYear
    components.yearForWeekOfYear = id.yearForWeekOfYear

    guard let date = calendar.date(from: components) else {
      fatalError("Invalid week id components")
    }

    self.init(containing: date, calendar: calendar)
  }
  
  /// Creates a week value containing the supplied calendar day.
  public init(containing day: CalendarDay) {
    self.init(containing: day.date, calendar: day.calendar)
  }

  /// Creates a week value for the week containing the supplied date.
  ///
  /// - Parameters:
  ///   - date: Any date within the week to resolve.
  ///   - calendar: The calendar used to determine the week's boundaries.
  public init(containing date: Date, calendar: Calendar) {
    let interval = calendar.dateInterval(of: .weekOfYear, for: date)
    let startDate = interval?.start ?? calendar.startOfDay(for: date)
    let endDate = interval?.end.addingTimeInterval(-1) ?? startDate
    let weekOfYear = calendar.component(.weekOfYear, from: startDate)
    let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: startDate)

    self.startDate = startDate
    self.endDate = endDate
    self.weekOfYear = weekOfYear
    self.yearForWeekOfYear = yearForWeekOfYear
    self.firstDay = CalendarDay(containing: startDate, calendar: calendar)
    self.lastDay = CalendarDay(containing: endDate, calendar: calendar)
    self.calendar = calendar
    self.id = ID(weekOfYear: weekOfYear, yearForWeekOfYear: yearForWeekOfYear)
  }

  /// Returns a new week by advancing the receiver by the specified number of weeks.
  public func advanced(by n: Int) -> CalendarWeek {
    let nextDate = calendar.date(byAdding: .weekOfYear, value: n, to: startDate) ?? startDate
    return CalendarWeek(containing: nextDate, calendar: calendar)
  }

  /// Returns the number of whole calendar weeks from this week to another week.
  ///
  /// The result uses the receiver's calendar semantics.
  public func distance(to other: CalendarWeek) -> Int {
    return calendar.dateComponents([.weekOfYear], from: startDate, to: other.startDate).weekOfYear ?? 0
  }

  /// Compares two week values by their normalized start dates.
  public static func < (lhs: CalendarWeek, rhs: CalendarWeek) -> Bool {
    return lhs.startDate < rhs.startDate
  }
}
