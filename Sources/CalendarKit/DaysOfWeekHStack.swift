//
//  DaysOfWeekHStack.swift
//
//
//  Created by Nicholas Mata on 9/16/24.
//

import CalendarExtensions
import SwiftUI

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
              DefaultDayView(
                cell: MonthGridDay(day: day),
                selectedDate: selectedDate
              )
                .onTapGesture {
                  selectedDate = day.id
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
