// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "mahjong",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "mahjong", targets: ["mahjong"])
    ],
    targets: [
        .executableTarget(
            name: "mahjong",
            path: "Sources"
        ),
        .testTarget(
            name: "MahjongTests",
            dependencies: ["mahjong"],
            path: "Tests/MahjongTests"
        )
    ]
)
