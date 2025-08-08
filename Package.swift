// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "settings-kit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .macCatalyst(.v14),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SettingsKit",
            targets: ["SettingsKit"]
        ),
        .executable(
            name: "SettingsKitClient",
            targets: ["SettingsKitClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "601.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.

        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "SettingsKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(
            name: "SettingsKit",
            dependencies: ["SettingsKitMacros"]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "SettingsKitClient", dependencies: ["SettingsKit"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "SettingsKitTests",
            dependencies: ["SettingsKit"]
        ),
    ]
)
