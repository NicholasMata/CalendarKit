import XCTest

@MainActor
final class CalendarKitExampleUITests: XCTestCase {
  private let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testCatalogListsEveryExample() {
    app.launch()

    XCTAssertTrue(app.navigationBars["CalendarKit Examples"].exists)
    XCTAssertTrue(app.buttons["single-selection-example"].exists)
    XCTAssertTrue(app.buttons["multiple-selection-example"].exists)
    XCTAssertTrue(app.buttons["range-selection-example"].exists)
    XCTAssertTrue(app.buttons["collapsible-grid-example"].exists)
    XCTAssertTrue(app.buttons["weekday-labels-example"].exists)
  }

  func testSelectingASingleDayReplacesSelection() {
    app.launch()

    app.buttons["single-selection-example"].tap()

    let initiallySelectedDay = app.buttons[dayIdentifier(prefix: "single-day", offset: 17)]
    let replacementDay = app.buttons[dayIdentifier(prefix: "single-day", offset: 24)]

    XCTAssertEqual(initiallySelectedDay.value as? String, "Selected")
    XCTAssertEqual(replacementDay.value as? String, "Not selected")

    replacementDay.tap()

    XCTAssertEqual(initiallySelectedDay.value as? String, "Not selected")
    XCTAssertEqual(replacementDay.value as? String, "Selected")
  }

  func testSelectingMultipleDaysPreservesExistingSelection() {
    app.launch()

    app.buttons["multiple-selection-example"].tap()

    let existingDay = app.buttons[dayIdentifier(prefix: "multiple-day", offset: 16)]
    let additionalDay = app.buttons[dayIdentifier(prefix: "multiple-day", offset: 23)]
    additionalDay.tap()

    XCTAssertEqual(existingDay.value as? String, "Selected")
    XCTAssertEqual(additionalDay.value as? String, "Selected")
  }

  func testSelectingRangeInEitherDirection() {
    app.launch()

    let example = app.buttons["range-selection-example"]
    if !example.isHittable {
      app.swipeUp()
    }
    example.tap()

    let laterDay = app.buttons[dayIdentifier(prefix: "range-day", offset: 24)]
    let earlierDay = app.buttons[dayIdentifier(prefix: "range-day", offset: 19)]
    laterDay.tap()
    earlierDay.tap()

    XCTAssertEqual(earlierDay.value as? String, "Selected")
    XCTAssertEqual(laterDay.value as? String, "Selected")
    XCTAssertEqual(
      app.buttons[dayIdentifier(prefix: "range-day", offset: 4)].value as? String,
      "Not selected"
    )

    let stylePicker = app.segmentedControls["range-style-picker"]
    XCTAssertTrue(stylePicker.buttons["Continuous"].exists)
    XCTAssertTrue(stylePicker.buttons["Individual"].exists)
  }

  func testCollapsingMonthGridKeepsSelectedWeekVisible() {
    app.launch()

    app.buttons["collapsible-grid-example"].tap()

    let selectedDay = app.buttons[dayIdentifier(prefix: "collapsible-day", offset: 25)]
    selectedDay.tap()

    let picker = app.segmentedControls["grid-state-picker"]
    XCTAssertTrue(picker.exists)
    picker.buttons["Collapsed"].tap()

    XCTAssertEqual(selectedDay.value as? String, "Selected")
    XCTAssertTrue(selectedDay.isHittable)
  }

  func testWeekdayPickerOffersEveryFirstDay() {
    app.launch()
    app.buttons["weekday-labels-example"].tap()

    let picker = app.segmentedControls["first-weekday-picker"]
    XCTAssertTrue(picker.exists)

    for weekday in ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] {
      XCTAssertTrue(picker.buttons[weekday].exists)
    }
  }

  private func dayIdentifier(prefix: String, offset: Int) -> String {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    let month = calendar.dateInterval(of: .month, for: .now)!.start
    let date = calendar.date(byAdding: .day, value: offset, to: month)!
    let components = calendar.dateComponents([.year, .month, .day], from: date)

    return String(
      format: "%@-%04d-%02d-%02d",
      prefix,
      components.year!,
      components.month!,
      components.day!
    )
  }
}
