//
//  CalendarExtensions.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/22/25.
//
import Foundation

/// Extensions methods to Calendar which adhere to [Calendar.firstWeekday](https://developer.apple.com/documentation/foundation/calendar/2293656-firstweekday)
/// as some of the builtin Calendar's properties and methods do not.
public extension Calendar {
  /// Returns the given weekday symbols reordered to start with the calendar's `firstWeekday`.
  ///
  /// The input symbols are expected to be in Foundation weekday order, where index `0`
  /// represents Sunday, index `1` represents Monday, and so on. The returned array
  /// preserves the relative order of the symbols while rotating them so that the
  /// calendar's configured first weekday appears first.
  func orderedWeekdaySymbols(using symbols: [String]) -> [String] {
    guard symbols.indices.contains(firstWeekday - 1) else {
      return symbols
    }
    let startIndex = firstWeekday - 1
    return Array(symbols[startIndex...]) + Array(symbols[..<startIndex])
  }

  /// A list of standalone weekday names in this calendar, localized to the Calendar's `locale`,
  /// ordered according to the calendar's `firstWeekday`.
  var orderedStandaloneWeekdaySymbols: [String] {
    return self.orderedWeekdaySymbols(using: standaloneWeekdaySymbols)
  }

  /// A list of shorter-named standalone weekdays in this calendar, localized to the Calendar's `locale`,
  /// ordered according to the calendar's `firstWeekday`.
  var orderedShortStandaloneWeekdaySymbols: [String] {
    return self.orderedWeekdaySymbols(using: shortStandaloneWeekdaySymbols)
  }

