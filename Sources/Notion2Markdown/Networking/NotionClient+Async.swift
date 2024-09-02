// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension NotionClientType {
    func databaseQuery(databaseId: Database.Identifier, params: DatabaseQueryParams = .init()) async throws -> ListResponse<Page> {
        try await withCheckedThrowingContinuation { continuation in
            databaseQuery(databaseId: databaseId, params: params) { result in
                continuation.resume(with: result)
            }
        }
    }

    func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams = .init()
    ) async throws -> ListResponse<ReadBlock> {
        try await withCheckedThrowingContinuation { continuation in
            blockChildren(
                blockId: blockId,
                params: params
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
}
