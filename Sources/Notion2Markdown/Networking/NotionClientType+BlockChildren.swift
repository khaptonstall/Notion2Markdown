//
//  NotionClientType+BlockChildren.swift
//
//
//  Created by Kyle Haptonstall on 4/11/24.
//

import Foundation
import NotionSwift

extension NotionClientType {
    /// Recursively fetches all child blocks of the given `blockId`.
    /// - Parameters:
    ///   - blockId: The identifier of the block whose children will be fetched
    ///   - blocks: Used internally to collect all child blocks.
    ///   - cursor: Used internally to fetch the next page of child blocks.
    ///   - hasMore: Used internally to determine if there are more child blocks to fetch.
    func allBlockChildren(blockId: Block.Identifier,
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
        latestBlocks.append(contentsOf: response.results)

        return try await allBlockChildren(
            blockId: blockId,
            blocks: latestBlocks,
            cursor: response.nextCursor,
            hasMore: response.hasMore
        )
    }

}
