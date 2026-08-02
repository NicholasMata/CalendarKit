//
//  DefaultDayView.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//
import CalendarExtensions
import SwiftUI

/// A default visual representation for a single day cell in a calendar grid.
public struct DefaultDayView: View {
  var day: Day
  var selectedDate: Date? = nil
  var calendar: Calendar = .current
  /// The default height used by the day view.
  public static var height: CGFloat = 60

  var isSelected: Bool {
    guard let selectedDate = selectedDate else {
      return false
    }
    return calendar.isDate(day.date, inSameDayAs: selectedDate)
  }

  var isToday: Bool {
    calendar.isDate(day.date, inSameDayAs: .now)
  }

  /// The rendered day cell view.
  public var body: some View {
    VStack {
      Text(day.shortSymbol)
        .foregroundStyle(
          day.ignored ? .secondary : (isSelected ? Color.white : .primary)
        )
    }
    .frame(maxWidth: .infinity)
    .frame(height: DefaultDayView.height)
    .background(alignment: .bottom) {
      if isToday {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.platformLabel)
          .frame(width: 35, height: 5)
      }
    }
    .background(alignment: .center) {
      if isSelected {
        RoundedRectangle(cornerRadius: 4)
          .fill(.tint)
          .frame(width: 35, height: 35)
          .opacity(isSelected ? 1 : 0)
      }
    }
    .contentShape(.rect)
  }
}
