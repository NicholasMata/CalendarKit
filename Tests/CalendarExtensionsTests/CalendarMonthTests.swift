import Testing

@testable import CalendarExtensions

@Test
func findsVisibleWeekIndexContainingDay() {
  let month = CalendarMonth(
    8,
    year: 2026,
    calendar: testGregorianCalendar(firstWeekday: 1)
  )

  #expect(month.weekIndex(containing: month.firstWeek.firstDay) == 0)
  #expect(month.weekIndex(containing: month.firstDay) == 0)
  #expect(month.weekIndex(containing: month.firstDay.advanced(by: 25)) == 4)
  #expect(month.weekIndex(containing: month.lastWeek.lastDay) == 5)
}

@Test
func returnsNilForDayOutsideVisibleMonthGrid() {
  let month = CalendarMonth(
    8,
    year: 2026,
    calendar: testGregorianCalendar(firstWeekday: 1)
  )

  #expect(month.weekIndex(containing: month.firstWeek.firstDay.advanced(by: -1)) == nil)
  #expect(month.weekIndex(containing: month.lastWeek.lastDay.advanced(by: 1)) == nil)
}
