//
//  CalendarPeriodsExtensions.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import Foundation

public extension Calendar {
  /// Returns the calendar month containing the supplied date.
  func month(from date: Date) -> CalendarMonth {
    CalendarMonth(containing: date, calendar: self)
  }

  /// Returns the calendar week containing the supplied date.
  func week(from date: Date) -> CalendarWeek {
    CalendarWeek(containing: date, calendar: self)
  }

  /// Returns the calendar day containing the supplied date.
  func day(from date: Date) -> CalendarDay {
    CalendarDay(containing: date, calendar: self)
  }
}
