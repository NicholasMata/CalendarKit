//
//  CalendarDay.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import Foundation

/// A resolved calendar day value derived from a specific `Calendar`.
///
/// `CalendarDay` normalizes its `date` to the start of day in the provided calendar and
/// stores commonly used day components for efficient reuse in higher-level UI code.
public struct CalendarDay: Strideable, Comparable, Hashable, Identifiable {
  public typealias Stride = Int

  /// The stable identity for the day, equal to ``date``.
  public let id: Date
  /// The start of the day represented by this value.
  public let date: Date
  /// The ordinal position of the day within its year, using the day calendar.
  public let dayOfYear: Int
  /// The day-of-month component for the represented date.
  public let dayOfMonth: Int
  /// The month component for the represented date.
  public let monthNumber: Int
  /// The year component for the represented date.
  public let year: Int
  /// The calendar used to derive this day value.
  public let calendar: Calendar

  /// Creates a day value for the day containing the provided date.
  ///
  /// - Parameters:
  ///   - date: Any date within the day to resolve.
  ///   - calendar: The calendar used to normalize and derive the day components.
  public init(containing date: Date, calendar: Calendar = Calendar.current) {
    let startDate = calendar.startOfDay(for: date)
    self.date = startDate
    self.dayOfYear = calendar.ordinality(of: .day, in: .year, for: startDate) ?? 0
    self.dayOfMonth = calendar.component(.day, from: startDate)
    self.monthNumber = calendar.component(.month, from: startDate)
    self.year = calendar.component(.year, from: startDate)
    self.calendar = calendar
    self.id = startDate
  }

  /// Returns a new day by advancing the receiver by the specified number of days.
  ///
  /// - Parameter n: The number of days to advance. Negative values move backward.
  public func advanced(by n: Int) -> CalendarDay {
    let nextDate = calendar.date(byAdding: .day, value: n, to: date) ?? date
    return CalendarDay(containing: nextDate, calendar: calendar)
  }

  /// Returns the number of whole calendar days from this day to another day.
  ///
  /// The result uses the receiver's calendar semantics.
  ///
  /// - Parameter other: The destination day.
  public func distance(to other: CalendarDay) -> Int {
    return calendar.dateComponents([.day], from: date, to: other.date).day ?? 0
  }

  /// Compares two day values by their normalized start dates.
  public static func < (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
    return lhs.date < rhs.date
  }
}
