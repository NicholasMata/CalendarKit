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
    using dayHeight: CGFloat = MonthGridLayout.defaultDayHeight,
    calendar: Calendar = Calendar.current
  ) -> CGFloat {
      return height(for: CalendarMonth(containing: dayInMonth, calendar: calendar), using: dayHeight)
  }
  
  /// Returns the height needed to display the supplied month grid.
  @MainActor
  public static func height(
    for month: CalendarMonth,
    using dayHeight: CGFloat = MonthGridLayout.defaultDayHeight,
  ) -> CGFloat {
    return CGFloat(month.numberOfWeeks) * dayHeight
  }
}

/// A seven-column grid that renders the visible days for a calendar month.
///
/// `DaysOfMonthGrid` includes leading and trailing days from adjacent months when needed
/// to fill the first and last visible week rows.
public struct DaysOfMonthGrid<DayView: View>: View {
  @Environment(\.monthGridDayHeight) private var dayHeight

  private var days: [MonthGridDay]

  @ViewBuilder
  private var dayBuilder: (MonthGridDay) -> DayView

  private var columns = Array(repeating: GridItem(spacing: 0), count: 7)

  /// Creates a month grid for the month containing the supplied date.
  public init(
    dayInMonth: Date,
    calendar: Calendar = .current,
    dayContent: @escaping (MonthGridDay) -> DayView
  ) {
    let month = calendar.month(from: dayInMonth)
    self.init(month: month, dayContent: dayContent)
  }

  /// Creates a month grid for a resolved calendar month value.
  public init(
    month: CalendarMonth,
    dayContent: @escaping (MonthGridDay) -> DayView
  ) {
    days = MonthGridDay.visibleDays(in: month)
    dayBuilder = dayContent
  }

  /// Creates a month grid from month and year components.
  public init(
    month: Int,
    year: Int,
    calendar: Calendar = .current,
    dayContent: @escaping (MonthGridDay) -> DayView
  ) {
    self.init(
      month: CalendarMonth(month, year: year, calendar: calendar),
      dayContent: dayContent
    )
  }

  /// The rendered month grid view.
  public var body: some View {
    LazyVGrid(columns: columns, spacing: 0) {
      ForEach(days) { day in
        dayBuilder(day)
          .frame(height: dayHeight)
      }
    }
  }
}

@available(iOS 17.0, macOS 14.0, *)
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
      DaysOfMonthGrid(month: month) { cell in
        DefaultDayView(cell: cell, selectedDate: selectedDate)
          .onTapGesture {
            if selectedDate == cell.id {
              selectedDate = nil
            } else {
              selectedDate = cell.id
            }
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

@available(iOS 17.0, macOS 14.0, *)
#Preview("Multiple Day Selection") {
  @Previewable @State var selectedDays: Set<CalendarDay.ID> = []
  let calendar = Calendar.current
  let month = CalendarMonth(containing: .now, calendar: calendar)

  VStack(spacing: 16) {
    WeekdayLabels(using: calendar)

    DaysOfMonthGrid(month: month) { cell in
      DefaultDayView(
        cell: cell,
        isSelected: selectedDays.contains(cell.id)
      )
      .onTapGesture {
        if selectedDays.contains(cell.id) {
          selectedDays.remove(cell.id)
        } else {
          selectedDays.insert(cell.id)
        }
      }
      .allowsHitTesting(!cell.isOutsideMonth)
    }
  }
  .monthGridDayHeight(48)
  .padding()
}
