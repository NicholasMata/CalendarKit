import CalendarExtensions
import CalendarKit
import SwiftUI

struct SingleSelectionExample: View {
  @State private var selectedDay: CalendarDay.ID? = SampleCalendar.month.firstDay.advanced(by: 4).id

  var body: some View {
    CalendarExampleContainer(
      title: "August 2026",
      subtitle: "Tap a day to replace the current selection."
    ) {
      WeekdayLabels(using: SampleCalendar.calendar)

      DaysOfMonthGrid(month: SampleCalendar.month) { cell in
        Button {
          selectedDay = selectedDay == cell.id ? nil : cell.id
        } label: {
          DefaultDayView(
            cell: cell,
            isSelected: selectedDay == cell.id
          )
        }
        .buttonStyle(.plain)
        .disabled(cell.isOutsideMonth)
        .accessibilityLabel(SampleCalendar.accessibilityLabel(for: cell.calendarDay))
        .accessibilityValue(selectedDay == cell.id ? "Selected" : "Not selected")
        .accessibilityIdentifier(SampleCalendar.identifier(
          for: cell.calendarDay,
          prefix: "single-day"
        ))
      }
    }
    .navigationTitle("Single Selection")
    .navigationBarTitleDisplayMode(.inline)
  }
}
