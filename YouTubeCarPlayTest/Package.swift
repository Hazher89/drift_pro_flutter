// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "YouTubeCarPlayTest",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YouTubeCarPlayTest",
            targets: ["YouTubeCarPlayTest"]),
    ],
    targets: [
        .target(
            name: "YouTubeCarPlayTest",
            dependencies: []),
    ]
)