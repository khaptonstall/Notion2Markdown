// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
@testable import Notion2MarkdownCore
import NotionSwift
import XCTest

final class Notion2MarkdownClientTests: XCTestCase {
    func testMarkdownConversion_numberedLists_startsNewListAfterAlternateBlockType() async throws {
        try await assertConversionOfBlocks(
            MockData.numberedListBlocks,
            matchesMarkdown: MockData.numberedListMarkdown
        )
    }

    func testMarkdownConversion_bulletedListItem() async throws {
        try await assertConversionOfBlocks(
            MockData.bulletedListItemBlocks,
            matchesMarkdown: MockData.bulletedListItemMarkdown
        )
    }

    func testMarkdownConversion_callouts() async throws {
        try await assertConversionOfBlocks(
            MockData.calloutBlocks,
            matchesMarkdown: MockData.calloutMarkdown
        )
    }

    func testMarkdownConversion_code() async throws {
        try await assertConversionOfBlocks(
            MockData.codeBlocks,
            matchesMarkdown: MockData.codeMarkdown
        )
    }

    func testMarkdownConversion_embed() async throws {
        try await assertConversionOfBlocks(
            MockData.embedBlocks,
            matchesMarkdown: MockData.embedMarkdown
        )
    }

    func testMarkdownConversion_headings() async throws {
        try await assertConversionOfBlocks(
            MockData.headingBlocks,
            matchesMarkdown: MockData.headingMarkdown
        )
    }

    func testMarkdownConversion_quotes() async throws {
        try await assertConversionOfBlocks(
            MockData.quoteBlocks,
            matchesMarkdown: MockData.quoteMarkdown
        )
    }

    func testMarkdownConversion_todos() async throws {
        try await assertConversionOfBlocks(
            MockData.todoBlocks,
            matchesMarkdown: MockData.todoMarkdown
        )
    }

    func testErrors_pageMissingTitle() async throws {
        let mockNotionClient = MockNotionClient()
        let client = Notion2MarkdownClient(internalClient: mockNotionClient)

        do {
            _ = try await client.convertPageToMarkdown(.mocked())
            XCTFail("Expected error thrown due to page missing a title")
        } catch let error as Notion2MarkdownError {
            XCTAssertEqual(error, .pageMissingTitle)
        } catch {
            XCTFail("Expected to receive Notion2MarkdownError.pageMissingTitle but got \(error)")
        }
    }
}

// MARK: - Utilities

private extension Notion2MarkdownClientTests {
    func assertConversionOfBlocks(
        _ blocks: [ReadBlock],
        matchesMarkdown expectedMarkdown: String
    ) async throws {
        let mockNotionClient = MockNotionClient()
        let client = Notion2MarkdownClient(internalClient: mockNotionClient)

        mockNotionClient.blockChildrenResponses = [.success(.init(results: blocks, nextCursor: nil, hasMore: false))]

        let actualMarkdown = try await client.convertPageToMarkdown(.titledPage(MockData.pageTitle))
        XCTAssertEqual(actualMarkdown, expectedMarkdown)
    }
}