//
//  NotionClient+Async.swift
//  
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation
import NotionSwift

extension NotionClient {
    func databaseQuery(databaseId: Database.Identifier) async throws -> ListResponse<Page> {
        try await withCheckedThrowingContinuation { continuation in
            databaseQuery(databaseId: databaseId) { result in
                continuation.resume(with: result)
            }
        }
    }

    func blockChildren(blockId: Block.Identifier) async throws -> ListResponse<ReadBlock> {
        try await withCheckedThrowingContinuation { continuation in
            blockChildren(blockId: blockId) { result in
                continuation.resume(with: result)
            }
        }
    }
}

