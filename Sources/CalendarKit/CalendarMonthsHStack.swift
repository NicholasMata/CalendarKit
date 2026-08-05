//
//  CalendarMonthsHStack.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/17/25.
//

import CalendarExtensions
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
#Preview {
  @Previewable @State var selectedDate: Date? = nil
  @Previewable @State var scrollPosition: CalendarMonth.ID? = nil
  let startMonth = CalendarMonth(1, year: 2024)
  var currentMonth: CalendarMonth {
    guard let id = scrollPosition else {
      return startMonth
    }
    return CalendarMonth(id: id)
  }

  VStack(alignment: .leading, spacing: 16) {
    HStack(alignment: .center) {
      Text("\(currentMonth.startDate.formatted(.dateTime.month(.wide)))")
      Spacer()
      Text(currentMonth.year, format: .number.grouping(.never))
    }
    .padding(.horizontal, 10)
    .frame(maxWidth: .infinity, alignment: .leading)
    WeekdayLabels()

    GeometryReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(alignment: .top, spacing: 0) {
          ForEach(startMonth ... CalendarMonth(12, year: 2035)) { month in
            DaysOfMonthGrid(
              month: month
            ) { cell in
              DefaultDayView(cell: cell, selectedDate: selectedDate)
                .onTapGesture {
                  selectedDate = cell.id
                }
            }
            .frame(width: proxy.size.width)
          }
        }
        .scrollTargetLayout()
      }
      .scrollPosition(id: $scrollPosition, anchor: .trailing)
      .scrollTargetBehavior(.paging)
    }
    .frame(
      height: MonthGridUtil.height(for: currentMonth.startDate)
    )
    .overlay(alignment: .bottom) {
      Rectangle().frame(height: 1, alignment: .bottom)
    }
  }
  .frame(
    maxWidth: .infinity,
    maxHeight: .infinity,
    alignment: .topLeading
  )
  .onChange(of: scrollPosition, initial: false) { _, newValue in
    guard let newValue, let currentSelectedDate = selectedDate else { return }
    let month = CalendarMonth(containing: currentSelectedDate)
    if month.monthNumber != newValue.monthNumber {
      selectedDate = nil
    }
  }
  .onChange(of: selectedDate, initial: false) { _, newValue in
    guard let newValue else { return }
    let month = CalendarMonth(containing: newValue)
    if month.monthNumber != scrollPosition?.monthNumber {
      scrollPosition = month.id
    }
  }
}
