// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import ArgumentParser
import Foundation
import Notion2MarkdownCore
import NotionSwift

@main
struct CommandLineTool: AsyncParsableCommand {
    // MARK: Configuration

    static let configuration = CommandConfiguration(
        commandName: "notion2markdown",
        abstract: "A command-line tool for converting Notion pages into markdown."
    )

    // MARK: Arguments

    @Option(help: "Your Notion integration token.")
    var notionToken: String

    @Option(help: "The identifier of your Notion database to read from.")
    var databaseID: String

    @Option(help: "The markdown file output path")
    var output: String = "output.md"

    @Flag(help: "Whether the Notion Page's title should be appended as an H1 element to the final output file")
    var prefixPageTitle: Bool = false

    // MARK: Command

    mutating func run() async throws {
        let client = Notion2MarkdownClient(notionToken: notionToken)

        // Select a Page
        let page = try await selectPageToPublish(notionClient: client)

        // Convert and save to a markdown file
        try await client.convertPageToMarkdown(page, outputPath: output, prefixPageTitle: prefixPageTitle)
    }

    // MARK: Private API

    /// Displays a list of publishable pages and prompts the user to select one.
    /// - Returns: The `Page` the user selected.
    private func selectPageToPublish(notionClient: Notion2MarkdownClient) async throws -> Page {
        let response = try await notionClient.enumerateDatabasePages(databaseID: databaseID)

        print("Select a page you'd like to publish (enter the page index):")
        for (index, page) in response.enumerated() {
            print("\(index): \(page.plainTextTitle ?? "Title not found")")
        }

        guard let input = readLine(), let selectedIndex = Int(input) else {
            throw Notion2MarkdownError.invalidPageSelectionInput
        }

        guard response.indices.contains(selectedIndex) else {
            throw Notion2MarkdownError.invalidPageSelectionIndex
        }

        let page = response[selectedIndex]
        print("Selected page \(page.plainTextTitle ?? "Title not found")")
        return page
    }
}
