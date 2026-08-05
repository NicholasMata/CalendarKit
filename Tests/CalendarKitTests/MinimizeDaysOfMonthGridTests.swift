import Testing

@testable import CalendarKit

@Test
@MainActor
func interpolatesMinimizedGridHeight() {
  #expect(MinimizeDaysOfMonthGrid.collapsedHeight(
    expandedHeight: 288,
    dayHeight: 48,
    progress: 0
  ) == 288)
  #expect(MinimizeDaysOfMonthGrid.collapsedHeight(
    expandedHeight: 288,
    dayHeight: 48,
    progress: 0.5
  ) == 168)
  #expect(MinimizeDaysOfMonthGrid.collapsedHeight(
    expandedHeight: 288,
    dayHeight: 48,
    progress: 1
  ) == 48)
}

@Test
@MainActor
func offsetsSelectedWeekWhileMinimizingGrid() {
  #expect(MinimizeDaysOfMonthGrid.verticalOffset(
    weekInMonth: 2,
    dayHeight: 48,
    progress: 0
  ) == 0)
  #expect(MinimizeDaysOfMonthGrid.verticalOffset(
    weekInMonth: 2,
    dayHeight: 48,
    progress: 0.5
  ) == -48)
  #expect(MinimizeDaysOfMonthGrid.verticalOffset(
    weekInMonth: 2,
    dayHeight: 48,
    progress: 1
  ) == -96)
}
