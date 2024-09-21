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

    func testBlockChildrenRecursivelyFetchesNestedChildren() async throws {
        let client = MockNotionClient()

        // Setup a set of blocks that would match the following markdown:
        /*
         - Parent bullet 1
            - Child bullet 1
            - Child bullet 2
         - Parent bullet 2
         */
        let parentBullet1: ReadBlock = .mocked(id: "1", type: .bulletedListItem([.mocked(string: "Parent bullet 1")]), hasChildren: true)
        let parentBullet2: ReadBlock = .mocked(id: "2", type: .bulletedListItem([.mocked(string: "Parent bullet 2")]), hasChildren: false)
        let childBullet1: ReadBlock = .mocked(id: "3", type: .bulletedListItem([.mocked(string: "Child bullet 1")]), hasChildren: true)
        let childBullet2: ReadBlock = .mocked(id: "4", type: .bulletedListItem([.mocked(string: "Child bullet 2")]), hasChildren: false)

        // Setup 3 mock responses:
        // The first will fetch all the top-level blocks
        // The second will fetch the next level of children for parentBullet1
        // The third will fetch the next level of children for childBullet1
        client.blockChildrenResponses = [
            .success(.init(results: [parentBullet1, parentBullet2], nextCursor: nil, hasMore: false)),
            .success(.init(results: [childBullet1], nextCursor: nil, hasMore: false)),
            .success(.init(results: [childBullet2], nextCursor: nil, hasMore: false)),
        ]

        // Recursively fetch all block children
        let response = try await client.allBlockChildren(blockId: .init(""))

        // Verify the final order of blocks
        let actualOrder = response.map { $0.id.rawValue }
        let expectedOrder = [parentBullet1, childBullet1, childBullet2, parentBullet2].map { $0.id.rawValue }
        XCTAssertEqual(actualOrder, expectedOrder)
    }
}
