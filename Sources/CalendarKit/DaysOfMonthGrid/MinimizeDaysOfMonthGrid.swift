//
//  MinimizeDaysOfMonthGrid.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 5/16/26.
//

import SwiftUI

/// A view modifier that vertically collapses a month grid toward a selected week row.
public struct MinimizeDaysOfMonthGrid: ViewModifier {
  @Environment(\.monthGridDayHeight) private var dayHeight

  var progress: CGFloat
  var weekInMonth: Int
  @State private var size: CGSize = .zero

  /// Creates a modifier that reduces a month grid toward a single visible week.
  ///
  /// - Parameters:
  ///   - progress: A value between `0` and `1` describing the collapse progress.
  ///   - weekInMonth: The zero-based week row to keep visible as the grid collapses.
  public init(progress: CGFloat, weekInMonth: Int) {
    self.progress = progress
    self.weekInMonth = weekInMonth
  }

  static func collapsedHeight(
    expandedHeight: CGFloat,
    dayHeight: CGFloat,
    progress: CGFloat
  ) -> CGFloat {
    expandedHeight - ((expandedHeight - dayHeight) * progress)
  }

  static func verticalOffset(
    weekInMonth: Int,
    dayHeight: CGFloat,
    progress: CGFloat
  ) -> CGFloat {
    CGFloat(weekInMonth) * -dayHeight * progress
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
        height: Self.collapsedHeight(
          expandedHeight: size.height,
          dayHeight: dayHeight,
          progress: progress
        ),
        alignment: .top
      )
      .offset(y: Self.verticalOffset(
        weekInMonth: weekInMonth,
        dayHeight: dayHeight,
        progress: progress
      ))
      .contentShape(.rect)
      .clipped()
  }
}

public extension View {
  /// Collapses a month grid toward a single visible week row.
  func minimizeMonthGrid(
    progress: CGFloat,
    toWeek weekInMonth: Int = 0
  ) -> some View {
    modifier(
      MinimizeDaysOfMonthGrid(
        progress: progress,
        weekInMonth: weekInMonth
      )
    )
  }
}
