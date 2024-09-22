// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

public struct Notion2MarkdownClient {
    // MARK: Properties

    private let internalClient: NotionClientType
    private let fileManager: FileManaging
    private let fileDownloader: FileDownloading

    // MARK: Initialization

    public init(notionToken: String) {
        let client = NotionSwift.NotionClient(
            accessKeyProvider: StringAccessKeyProvider(accessKey: notionToken)
        )
        self.init(internalClient: client)
    }

    init(
        internalClient: NotionClientType,
        fileManager: FileManaging = FileManager.default,
        fileDownloader: FileDownloading = URLSession.shared
    ) {
        self.internalClient = internalClient
        self.fileManager = fileManager
        self.fileDownloader = fileDownloader
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

    public func convertPageToMarkdown(_ page: Page, outputDirectory: String) async throws {
        guard let pageTitle = page.plainTextTitle else {
            throw Notion2MarkdownError.pageMissingTitle
        }

        // Retrieve the blocks from the page.
        let blocks = try await internalClient.allBlockChildren(blockId: page.id.toBlockIdentifier)

        // Add the title as a heading in the final markdown
        var markdownBlocks: [String] = [pageTitle.convertedToMarkdown(.heading1)]
        markdownBlocks.append(contentsOf: blocks.compactMap { $0.type.asMarkdown })

        // Save the markdown file
        let markdown = markdownBlocks.joined(separator: .doubleNewline)

        let outputURL = URL(fileURLWithPath: outputDirectory, isDirectory: true)
            .appending(path: "\(pageTitle.replacingOccurrences(of: " ", with: "-")).md")
        try fileManager.write(markdown, to: outputURL, atomically: true, encoding: .utf8)

        // Download all referenced images
        try await withThrowingTaskGroup(of: Void.self) { group in
            for imageURL in blocks.imageURLs {
                group.addTask {
                    let (downloadURL, _) = try await fileDownloader.download(for: URLRequest(url: imageURL))

                    let outputURL = URL(fileURLWithPath: outputDirectory)
                    try fileManager.moveItem(
                        at: downloadURL,
                        to: outputURL.appending(path: imageURL.lastPathComponent)
                    )
                }
            }

            try await group.waitForAll()
        }
    }
}
