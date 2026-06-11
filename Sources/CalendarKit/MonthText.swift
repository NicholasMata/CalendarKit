//
//  MonthText.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 4/26/25.
//
import SwiftUI

extension Text {
  /// Creates text containing a formatted month string for the supplied date.
  public init(month style: Date.FormatStyle.Symbol.Month, for month: Date) {
    self.init(month.formatted(Date.FormatStyle().month(style)))
  }
  /// Creates text containing a formatted year string for the supplied date.
  public init(year style: Date.FormatStyle.Symbol.Year, for year: Date) {
    self.init(year.formatted(Date.FormatStyle().year(style)))
  }
}

#Preview {
  HStack {
    Text(month: .abbreviated, for: Date())
    Text(year: .defaultDigits, for: Date())
  }
}
