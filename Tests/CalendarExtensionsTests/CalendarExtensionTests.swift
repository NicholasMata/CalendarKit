import Foundation
//
//  CalendarExtensionTests.swift
//  CalendarKit
//
//  Created by Nicholas Mata on 2/25/25.
//
import Testing

@testable import CalendarExtensions

let calendar = Calendar.current

@Test(
  arguments: zip([
    Date(month: 1, year: 2025),
    Date(day: 31, month: 12, year: 2024),
    Date(day: 28, month: 2, year: 2024),
  ],
  [
    Date(day: 8, month: 1, year: 2025),
    Date(day: 7, month: 1, year: 2025),
    Date(day: 7, month: 3, year: 2024),
  ])
)
func testNumberOfWeeks(_ start: Date, _ end: Date) {
  let startWeek = CalendarWeek(containing: start, calendar: calendar)
  let endWeek = CalendarWeek(containing: end, calendar: calendar)
  let result = startWeek.distance(to: endWeek)
  #expect(result == 1, "Expected 1 week difference.")
}

@Test func testNumberOfWeeksAcrossMultipleWeeks() {
  let startWeek = CalendarWeek(
    containing: Date(day: 1, month: 1, year: 2025),
    calendar: calendar)
  let endWeek = CalendarWeek(
    containing: Date(day: 1, month: 2, year: 2025),
    calendar: calendar)

  #expect(startWeek.distance(to: endWeek) == 4)
}

@Test func testNumberOfWeeksWithinSameWeek() {
  let week = CalendarWeek(
    containing: Date(day: 1, month: 1, year: 2025),
    calendar: calendar)

  #expect(week.distance(to: week) == 0)
}
