//
//  Notion2Markdown.swift
//
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation
import NotionSwift

public class Notion2Markdown {
    // MARK: Properties

    private let notion: NotionClient

    // MARK: Initialization

    init(notionToken: String) {
        self.notion = NotionClient(accessKeyProvider: StringAccessKeyProvider(accessKey: notionToken))
    }

    func run(databaseID: String, outputDirectory: URL) async throws {
        let page = try await selectPageToPublish(databaseID: .init(databaseID))
        guard let fileName = page.plainTextTitle else {
            throw Notion2MarkdownError.pageMissingTitle
        }

        let markdown = try await convertPageToMarkdown(page)
        try saveMarkdownFile(
            fileName: fileName.replacingOccurrences(of: " ", with: "-"),
            markdownContents: markdown,
            outputDirectory: outputDirectory
        )
    }
    
    /// Displays a list of publishable pages and prompts the user to select one.
    /// - Returns: The `Page` the user selected.
    private func selectPageToPublish(databaseID: Database.ID) async throws -> Page {
        let response = try await notion.databaseQuery(databaseId: databaseID)

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

    private func convertPageToMarkdown(_ page: Page) async throws -> String {
        // Retrieve the blocks from the page.
        // TODO: Support pagination
        let blocks = try await notion.blockChildren(blockId: page.id.toBlockIdentifier)
        
        var markdownBlocks: [String] = []

        // If we have a page title, add it as a heading in the final markdown
        if let pageTitle = page.plainTextTitle {
            markdownBlocks.append(pageTitle.convertedToMarkdown(.heading1))
        }

        // Quick way to handle numbered lists -> just increment each time we encounter one, otherwise reset the value.
        var currentNumberedListIndex = 1
        for block in blocks.results {
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

    private func saveMarkdownFile(
        fileName: String,
        markdownContents: String,
        outputDirectory: URL
    ) throws {
        let yamlFrontMatter = """
        ---
        author: Kyle Haptonstall
        date: \(DateFormatter.yamlDateFormatter.string(from: .now))
        ---
        """

        let pageContents = [yamlFrontMatter, markdownContents].joined(separator: .newline)
        let url = outputDirectory.appending(path: "\(fileName).md")
        try pageContents.write(to: url, atomically: true, encoding: .utf8)
    }
}

private extension DateFormatter {
  /// A date formatted used for dates contained within YAML front matter. Formats dates in the style `y-MM-dd HH:mm` (e.g. 2024-01-30 08:00).
  static let yamlDateFormatter: DateFormatter = {
      var formatter = DateFormatter()
      formatter.dateFormat = "y-MM-dd HH:mm"
      return formatter
  }()
}
