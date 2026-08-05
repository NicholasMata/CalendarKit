//
//  WeekdayLabels.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/15/25.
//

import CalendarExtensions
import SwiftUI

/// A horizontal row of localized weekday labels ordered by the calendar's first weekday.
public struct WeekdayLabels: View {
  private let formattedWeekdaySymbols: [String]

  /// Creates a row of weekday labels.
  ///
  /// - Parameters:
  ///   - formatStyle: The weekday symbol style to display.
  ///   - calendar: The calendar used to order and localize the weekday symbols.
  public init(
    style formatStyle: Date.FormatStyle.Symbol.Weekday = .abbreviated,
    using calendar: Calendar = .current
  ) {
    formattedWeekdaySymbols = Self.weekdaySymbols(
      with: formatStyle,
      using: calendar
    )
  }

  /// The rendered weekday label row.
  public var body: some View {
    HStack(spacing: 0) {
      ForEach(formattedWeekdaySymbols, id: \.self) { weekdaySymbol in
        Text(weekdaySymbol)
          .frame(maxWidth: .infinity)
      }
    }
  }

  /// Returns localized weekday symbols ordered according to the supplied calendar.
  public static func weekdaySymbols(with formatStyle: Date.FormatStyle.Symbol.Weekday, using calendar: Calendar) -> [String] {
    switch formatStyle {
    case .abbreviated:
      return calendar.orderedShortStandaloneWeekdaySymbols
    case .wide:
      return calendar.orderedStandaloneWeekdaySymbols
    case .narrow:
      return calendar.orderedVeryShortStandaloneWeekdaySymbols
    case .short:
      return calendar.orderedShortStandaloneWeekdaySymbols.map {
        String($0.prefix(2))
      }
    case .oneDigit:
      return calendar.orderedWeekdaySymbols(using: (1...7).map(String.init))
    case .twoDigits:
      return calendar.orderedWeekdaySymbols(using: (1...7).map {
        String(format: "%02d", $0)
      })
    default:
      return calendar.orderedShortStandaloneWeekdaySymbols
    }
  }
}

#Preview {
  struct Preview: View {
    var calendar: Calendar {
      var calendar = Calendar.current
      calendar.firstWeekday = firstDayOfWeek
      return calendar
    }

    @State var firstDayOfWeek: Int = 1
    var body: some View {
      VStack {
        VStack(alignment: .leading) {
          Text("First day of week")
          Picker("First day of week", selection: $firstDayOfWeek) {
            ForEach(1 ..< calendar.weekdaySymbols.count + 1, id: \.self) { i in
              Text(calendar.shortWeekdaySymbols[i - 1])
            }
          }
          .pickerStyle(.segmented)
        }
        .padding()
        VStack(spacing: 16) {
          WeekdayLabels(using: calendar)
          WeekdayLabels(style: .short, using: calendar)
          WeekdayLabels(style: .narrow, using: calendar)
        }
        .font(.caption)
        .frame(maxHeight: .infinity)
      }
    }
  }
  return Preview()
}
