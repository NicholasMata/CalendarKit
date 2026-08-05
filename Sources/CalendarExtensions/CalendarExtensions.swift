//
//  CalendarExtensions.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/22/25.
//
import Foundation

/// Extension methods that respect a calendar's configured `firstWeekday`.
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

  /// Standalone weekday names localized to the calendar's locale and ordered by its first weekday.
  var orderedStandaloneWeekdaySymbols: [String] {
    orderedWeekdaySymbols(using: standaloneWeekdaySymbols)
  }

  /// Short standalone weekday names localized to the calendar's locale and ordered by its first weekday.
  var orderedShortStandaloneWeekdaySymbols: [String] {
    orderedWeekdaySymbols(using: shortStandaloneWeekdaySymbols)
  }

  /// Very short standalone weekday names localized to the calendar's locale and ordered by its first weekday.
  var orderedVeryShortStandaloneWeekdaySymbols: [String] {
    orderedWeekdaySymbols(using: veryShortStandaloneWeekdaySymbols)
  }
}
