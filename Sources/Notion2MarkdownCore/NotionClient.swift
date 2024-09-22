// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

public struct Notion2MarkdownClient {
    // MARK: Properties

    private let internalClient: NotionClientType

    // MARK: Initialization

    public init(notionToken: String) {
        let client = NotionSwift.NotionClient(
            accessKeyProvider: StringAccessKeyProvider(accessKey: notionToken)
        )
        self.init(internalClient: client)
    }

    init(internalClient: any NotionClientType) {
        self.internalClient = internalClient
    }

    // MARK: Database Query

    /// Enumerates a list of pages within the database.
    public func enumerateDatabasePages(
        databaseID: String,
        params: DatabaseQueryParams = .init()
    ) async throws -> [Page] {
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

        for block in blocks {
            guard let blockMarkdown = block.type.asMarkdown else { continue }
            markdownBlocks.append(blockMarkdown)
        }

        return markdownBlocks.joined(separator: .doubleNewline)
    }
}
