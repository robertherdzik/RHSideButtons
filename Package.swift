// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "RHSideButtons",
    platforms: [.iOS(.v8)],
    products: [
        .library(name: "RHSideButtons", targets: ["RHSideButtons"])
    ],
    targets: [
        .target(name: "RHSideButtons", path: "RHSideButtons/RHSideButtons")
    ]
)
