//
//  DefaultDayView.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//
import CalendarExtensions
import SwiftUI

/// A default visual representation for a day in a calendar grid.
public struct DefaultDayView<Label: View>: View {
  var isToday: Bool
  var isSelected: Bool
  var isDimmed: Bool
  private var label: Label

  /// Creates a day cell with resolved presentation state and custom label content.
  ///
  /// - Parameters:
  ///   - isToday: Whether the cell represents today.
  ///   - isSelected: Whether the cell is selected.
  ///   - isDimmed: Whether the cell should use a secondary foreground style.
  ///   - label: The content displayed by the cell.
  public init(
    isToday: Bool,
    isSelected: Bool,
    isDimmed: Bool = false,
    @ViewBuilder label: () -> Label
  ) {
    self.isToday = isToday
    self.isSelected = isSelected
    self.isDimmed = isDimmed
    self.label = label()
  }

  /// The rendered day cell view.
  public var body: some View {
    label
      .foregroundStyle(
        isDimmed ? .secondary : (isSelected ? Color.white : .primary)
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(alignment: .bottom) {
        if isToday {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.platformLabel)
            .frame(width: 35, height: 5)
        }
      }
      .background(alignment: .center) {
        if isSelected {
          RoundedRectangle(cornerRadius: 4)
            .fill(.tint)
            .frame(width: 35, height: 35)
        }
      }
      .contentShape(.rect)
  }
}

public extension DefaultDayView where Label == Text {
  /// Creates a text day cell with externally resolved selection state.
  ///
  /// - Parameters:
  ///   - cell: The month-grid cell to display.
  ///   - isSelected: Whether the day is selected.
  init(
    cell: MonthGridDay,
    isSelected: Bool
  ) {
    self.init(
      isToday: cell.calendarDay.calendar.isDateInToday(cell.calendarDay.date),
      isSelected: isSelected,
      isDimmed: cell.isOutsideMonth
    ) {
      Text(cell.calendarDay.dayOfMonth, format: .number)
    }
  }

  /// Creates a text day cell with optional single-selection highlighting.
  ///
  /// - Parameters:
  ///   - cell: The month-grid cell to display.
  ///   - selectedDate: The selected date, or `nil` when there is no selection.
  init(
    cell: MonthGridDay,
    selectedDate: Date? = nil
  ) {
    self.init(
      cell: cell,
      isSelected: selectedDate.map {
        cell.calendarDay.calendar.isDate(cell.calendarDay.date, inSameDayAs: $0)
      } ?? false
    )
  }
}