  /// A list of very-shortly-named weekdays in this calendar, localized to the Calendar's `locale`,
  /// ordered according to the calendar's `firstWeekday`.
  var orderedVeryShortStandaloneWeekdaySymbols: [String] {
    return self.orderedWeekdaySymbols(using: veryShortStandaloneWeekdaySymbols)
  }

//  /// Returns the number of weeks in a month grid containing the specified date.
//  ///
//  /// NOTE: This aheres to Calendar.firstWeekday
//  ///
//  /// - Parameter dayInMonth: A day in the month grid you want to retrieve the weeks for.
//  /// - Returns: The number of weeks in the month grid for the provided date.
//  func weeksInMonthGrid(containing dayInMonth: Date) -> Int {
//    self.month(from: dayInMonth).numberOfWeeks
//  }
//
//  /// A convenience method for ``weeksInMonthGrid(containing:)`` which
//  /// takes in a month and year instead of date in month.
//  /// - Parameters:
//  ///   - month: The month you want to retrieve the weeks for.
//  ///   - year: The year you want to retrieve the weeks for.
//  /// - Returns: The number of weeks in the month grid for the provided date.
//  func weeksInGrid(month: Int, year: Int) -> Int {
//    self.weeksInMonthGrid(containing: .init(month: month, year: year, calendar: self))
//  }
//
//  /// A convenience method for ``daysInMonthGrid(containing:)`` which
//  /// takes in a month and year instead of date in month,
//  /// - Parameters:
//  ///   - month: The month you want to retrieve the weeks for.
//  ///   - year: The year you want to retrieve the weeks for.
//  /// - Returns: An array of Day's which make up the month grid.
//  func daysInGrid(month: Int, in year: Int) -> [Day] {
//    self.daysInMonthGrid(containing: .init(month: month, year: year, calendar: self))
//  }
//
//  /// Returns the days in a given month grid containing the specified date.
//  /// - Parameter dayInMonth: A day in the month grid you want to retrieve the weeks for.
//  /// - Returns: An array of Day's which make up the month grid.
//  func daysInMonthGrid(containing dayInMonth: Date) -> [Day] {
//    let month = self.startOfMonth(for: dayInMonth)
//    var days: [Day] = []
//    let formatter = dayNumberFormatter()
//
//    guard
//      let range = self.range(of: .day, in: .month, for: month)?.compactMap({
//        self.date(byAdding: .day, value: $0 - 1, to: month)
//      })
//    else {
//      return days
//    }
//
//    let firstWeekday = self.firstWeekday
//    let firstWeekDayOfMonth = self.component(.weekday, from: range.first!)
//    let leadingDays = (firstWeekDayOfMonth - firstWeekday + 7) % 7
//
//    for index in (0..<leadingDays).reversed() {
//      if let date = self.date(
//        byAdding: .day, value: -index - 1, to: range.first!
//      ) {
//        days.append(
//          Day(
//            shortSymbol: formatter.string(from: date),
//            date: date,
//            ignored: true
//          )
//        )
//      }
//    }
//
//    for date in range {
//      days.append(Day(shortSymbol: formatter.string(from: date), date: date))
//    }
//
//    let lastDayOfMonth = self.component(.weekday, from: range.last!)
//    let trailingDays = (7 - lastDayOfMonth + firstWeekday - 1) % 7
//
//    if trailingDays > 0 {
//      for index in 0..<trailingDays {
//        if let date = self.date(
//          byAdding: .day, value: index + 1, to: range.last!
//        ) {
//          days.append(
//            Day(
//              shortSymbol: formatter.string(from: date),
//              date: date,
//              ignored: true
//            )
//          )
//        }
//      }
//    }
//
//    return days
//  }
//
//  /// Returns the days in a week which contains the specified Date.
//  /// - Parameter dayInWeek: A day in the week you want to retrieve days for.
//  /// - Returns: An array of ``Day`` in the week.
//  func daysInWeek(containing dayInWeek: Date) -> [Day] {
//    var weekDays: [Day] = []
//    let startOfWeek = self.startOfWeek(for: dayInWeek)
//    let formatter = dayNumberFormatter()
//
//    for i in 0..<7 {
//      if let day = self.date(byAdding: .day, value: i, to: startOfWeek) {
//        let shortSymbol = formatter.string(from: day)
//        weekDays.append(.init(shortSymbol: shortSymbol, date: day))
//      }
//    }
//
//    return weekDays
//  }
//
//  /// Returns the start of the week for the specified Date.
//  /// - Parameter dayInWeek: A day in the week you want to retrieve the start of the week for.
//  /// - Returns: The start of week.
//  func startOfWeek(for dayInWeek: Date) -> Date {
//    guard let interval = self.dateInterval(of: .weekOfYear, for: dayInWeek) else {
//      fatalError("Failed to get start of week for date: \(dayInWeek)")
//    }
//    return interval.start
//  }
//
//  /// The first day of the current month
//  var currentMonth: Date {
//    let dateComponents = self.dateComponents([.month, .year], from: .now)
//    guard let currentMonth = self.date(from: dateComponents) else {
//      fatalError("Failed to get current month from date components")
//    }
//
//    return currentMonth
//  }
//
//  /// Returns the first day of the month for the month containing the specified date.
//  /// - Parameter dayInMonth: A day in the month grid you want to retrieve the weeks for.
//  /// - Returns: The first day of the month for the month containing the specified date.
//  func startOfMonth(for dayInMonth: Date) -> Date {
//    let components = self.dateComponents([.year, .month], from: dayInMonth)
//
//    guard let firstOfMonth = self.date(from: components) else {
//      fatalError("Failed to get first day of month from date components")
//    }
//    return firstOfMonth
//  }
//
//  /// Returns the last day of the month for the month containing the specified date.
//  /// - Parameter dayInMonth: A day in the month grid you want to retrieve the weeks for.
//  /// - Returns: The last day of the month for the month containing the specified date.
//  func endOfMonth(for dayInMonth: Date) -> Date {
//    let firstDayOfMonth = self.startOfMonth(for: dayInMonth)
//    guard
//      let lastOfMonth = self.date(
//        byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth
//      )
//    else {
//      fatalError("Failed to get last day of month date components")
//    }
//    return lastOfMonth
//  }
//
//  /// Returns whether or not dates provided are in the same year.
//  /// - Parameters:
//  ///   - date: The date to check if in the same year as the `otherDate`
//  ///   - otherDate: The  date to check if in the same year as the `date`
//  /// - Returns: A boolean whether the dates are in the same year.
//  func isDate(_ date: Date, inSameYearAs otherDate: Date) -> Bool {
//    return self.isDate(date, equalTo: otherDate, toGranularity: .year)
//  }
//
//  /// Returns whether or not dates provided are in the same month and year.
//  /// - Parameters:
//  ///   - date: The date to check if in the same month and year as the `otherDate`
//  ///   - otherDate: The other date to check if tin the same month and year as the `date`
//  /// - Returns: A boolean whether the dates are in the same month and year.
//  func isDate(_ date: Date, inSameMonthAs otherDate: Date) -> Bool {
//    return self.isDate(date, equalTo: otherDate, toGranularity: .month)
//      && self.isDate(date, equalTo: otherDate, toGranularity: .year)
//  }
//
//  /// Returns whether or not dates provided are in the same week.
//  /// - Parameters:
//  ///   - date: The date to check if in the same week, month, and year as the `otherDate`
//  ///   - otherDate: The date to check if in the same week,  and year as the `date`
//  /// - Returns: A boolean whether the dates are in the same week.
//  func isDate(_ date: Date, inSameWeekAs otherDate: Date) -> Bool {
//    return self.isDate(date, equalTo: otherDate, toGranularity: .weekOfYear)
//      && self.isDate(date, equalTo: otherDate, toGranularity: .yearForWeekOfYear)
//  }
//
//  /// Returns the number of weeks between the start and end.
//  /// - Parameters:
//  ///   - start: The starting date.
//  ///   - end: The ending date.
//  /// - Returns: The number of weeks between the start and end.
//  func numberOfWeeks(from start: Date, to end: Date) -> Int? {
//    let components = self.dateComponents(
//      [.weekOfYear], from: start, to: end
//    )
//    return components.weekOfYear
//  }
//
//  /// Returns the number of months between the start and end.
//  /// - Parameters:
//  ///   - start: The starting date.
//  ///   - end: The ending date.
//  /// - Returns: The number of months between the start and end.
//  func numberOfMonths(from start: Date, to end: Date) -> Int? {
//    let components = self.dateComponents([.month], from: start, to: end)
//    return components.month
//  }
//
//  /// Returns whether the date is the first day of the week.
//  /// - Parameter date: The date to check.
//  /// - Returns: A boolean whether the date is the start of the week.
//  func isDateFirstDayOfWeek(_ date: Date) -> Bool {
//    let components = self.dateComponents([.weekday], from: date)
//    return components.weekday == self.firstWeekday
//  }
//
//  /// Returns whether date specified is in the current year.
//  /// - Parameter date: The date to check if in the current year.
//  /// - Returns: A boolean whether the date is in the current year.
//  func isDateInCurrentYear(_ date: Date) -> Bool {
//    return self.isDate(date, inSameYearAs: .now)
//  }
//
//  /// Returns whether the date specified is in the current month.
//  /// - Parameter date: The date to check if in the current month.
//  /// - Returns: A boolean whether the date is in the current month.
//  func isDateInCurrentMonth(_ date: Date) -> Bool {
//    return self.isDate(date, inSameMonthAs: .now)
//  }
//
//  /// Returns whether the date specified is in the current week.
//  /// - Parameter date: The date to check if in the current week.
//  /// - Returns: A boolean whether the date is in the current week.
//  func isDateInCurrentWeek(_ date: Date) -> Bool {
//    return self.isDate(date, inSameWeekAs: .now)
//  }
//
//  //  public func weekOfMonth(inSameMonthAs date: Date) -> Int? {
//  //    guard isInSameMonth(as: date) else {
//  //      return nil
//  //    }
//  //
//  //    // If they are in the same month, return the week of the month
//  //    // needs to be 0 based
//  //    return self.component(.weekOfMonth, from: self) - 1
//  //  }
//
//  //  public func addingMonths(_ months: Int) -> Date {
//  //    var dateComponents = DateComponents()
//  //    dateComponents.month = months
//  //    return Calendar.current.date(byAdding: dateComponents, to: self)!
//  //  }
//  //
//  //  public func addingWeeks(_ weeks: Int) -> Date {
//  //    var dateComponents = DateComponents()
//  //    dateComponents.weekOfYear = weeks
//  //    return Calendar.current.date(byAdding: dateComponents, to: self)!
//  //  }
//  
//  func dayNumberFormatter() -> DateFormatter {
//    let formatter = DateFormatter()
//    formatter.calendar = self
//    formatter.locale = locale
//    formatter.timeZone = timeZone
//    formatter.dateFormat = "d"
//    return formatter
//  }
}
