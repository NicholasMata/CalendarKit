import CalendarExtensions
import Foundation

@MainActor
enum SampleCalendar {
  static let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    calendar.firstWeekday = 1
    return calendar
  }()

  static let month = CalendarMonth(8, year: 2026, calendar: calendar)

  static func identifier(for day: CalendarDay, prefix: String) -> String {
    String(format: "%@-%04d-%02d-%02d", prefix, day.year, day.monthNumber, day.dayOfMonth)
  }

  static func accessibilityLabel(for day: CalendarDay) -> String {
    let formatter = DateFormatter()
    formatter.calendar = calendar
    formatter.locale = calendar.locale
    formatter.timeZone = calendar.timeZone
    formatter.dateStyle = .full
    return formatter.string(from: day.date)
  }
}
