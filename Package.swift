// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SolidPrinciples",
    products: [
        .library(
            name: "SolidPrinciples",
            targets: ["SolidPrinciples"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SolidPrinciples",
            dependencies: []),
        .testTarget(
            name: "SolidPrincipleTests",
            dependencies: ["SolidPrinciples"]),
    ]
)
