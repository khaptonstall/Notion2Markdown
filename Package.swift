// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Notion2Markdown",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/chojnac/NotionSwift", exact: "0.8.0"),
    ],
    targets: [
        .executableTarget(
            name: "notion2markdown",
            dependencies: ["NotionSwift"]
        ),
    ]
)
