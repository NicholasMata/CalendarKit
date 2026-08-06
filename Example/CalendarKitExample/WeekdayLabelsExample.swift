import CalendarKit
import SwiftUI

struct WeekdayLabelsExample: View {
  @State private var firstWeekday = 1

  private var calendar: Calendar {
    var calendar = SampleCalendar.calendar
    calendar.firstWeekday = firstWeekday
    return calendar
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 28) {
        VStack(alignment: .leading, spacing: 8) {
          Text("First day of week")
            .font(.headline)

          Picker("First day of week", selection: $firstWeekday) {
            ForEach(1 ..< calendar.weekdaySymbols.count + 1, id: \.self) { weekday in
              Text(calendar.shortWeekdaySymbols[weekday - 1])
                .tag(weekday)
            }
          }
          .pickerStyle(.segmented)
          .accessibilityIdentifier("first-weekday-picker")
        }

        LabelExample(title: "Wide") {
          WeekdayLabels(style: .wide, using: calendar)
            .font(.system(size: 8))
            .lineLimit(1)
        }
        LabelExample(title: "Abbreviated") {
          WeekdayLabels(style: .abbreviated, using: calendar)
        }
        LabelExample(title: "Short") {
          WeekdayLabels(style: .short, using: calendar)
        }
        LabelExample(title: "Narrow") {
          WeekdayLabels(style: .narrow, using: calendar)
        }
        LabelExample(title: "One digit") {
          WeekdayLabels(style: .oneDigit, using: calendar)
        }
        LabelExample(title: "Two digits") {
          WeekdayLabels(style: .twoDigits, using: calendar)
        }
      }
      .padding()
    }
    .navigationTitle("Weekday Labels")
    .navigationBarTitleDisplayMode(.inline)
  }
}

private struct LabelExample<Content: View>: View {
  let title: String
  @ViewBuilder let content: () -> Content

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)
      content()
        .font(.caption)
    }
  }
}
