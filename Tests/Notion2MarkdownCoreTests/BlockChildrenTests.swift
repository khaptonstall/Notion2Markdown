// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
@testable import Notion2MarkdownCore
import NotionSwift
import XCTest

class BlockChildrenTests: XCTestCase {
    func testBlockChildrenPagination() async throws {
        // Setup a mock client and prepare multiple expected block responses
        let client = MockNotionClient()
        let blocks: [ReadBlock] = [
            .mocked(id: "1", type: .heading1(.init(arrayLiteral: .mocked()))),
            .mocked(id: "2", type: .heading1(.init(arrayLiteral: .mocked()))),
            .mocked(id: "3", type: .heading1(.init(arrayLiteral: .mocked()))),
            .mocked(id: "4", type: .heading1(.init(arrayLiteral: .mocked()))),
        ]
        client.blockChildrenResponses = [
            .success(.init(results: [blocks[0]], nextCursor: "", hasMore: true)),
            .success(.init(results: [blocks[1]], nextCursor: "", hasMore: true)),
            .success(.init(results: [blocks[2]], nextCursor: "", hasMore: false)),
            .success(.init(results: [blocks[3]], nextCursor: "", hasMore: false)),
        ]

        // Recursively fetch all block children
        let response = try await client.allBlockChildren(blockId: .init(""))

        // Verify the method fetched blocks until the hasMore flag was false
        XCTAssertEqual(response.count, 3)
        let expectedBlockIds = blocks.map { $0.id }.prefix(3)
        XCTAssertEqual(response.map { $0.id }, Array(expectedBlockIds))
    }
}
