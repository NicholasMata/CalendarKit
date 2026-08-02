//
//  MonthView.swift
//
//
//  Created by Nicholas Mata on 9/16/24.
//

import CalendarExtensions
import SwiftUI

/// Utilities for deriving layout metrics for month grids.
public enum MonthGridUtil {
  /// Returns the height needed to display the month grid containing the supplied date.
  @MainActor
  public static func height(
    for dayInMonth: Date,
    using dayHeight: CGFloat = DefaultDayView.height,
    calendar: Calendar = Calendar.current
  ) -> CGFloat {
      return height(for: CalendarMonth(containing: dayInMonth, calendar: calendar), using: dayHeight)
  }
  
  /// Returns the height needed to display the supplied month grid.
  @MainActor
  public static func height(
    for month: CalendarMonth,
    using dayHeight: CGFloat = DefaultDayView.height,
  ) -> CGFloat {
    return CGFloat(month.numberOfWeeks) * dayHeight
  }
}

/// A seven-column grid that renders the visible days for a calendar month.
///
/// `DaysOfMonthGrid` includes leading and trailing days from adjacent months when needed
/// to fill the first and last visible week rows.
public struct DaysOfMonthGrid<DayView: View>: View {
  private var month: CalendarMonth
  private var startOfMonthGrid: CalendarDay
  private var endOfMonthGrid: CalendarDay

  @ViewBuilder
  private var dayBuilder: (Day) -> DayView

  private var columns = Array(repeating: GridItem(spacing: 0), count: 7)

  /// Creates a month grid for the month containing the supplied date.
  public init(
    dayInMonth: Date,
    calendar: Calendar = .current,
    dayContent: @escaping (Day) -> DayView
  ) {
    let month = calendar.month(from: dayInMonth)
    self.init(month: month, dayContent: dayContent)
  }

  /// Creates a month grid for a resolved ``CalendarMonth`` value.
  public init(
    month: CalendarMonth,
    dayContent: @escaping (Day) -> DayView
  ) {
    self.month = month
    startOfMonthGrid = month.firstWeek.firstDay
    endOfMonthGrid = month.lastWeek.lastDay
    dayBuilder = dayContent
  }

  /// Creates a month grid from month and year components.
  public init(
    month: Int,
    year: Int,
    calendar: Calendar = .current,
    dayContent: @escaping (Day) -> DayView
  ) {
    self.init(
      month: CalendarMonth(month, year: year, calendar: calendar),
      dayContent: dayContent
    )
  }

  /// The rendered month grid view.
  public var body: some View {
    LazyVGrid(columns: columns, spacing: 0) {
      ForEach(startOfMonthGrid ... endOfMonthGrid) { day in
        dayBuilder(
          Day(day: day, month: month)
        )
      }
    }
  }
}

#Preview("Days of Month Grid") {
  @Previewable @State var firstDayOfWeek = 1
  @Previewable @State var selectedDate: Date? = nil
  @Previewable @State var progress: CGFloat = 0.0
  @Previewable @State var monthProgress = 0

  var month: CalendarMonth {
    .init(containing: Date.now, calendar: calendar)
  }

  var calendar: Calendar {
    var calendar = Calendar.current
    calendar.firstWeekday = firstDayOfWeek
    return calendar
  }

  VStack {
    VStack(alignment: .leading, spacing: 24) {
      VStack(alignment: .leading) {
        Text("Minimized Progress")
        Slider(value: $progress)
          .padding(.horizontal)
        HStack {
          Text("Maximized")
          Spacer()
          Text("Minimized")
        }
        .foregroundStyle(Color.platformLabel.opacity(0.7))
      }
      VStack(alignment: .leading) {
        Text("Minimize to week")
        Picker("Week", selection: $monthProgress) {
          ForEach(0..<month.numberOfWeeks, id: \.self) { i in
            Text("\(i + 1)")
          }
        }
        .pickerStyle(.segmented)
      }
      VStack(alignment: .leading) {
        Text("First day of week")
        Picker("First day of week", selection: $firstDayOfWeek) {
          ForEach(1..<calendar.weekdaySymbols.count + 1, id: \.self) { i in
            Text(calendar.shortWeekdaySymbols[i - 1])
          }
        }
        .pickerStyle(.segmented)
      }
      VStack(alignment: .leading) {
        Text("Selected Date")
        Text("\(selectedDate.map(\.description) ?? "None")")
      }
    }
    .padding()
    VStack {
      Text("Above")
      DaysOfMonthGrid(month: month) { day in
        DefaultDayView(day: day, selectedDate: selectedDate, calendar: calendar)
          .onTapGesture {
            selectedDate = day.date
          }
      }
      .background {
        Color.black.opacity(0.1)
      }
      .minimizeMonthGrid(
        progress: progress,
        toWeek: monthProgress
      )
      Text("Below")
    }
    .tint(.red)
    .frame(maxHeight: .infinity)
  }
}
