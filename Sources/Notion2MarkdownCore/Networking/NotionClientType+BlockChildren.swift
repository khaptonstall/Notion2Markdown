// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension NotionClientType {
    /// Recursively fetches all child blocks of the given `blockId`.
    /// - Parameters:
    ///   - blockId: The identifier of the block whose children will be fetched
    ///   - blocks: Used internally to collect all child blocks.
    ///   - cursor: Used internally to fetch the next page of child blocks.
    ///   - hasMore: Used internally to determine if there are more child blocks to fetch.
    func allBlockChildren(
        blockId: Block.Identifier,
        blocks: [ReadBlock] = [],
        cursor: String? = nil,
        hasMore: Bool = true
    ) async throws -> [ReadBlock] {
        guard hasMore else { return blocks }

        try Task.checkCancellation()

        let response = try await blockChildren(
            blockId: blockId,
            params: .init(startCursor: cursor)
        )

        var latestBlocks = blocks
        for block in response.results {
            // Add the current block to the list
            latestBlocks.append(block)

            // If the block has children, recursively fetch them
            if block.hasChildren {
                let childBlocks = try await allBlockChildren(blockId: block.id)
                latestBlocks.append(contentsOf: childBlocks)
            }
        }

        return try await allBlockChildren(
            blockId: blockId,
            blocks: latestBlocks,
            cursor: response.nextCursor,
            hasMore: response.hasMore
        )
    }
}
