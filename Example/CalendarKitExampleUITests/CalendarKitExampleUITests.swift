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

    let initiallySelectedDay = app.buttons["single-day-2026-08-05"]
    let replacementDay = app.buttons["single-day-2026-08-12"]

    XCTAssertEqual(initiallySelectedDay.value as? String, "Selected")
    XCTAssertEqual(replacementDay.value as? String, "Not selected")

    replacementDay.tap()

    XCTAssertEqual(initiallySelectedDay.value as? String, "Not selected")
    XCTAssertEqual(replacementDay.value as? String, "Selected")
  }

  func testSelectingMultipleDaysPreservesExistingSelection() {
    app.launch()

    app.buttons["multiple-selection-example"].tap()

    let existingDay = app.buttons["multiple-day-2026-08-05"]
    let additionalDay = app.buttons["multiple-day-2026-08-12"]
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

    let laterDay = app.buttons["range-day-2026-08-25"]
    let earlierDay = app.buttons["range-day-2026-08-20"]
    laterDay.tap()
    earlierDay.tap()

    XCTAssertEqual(earlierDay.value as? String, "Selected")
    XCTAssertEqual(laterDay.value as? String, "Selected")
    XCTAssertEqual(
      app.buttons["range-day-2026-08-05"].value as? String,
      "Not selected"
    )

    let stylePicker = app.segmentedControls["range-style-picker"]
    XCTAssertTrue(stylePicker.buttons["Continuous"].exists)
    XCTAssertTrue(stylePicker.buttons["Individual"].exists)
  }

  func testCollapsingMonthGridKeepsSelectedWeekVisible() {
    app.launch()

    app.buttons["collapsible-grid-example"].tap()

    let selectedDay = app.buttons["collapsible-day-2026-08-26"]
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
}
