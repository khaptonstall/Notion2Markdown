// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Notion2Markdown",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "notion2markdown", targets: ["CommandLineTool"]),
        .library(name: "Notion2MarkdownCore", targets: ["Notion2MarkdownCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.3.1"),
        .package(url: "https://github.com/chojnac/NotionSwift", exact: "0.8.0"),
    ],
    targets: [
        .executableTarget(
            name: "CommandLineTool",
            dependencies: [
                "Notion2MarkdownCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "Notion2MarkdownCore",
            dependencies: [
                .product(name: "NotionSwift", package: "NotionSwift"),
            ]
        ),
        .testTarget(
            name: "Notion2MarkdownCoreTests",
            dependencies: ["Notion2MarkdownCore"]
        ),
    ]
)
