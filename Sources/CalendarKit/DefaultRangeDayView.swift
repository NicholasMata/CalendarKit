import CalendarExtensions
import SwiftUI

/// A default day cell that visually connects adjacent days in a selected range.
public struct DefaultRangeDayView<Label: View>: View {
  private let isToday: Bool
  private let selection: DayRangeSelection
  private let isDimmed: Bool
  private let label: Label

  /// Creates a connected range day cell with resolved presentation state.
  ///
  /// - Parameters:
  ///   - isToday: Whether the cell represents today.
  ///   - selection: The day's selection and connection context.
  ///   - isDimmed: Whether the cell should use a secondary foreground style.
  ///   - label: The content displayed by the cell.
  public init(
    isToday: Bool,
    selection: DayRangeSelection,
    isDimmed: Bool = false,
    @ViewBuilder label: () -> Label
  ) {
    self.isToday = isToday
    self.selection = selection
    self.isDimmed = isDimmed
    self.label = label()
  }

  /// The rendered connected range day cell.
  public var body: some View {
    label
      .foregroundStyle(
        isDimmed
          ? .secondary
          : (selection.isSelected ? Color.white : .primary)
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background {
        if selection.isSelected {
          ZStack {
            HStack(spacing: 0) {
              if selection.connectsToPreviousDay {
                Rectangle().fill(.tint)
              } else {
                Color.clear
              }

              if selection.connectsToNextDay {
                Rectangle().fill(.tint)
              } else {
                Color.clear
              }
            }
            .frame(height: 35)

            RoundedRectangle(cornerRadius: 4)
              .fill(.tint)
              .frame(width: 35, height: 35)
          }
        }
      }
      .background(alignment: .bottom) {
        if isToday {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.platformLabel)
            .frame(width: 35, height: 5)
        }
      }
      .contentShape(.rect)
  }
}

public extension DefaultRangeDayView where Label == Text {
  /// Creates a text day cell from a month-grid cell and resolved range selection.
  init(
    cell: MonthGridDay,
    selection: DayRangeSelection
  ) {
    self.init(
      isToday: cell.calendarDay.calendar.isDateInToday(cell.calendarDay.date),
      selection: selection,
      isDimmed: cell.isOutsideMonth
    ) {
      Text(cell.calendarDay.dayOfMonth, format: .number)
    }
  }

  /// Creates a text day cell and resolves its context in an optional selected range.
  init(
    cell: MonthGridDay,
    range: ClosedRange<CalendarDay>?
  ) {
    self.init(
      cell: cell,
      selection: DayRangeSelection(cell: cell, range: range)
    )
  }
}

@available(iOS 17.0, macOS 14.0, *)
#Preview("Range Selection") {
  @Previewable @State var rangeStart: CalendarDay?
  @Previewable @State var selectedRange: ClosedRange<CalendarDay>?
  @Previewable @State var usesContinuousStyle = true

  var calendar: Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.firstWeekday = 1
    return calendar
  }

  let month = CalendarMonth(8, year: 2026, calendar: calendar)

  VStack(spacing: 16) {
    Toggle("Continuous background", isOn: $usesContinuousStyle)

    WeekdayLabels(using: calendar)

    DaysOfMonthGrid(month: month) { cell in
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
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true

        withTransaction(transaction) {
          if let start = rangeStart {
            if start == cell.calendarDay {
              rangeStart = nil
            } else {
              selectedRange = start.closedRange(to: cell.calendarDay)
              rangeStart = nil
            }
          } else {
            rangeStart = cell.calendarDay
            selectedRange = nil
          }
        }
      }
      .accessibilityAddTraits(.isButton)
    }
  }
  .padding()
}
