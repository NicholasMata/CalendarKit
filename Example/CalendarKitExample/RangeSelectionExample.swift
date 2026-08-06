import CalendarExtensions
import CalendarKit
import SwiftUI

struct RangeSelectionExample: View {
  @State private var rangeStart: CalendarDay?
  @State private var selectedRange: ClosedRange<CalendarDay>? = SampleCalendar.month.firstDay
    .advanced(by: 17)
    .closedRange(to: SampleCalendar.month.firstDay.advanced(by: 19))
  @State private var usesContinuousStyle = true

  var body: some View {
    CalendarExampleContainer(
      title: SampleCalendar.monthTitle,
      subtitle: rangeStart == nil
        ? "Tap a day to start a new range."
        : "Tap another day to complete the range."
    ) {
      Picker("Range style", selection: $usesContinuousStyle) {
        Text("Continuous").tag(true)
        Text("Individual").tag(false)
      }
      .pickerStyle(.segmented)
      .accessibilityIdentifier("range-style-picker")

      WeekdayLabels(using: SampleCalendar.calendar)

      DaysOfMonthGrid(month: SampleCalendar.month) { cell in
        Group {
          if rangeStart == cell.calendarDay {
            DefaultDayView(cell: cell, isSelected: true)
          } else if usesContinuousStyle {
            DefaultRangeDayView(cell: cell, range: selectedRange)
          } else {
            DefaultDayView(
              cell: cell,
              isSelected: selectedRange?.contains(cell.calendarDay) == true
            )
          }
        }
        .contentShape(Rectangle())
        .allowsHitTesting(!cell.isOutsideMonth)
        .onTapGesture {
          select(cell.calendarDay)
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(SampleCalendar.accessibilityLabel(for: cell.calendarDay))
        .accessibilityValue(accessibilityValue(for: cell.calendarDay))
        .accessibilityIdentifier(SampleCalendar.identifier(
          for: cell.calendarDay,
          prefix: "range-day"
        ))
      }
    }
    .navigationTitle("Range Selection")
    .navigationBarTitleDisplayMode(.inline)
  }

  private func select(_ day: CalendarDay) {
    var transaction = Transaction(animation: nil)
    transaction.disablesAnimations = true

    withTransaction(transaction) {
      if let rangeStart {
        if rangeStart == day {
          self.rangeStart = nil
        } else {
          selectedRange = rangeStart.closedRange(to: day)
          self.rangeStart = nil
        }
      } else {
        rangeStart = day
        selectedRange = nil
      }
    }
  }

  private func accessibilityValue(for day: CalendarDay) -> String {
    if rangeStart == day {
      return "Range start"
    }

    return selectedRange?.contains(day) == true ? "Selected" : "Not selected"
  }
}
