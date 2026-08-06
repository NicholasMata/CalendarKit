import Testing

import CalendarExtensions
@testable import CalendarKit

@Test
func derivesMonthContextWithoutChangingDayIdentity() {
  let calendar = gregorianCalendar()
  let august = CalendarMonth(8, year: 2026, calendar: calendar)
  let september = CalendarMonth(9, year: 2026, calendar: calendar)
  let day = CalendarDay(containing: august.lastDay.date, calendar: calendar)

  let augustCell = MonthGridDay(day: day, month: august)
  let septemberCell = MonthGridDay(day: day, month: september)

  #expect(augustCell.id == septemberCell.id)
  #expect(augustCell.calendarDay == day)
  #expect(!augustCell.isOutsideMonth)
  #expect(septemberCell.isOutsideMonth)
}

@Test
func generatesEveryVisibleDayInSixWeekMonthGrid() {
  let month = CalendarMonth(
    8,
    year: 2026,
    calendar: gregorianCalendar(firstWeekday: 1)
  )
  let days = MonthGridDay.visibleDays(in: month)

  #expect(month.numberOfWeeks == 6)
  #expect(days.count == month.numberOfWeeks * 7)
  #expect(days.count.isMultiple(of: 7))
  #expect(days.first?.calendarDay == month.firstWeek.firstDay)
  #expect(days.last?.calendarDay == month.lastWeek.lastDay)
  #expect(zip(days, days.dropFirst()).allSatisfy { first, second in
    first.calendarDay.distance(to: second.calendarDay) == 1
  })
  #expect(days.allSatisfy {
    $0.isOutsideMonth == (CalendarMonth.ID(containing: $0.calendarDay) != month.id)
  })
}
