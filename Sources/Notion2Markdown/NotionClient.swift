// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

public struct Notion2MarkdownClient {
    // MARK: Properties

    private let databaseID: String
    private let internalClient: NotionClient

    // MARK: Initialization

    public init(notionToken: String, databaseID: String) {
        self.internalClient = NotionSwift.NotionClient(
            accessKeyProvider: StringAccessKeyProvider(accessKey: notionToken)
        )
        self.databaseID = databaseID
    }

    // MARK: Database Query

    /// Enumerates a list of pages within the database.
    public func enumerateDatabasePages(params: DatabaseQueryParams = .init()) async throws -> [Page] {
        try await internalClient.databaseQuery(
            databaseId: .init(databaseID),
            params: params
        ).results
    }

    // MARK: Markdown Conversion

    public func convertPageToMarkdown(_ page: Page) async throws -> String {
        guard let pageTitle = page.plainTextTitle else {
            throw Notion2MarkdownError.pageMissingTitle
        }

        // Retrieve the blocks from the page.
        let blocks = try await internalClient.allBlockChildren(blockId: page.id.toBlockIdentifier)

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
