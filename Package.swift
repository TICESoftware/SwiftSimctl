// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftSimctl",
    platforms: [
        .iOS(.v15),
        .tvOS(.v11),
        .macOS(.v10_12)
    ],
    products: [
        .executable(name: "SimctlCLI", targets: ["SimctlCLI"]),
        .library(name: "Simctl", targets: ["Simctl"])
    ],
    dependencies: [
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(name: "ShellOut", url: "https://github.com/JohnSundell/ShellOut.git", from: "2.3.0"),
        .package(name: "Swifter",  url: "https://github.com/httpswift/swifter.git", from: "1.5.0")
    ],
    targets: [
        .target(name: "SimctlShared"),
        .target(name: "SimctlCLI", dependencies: [
            "SimctlShared", 
            "ShellOut", 
            "Swifter", 
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .target(name: "Simctl", dependencies: ["SimctlShared"])
    ],
    swiftLanguageVersions: [.v5]
)
