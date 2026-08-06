import SwiftUI

struct ExampleCatalogView: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVStack(spacing: 16) {
          ExampleLink(
            title: "Single Day Selection",
            description: "Select one day from a fixed month grid.",
            systemImage: "calendar.badge.checkmark",
            accessibilityIdentifier: "single-selection-example"
          ) {
            SingleSelectionExample()
          }

          ExampleLink(
            title: "Multiple Day Selection",
            description: "Build multi-selection with CalendarDay identifiers.",
            systemImage: "checkmark.circle.badge.questionmark",
            accessibilityIdentifier: "multiple-selection-example"
          ) {
            MultipleSelectionExample()
          }

          ExampleLink(
            title: "Collapsible Month Grid",
            description: "Collapse a month toward a selected week.",
            systemImage: "rectangle.compress.vertical",
            accessibilityIdentifier: "collapsible-grid-example"
          ) {
            CollapsibleMonthGridExample()
          }

          ExampleLink(
            title: "Weekday Labels",
            description: "Compare localized labels and first weekdays.",
            systemImage: "textformat",
            accessibilityIdentifier: "weekday-labels-example"
          ) {
            WeekdayLabelsExample()
          }
        }
        .padding()
      }
      .navigationTitle("CalendarKit Examples")
      .accessibilityIdentifier("example-catalog")
    }
  }
}

private struct ExampleLink<Destination: View>: View {
  let title: String
  let description: String
  let systemImage: String
  let accessibilityIdentifier: String
  @ViewBuilder let destination: () -> Destination

  var body: some View {
    NavigationLink(destination: destination) {
      HStack(spacing: 16) {
        Image(systemName: systemImage)
          .font(.title2)
          .frame(width: 32)
          .foregroundStyle(.tint)

        VStack(alignment: .leading, spacing: 4) {
          Text(title)
            .font(.headline)
            .foregroundStyle(.primary)
          Text(description)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
        }

        Spacer()

        Image(systemName: "chevron.right")
          .font(.caption.weight(.semibold))
          .foregroundStyle(.tertiary)
      }
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
    }
    .buttonStyle(.plain)
    .accessibilityIdentifier(accessibilityIdentifier)
  }
}

#Preview {
  ExampleCatalogView()
}
