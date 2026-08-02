// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CalendarKit",
  platforms: [.iOS(.v17), .macOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "CalendarKit",
      targets: ["CalendarKit"]),
    .library(
      name: "CalendarUI",
      targets: ["CalendarUI"]
    ),
    .library(
      name: "CalendarExtensions",
      targets: ["CalendarExtensions"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.5.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "CalendarExtensions"),
    .testTarget(
      name: "CalendarExtensionsTests",
      dependencies: ["CalendarExtensions"]
    ),
    .target(
      name: "CalendarKit",
      dependencies: ["CalendarExtensions"]
    ),
    .target(
      name: "CalendarUI",
      dependencies: ["CalendarKit"]
    ),
    .testTarget(
      name: "CalendarKitTests",
      dependencies: ["CalendarKit"]
    ),
  ]
)
