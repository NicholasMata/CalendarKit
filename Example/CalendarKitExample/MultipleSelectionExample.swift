import CalendarExtensions
import CalendarKit
import SwiftUI

struct MultipleSelectionExample: View {
  @State private var selectedDays: Set<CalendarDay.ID> = [
    SampleCalendar.month.firstDay.advanced(by: 4).id,
    SampleCalendar.month.firstDay.advanced(by: 5).id,
    SampleCalendar.month.firstDay.advanced(by: 6).id,
  ]

  var body: some View {
    CalendarExampleContainer(
      title: "August 2026",
      subtitle: "Each day toggles independently using CalendarDay.ID."
    ) {
      WeekdayLabels(using: SampleCalendar.calendar)

      DaysOfMonthGrid(month: SampleCalendar.month) { cell in
        Button {
          if selectedDays.contains(cell.id) {
            selectedDays.remove(cell.id)
          } else {
            selectedDays.insert(cell.id)
          }
        } label: {
          DefaultDayView(
            cell: cell,
            isSelected: selectedDays.contains(cell.id)
          )
        }
        .buttonStyle(.plain)
        .disabled(cell.isOutsideMonth)
        .accessibilityLabel(SampleCalendar.accessibilityLabel(for: cell.calendarDay))
        .accessibilityValue(selectedDays.contains(cell.id) ? "Selected" : "Not selected")
        .accessibilityIdentifier(SampleCalendar.identifier(
          for: cell.calendarDay,
          prefix: "multiple-day"
        ))
      }
    }
    .navigationTitle("Multiple Selection")
    .navigationBarTitleDisplayMode(.inline)
  }
}
