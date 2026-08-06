import CalendarExtensions
import CalendarKit
import SwiftUI

struct CollapsibleMonthGridExample: View {
  @State private var progress: CGFloat = 0
  @State private var selectedDay = SampleCalendar.month.firstDay.advanced(by: 17)

  private var selectedWeek: Int {
    SampleCalendar.month.weekIndex(containing: selectedDay) ?? 0
  }

  var body: some View {
    CalendarExampleContainer(
      title: "August 2026",
      subtitle: "Select a day, then collapse the month to its week."
    ) {
      Picker("Grid state", selection: $progress) {
        Text("Expanded").tag(CGFloat.zero)
        Text("Collapsed").tag(CGFloat(1))
      }
      .pickerStyle(.segmented)
      .accessibilityIdentifier("grid-state-picker")

      WeekdayLabels(using: SampleCalendar.calendar)

      DaysOfMonthGrid(month: SampleCalendar.month) { cell in
        Button {
          selectedDay = cell.calendarDay
        } label: {
          DefaultDayView(
            cell: cell,
            isSelected: selectedDay.id == cell.id
          )
        }
        .buttonStyle(.plain)
        .disabled(cell.isOutsideMonth)
        .accessibilityLabel(SampleCalendar.accessibilityLabel(for: cell.calendarDay))
        .accessibilityValue(selectedDay.id == cell.id ? "Selected" : "Not selected")
        .accessibilityIdentifier(SampleCalendar.identifier(
          for: cell.calendarDay,
          prefix: "collapsible-day"
        ))
      }
      .minimizeMonthGrid(progress: progress, toWeek: selectedWeek)
      .animation(.easeInOut, value: progress)
      .animation(.easeInOut, value: selectedWeek)
    }
    .navigationTitle("Collapsible Grid")
    .navigationBarTitleDisplayMode(.inline)
  }
}
