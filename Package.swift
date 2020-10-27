// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hbslib",
    products: [
        .library(
            name: "hbslib",
            targets: ["hbslib"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "hbslib",
            dependencies: []),
        .testTarget(
            name: "hbslibTests",
            dependencies: ["hbslib"])
    ]
)
