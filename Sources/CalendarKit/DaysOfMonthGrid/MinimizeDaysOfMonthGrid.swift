//
//  MinimizeDaysOfMonthGrid.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import SwiftUI

/// A view modifier that vertically collapses a month grid toward a selected week row.
public struct MinimizeDaysOfMonthGrid: ViewModifier {
  var progress: CGFloat
  var weekInMonth: Int
  var dayHeight: CGFloat
  @State private var size: CGSize = .zero

  /// Creates a modifier that reduces a month grid toward a single visible week.
  ///
  /// - Parameters:
  ///   - progress: A value between `0` and `1` describing the collapse progress.
  ///   - weekInMonth: The zero-based week row to keep visible as the grid collapses.
  ///   - dayHeight: The height of an individual day row.
  public init(progress: CGFloat, weekInMonth: Int, dayHeight: CGFloat = DefaultDayView.height) {
    self.progress = progress
    self.weekInMonth = weekInMonth
    self.dayHeight = dayHeight
  }

  /// Returns the modified content with the collapsing month-grid effect applied.
  public func body(content: Content) -> some View {
    content
      .onGeometryChange(for: CGSize.self) { proxy in
        proxy.size
      } action: {
        size = $0
      }
      .frame(
        height: size.height - ((size.height - dayHeight) * progress),
        alignment: .top
      )
      .offset(y: (CGFloat(weekInMonth) * -dayHeight) * progress)
      .contentShape(.rect)
      .clipped()
  }
}

public extension View {
  /// Collapses a month grid toward a single visible week row.
  func minimizeMonthGrid(
    progress: CGFloat,
    toWeek weekInMonth: Int = 0,
    usingDayHeight dayHeight: CGFloat = DefaultDayView.height
  ) -> some View {
    modifier(
      MinimizeDaysOfMonthGrid(
        progress: progress,
        weekInMonth: weekInMonth,
        dayHeight: dayHeight
      )
    )
  }
}
