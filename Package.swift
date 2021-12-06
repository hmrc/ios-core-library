// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-core-library",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ios-core-library",
            targets: ["ios-core-library"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "4.0.0"),
        .package(url: "https://github.com/datatheorem/TrustKit.git", from: "1.7.0"),
        .package(url: "https://github.com/pinterest/PINCache", from: "3.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ios-core-library",
            dependencies: ["DeviceKit", "TrustKit","PINCache"]),
        .testTarget(
            name: "ios-core-libraryTests",
            dependencies: ["ios-core-library"]),
    ]
)
