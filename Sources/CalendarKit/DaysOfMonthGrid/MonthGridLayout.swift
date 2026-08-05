//
//  MonthGridLayout.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 8/5/26.
//

import SwiftUI

/// Shared layout defaults for calendar month grids.
public enum MonthGridLayout {
  /// The default height of a day row in a month grid.
  public static let defaultDayHeight: CGFloat = 60
}

private struct MonthGridDayHeightKey: EnvironmentKey {
  static let defaultValue = MonthGridLayout.defaultDayHeight
}

extension EnvironmentValues {
  var monthGridDayHeight: CGFloat {
    get { self[MonthGridDayHeightKey.self] }
    set { self[MonthGridDayHeightKey.self] = newValue }
  }
}

public extension View {
  /// Sets the height of each day row in a month grid and its related modifiers.
  ///
  /// Apply this after modifiers such as `minimizeMonthGrid(progress:toWeek:)`
  /// so the value is available to the entire month-grid composition.
  func monthGridDayHeight(_ height: CGFloat) -> some View {
    environment(\.monthGridDayHeight, height)
  }
}
