//
//  DaysOfWeekHStack.swift
//
//
//  Created by Nicholas Mata on 9/16/24.
//

import CalendarExtensions
import SwiftUI

//public struct DaysOfWeekHStack<DayView: View>: View {
//  @Binding private var selectedDate: Date?
//  @State private var weekDates: [Day] = []
//  private var dayInWeek: Date
//  private var dayContent: (Day, Binding<Date?>) -> DayView
//  private var calendar: Calendar
//
//  public init(
//    dayInWeek: Date,
//    selectedDate: Binding<Date?>,
//    calendar: Calendar = .current,
//    dayContent: @escaping (Day, Binding<Date?>) -> DayView
//  ) {
//    _selectedDate = selectedDate
//    self.dayInWeek = dayInWeek
//    self.dayContent = dayContent
//    self.calendar = calendar
//  }
//
//  public var body: some View {
//    HStack(spacing: 0) {
//      ForEach(weekDates, id: \.self) { day in
//        dayContent(day, $selectedDate)
//      }
//    }
//    // Only recalculate days when day in week changes or firstWeekday changes
//    .onChange(of: dayInWeek, initial: true) { _, newDayInWeek in
//      weekDates = calendar.daysInWeek(containing: newDayInWeek)
//    }
//    .onChange(of: calendar.firstWeekday, initial: false) {
//      weekDates = calendar.daysInWeek(containing: dayInWeek)
//    }
//  }
//}
//
//public extension DaysOfWeekHStack where DayView == DefaultDayView {
//  init(
//    dayInWeek: Date,
//    selectedDate: Binding<Date?>,
//    calendar: Calendar = .current
//  ) {
//    self.init(
//      dayInWeek: dayInWeek,
//      selectedDate: selectedDate,
//      calendar: calendar,
//      dayContent: {
//        DefaultDayView(day: $0, selectedDate: $1.wrappedValue)
//      })
//  }
//}

#Preview {
  struct Preview: View {
    @State var firstDayOfWeek: Int = 1
    @State var selectedDate: Date? = nil
    var week: CalendarWeek {
      CalendarWeek(containing: Date(day: 1, month: 2, year: 2025), calendar: calendar)
    }

    var calendar: Calendar {
      var calendar = Calendar.current
      calendar.firstWeekday = firstDayOfWeek
      return calendar
    }

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
        VStack {
          HStack {
            ForEach(week.firstDay ... week.lastDay) { day in
              DefaultDayView(day: Day(day: day),
                             selectedDate: selectedDate)
                .onTapGesture {
                  selectedDate = day.date
                }
            }
          }
        }
        .frame(maxHeight: .infinity)
      }
    }
  }
  return Preview()
}
