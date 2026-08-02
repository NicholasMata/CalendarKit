//
//  ColorExtension.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 6/14/26.
//

import SwiftUI

extension Color {
  static var platformLabel: Color {
    #if canImport(UIKit)
    return Color(uiColor: .label)
    #elseif canImport(AppKit)
    return Color(nsColor: .labelColor)
    #else
    return .primary
    #endif
  }
}
