//
//  DateExtensions.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/22/25.
//

import Foundation

extension Date {
  /// Creates a date from calendar components using the supplied calendar.
  ///
  /// - Parameters:
  ///   - day: The day component. Defaults to `1`.
  ///   - month: The month component. Defaults to `1`.
  ///   - year: The year component.
  ///   - calendar: The calendar used to resolve the date components.
  public init(day: Int = 1, month: Int = 1, year: Int, calendar: Calendar = Calendar.current) {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day

    guard let date = calendar.date(from: components) else {
      fatalError("Invalid date components")
    }
    self = date
  }
}
