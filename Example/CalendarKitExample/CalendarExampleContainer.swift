import SwiftUI

struct CalendarExampleContainer<Content: View>: View {
  let title: String
  let subtitle: String
  @ViewBuilder let content: () -> Content

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        VStack(alignment: .leading, spacing: 4) {
          Text(title)
            .font(.title2.bold())
          Text(subtitle)
            .foregroundStyle(.secondary)
        }

        content()
      }
      .padding()
    }
  }
}
