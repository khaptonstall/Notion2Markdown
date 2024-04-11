// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import ArgumentParser
import Foundation
import NotionSwift

@main
struct Notion2Markdown: AsyncParsableCommand {
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

    @Option(help: "The directory to output the markdown file")
    var outputDirectory: String?

    // MARK: Command

    mutating func run() async throws {
        let client = NotionClient(accessKeyProvider: StringAccessKeyProvider(accessKey: notionToken))

        // Select a Page
        let page = try await selectPageToPublish(databaseID: .init(databaseID), notionClient: client)
        guard let pageTitle = page.plainTextTitle else {
            throw Notion2MarkdownError.pageMissingTitle
        }

        // Convert to markdown
        let markdown = try await convertPageToMarkdown(page, pageTitle: pageTitle, notionClient: client)

        // Either print to the console, or save to the provided output directory
        if let outputDirectory {
            let outputURL = URL(fileURLWithPath: outputDirectory, isDirectory: true)
                .appending(path: "\(pageTitle.replacingOccurrences(of: " ", with: "-")).md")
            try markdown.write(to: outputURL, atomically: true, encoding: .utf8)
        } else {
            print(markdown)
        }
    }

    // MARK: Private API

    /// Displays a list of publishable pages and prompts the user to select one.
    /// - Returns: The `Page` the user selected.
    private func selectPageToPublish(databaseID: Database.ID, notionClient: NotionClient) async throws -> Page {
        let response = try await notionClient.databaseQuery(databaseId: databaseID)

        print("Select a page you'd like to publish (enter the page index):")
        for (index, page) in response.results.enumerated() {
            print("\(index): \(page.plainTextTitle ?? "Title not found")")
        }

        guard let input = readLine(), let selectedIndex = Int(input) else {
            throw Notion2MarkdownError.invalidPageSelectionInput
        }

        guard response.results.indices.contains(selectedIndex) else {
            throw Notion2MarkdownError.invalidPageSelectionIndex
        }

        let page = response.results[selectedIndex]
        print("Selected page \(page.plainTextTitle ?? "Title not found")")
        return page
    }

    private func convertPageToMarkdown(_ page: Page, pageTitle: String, notionClient: NotionClient) async throws -> String {
        // Retrieve the blocks from the page.
        let blocks = try await notionClient.allBlockChildren(blockId: page.id.toBlockIdentifier)

        var markdownBlocks: [String] = []

        // Add the title as a heading in the final markdown
        markdownBlocks.append(pageTitle.convertedToMarkdown(.heading1))

        // Quick way to handle numbered lists -> just increment each time we encounter one, otherwise reset the value.
        var currentNumberedListIndex = 1
        for block in blocks {
            switch block.type {
            case .numberedListItem:
                markdownBlocks.append(block.type.asMarkdown.convertedToMarkdown(.numberedListItem(number: currentNumberedListIndex)))
                currentNumberedListIndex += 1
            default:
                if currentNumberedListIndex != 1 { currentNumberedListIndex = 1 }
                markdownBlocks.append(block.type.asMarkdown)
            }
        }

        return markdownBlocks.joined(separator: .doubleNewline)
    }
}
