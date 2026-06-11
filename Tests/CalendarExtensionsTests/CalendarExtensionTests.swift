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
  let result = calendar.numberOfWeeks(from: start, to: end)
  #expect(result == 1, "Expected 1 week difference.")
}

//@Test func testNumberOfWeeksAcrossYears() {
//  let start = calendar.date(
//    from: DateComponents(year: 2024, month: 12, day: 31))!
//  let end = calendar.date(from: DateComponents(year: 2025, month: 1, day: 7))!
//
//  let result = calendar.numberOfWeeks(from: start, to: end)
//  XCTAssertEqual(result, 1, "Expected 1 week difference.")
//}
//
//@Test func testNumberOfWeeksDifferentMonths() {
//  let start = calendar.date(from: DateComponents(year: 2025, month: 1, day: 1))!
//  let end = calendar.date(from: DateComponents(year: 2025, month: 2, day: 1))!
//
//  let result = calendar.numberOfWeeks(from: start, to: end)
//  XCTAssertEqual(result, 4, "Expected 4 weeks difference.")
//}
//
//@Test func testNumberOfWeeksSameDay() {
//  let date = calendar.date(from: DateComponents(year: 2025, month: 1, day: 1))!
//
//  let result = calendar.numberOfWeeks(from: date, to: date)
//  XCTAssertEqual(result, 0, "Expected 0 weeks difference.")
//}
//
//@Test func testNumberOfWeeksLeapYear() {
//  let start = calendar.date(
//    from: DateComponents(year: 2024, month: 2, day: 28))!
//  let end = calendar.date(from: DateComponents(year: 2024, month: 3, day: 7))!
//
//  let result = calendar.numberOfWeeks(from: start, to: end)
//  XCTAssertEqual(result, 1, "Expected 1 week difference.")
//}
