import Foundation

func testGregorianCalendar(firstWeekday: Int = 1) -> Calendar {
  var calendar = Calendar(identifier: .gregorian)
  calendar.locale = Locale(identifier: "en_US_POSIX")
  calendar.timeZone = TimeZone(secondsFromGMT: 0)!
  calendar.firstWeekday = firstWeekday
  return calendar
}
