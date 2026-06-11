//
//  CalendarMonthsVStack.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 4/26/25.
//

import CalendarExtensions
import SwiftUI

#Preview {
  @Previewable @State var selectedDate: Date? = nil
  @Previewable @State var monthScrollPosition: CalendarMonth.ID? = nil
  let startMonth = CalendarMonth(1, year: 2024)
  let lastMonth = CalendarMonth(12, year: 2025)

  ScrollView(.vertical, showsIndicators: false) {
    Button("Scroll to June 2024") {
      withAnimation {
        monthScrollPosition = CalendarMonth.ID(monthNumber: 5, year: 2024)
      }
    }
    LazyVStack(spacing: 24) {
      ForEach(startMonth ... lastMonth) { month in
        VStack(spacing: 16) {
          HStack {
            Text("\(month.startDate.formatted(.dateTime.month(.wide).year()))")
              .font(.system(.title3, weight: .bold))
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 12)
            Button(action: {
              withAnimation {
                monthScrollPosition = month.id.add(month: -1)
              }
            }, label: {
              Image(systemName: "chevron.up")
            })
            .disabled(month.id == startMonth.id)
            Button(action: {
              withAnimation {
                monthScrollPosition = month.id.add(month: 1)
              }
            }, label: {
              Image(systemName: "chevron.down")
            })
            .disabled(month.id == lastMonth.id)
          }
          WeekdayLabels()
          DaysOfMonthGrid(month: month) { day in
            Group {
              if day.ignored {
                Rectangle().fill(.clear)
              } else {
                DefaultDayView(day: day, selectedDate: selectedDate)
                  .onTapGesture {
                    selectedDate = day.date
                  }
              }
            }
          }
          .frame(height: MonthGridUtil.height(for: month.startDate))
        }
      }
    }
    .scrollTargetLayout()
  }
  .scrollPosition(id: $monthScrollPosition, anchor: .center)
}
