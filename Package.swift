// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "deepl-cui-swift",
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "deepl-cui-swift",
      dependencies: [
        "DeepLCore",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .target(
      name: "DeepLCore",
      dependencies: [],
      path: "Sources/core"
    ),
    .testTarget(
      name: "coreTests",
      dependencies: ["DeepLCore"]
    ),
  ]
)
