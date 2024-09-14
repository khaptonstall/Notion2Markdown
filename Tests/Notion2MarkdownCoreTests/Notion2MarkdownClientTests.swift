//
//  File.swift
//  
//
//  Created by Kyle Haptonstall on 9/14/24.
//

import Foundation
@testable import Notion2Markdown
import XCTest

final class Notion2MarkdownClientTests: XCTestCase {
    func testNumberedListMarkdownConversion() async throws {
//        let mockNotionClient = MockNotionClient()
//        let client = Notion2MarkdownClient(internalClient: mockNotionClient)
//
//        mockNotionClient.blockChildrenResponses = [.success(.init(results: MockData.numberedListBlocks, nextCursor: nil, hasMore: false))]
//
//        let markdown = try await client.convertPageToMarkdown(.mocked())
//        print(markdown)
//        XCTAssertEqual(markdown, MockData.numberedListMarkdown)
    }
}

//enum MockData {
//    static let numberedListBlocks: [ReadBlock] = [
//        .mocked(type: .numberedListItem([.mocked(string: "Item 1")])),
//        .mocked(type: .numberedListItem([.mocked(string: "Item 2")])),
//        .mocked(type: .paragraph([.mocked(string: "Paragraph")])),
//        .mocked(type: .numberedListItem([.mocked(string: "Item 1")])),
//        .mocked(type: .numberedListItem([.mocked(string: "Item 2")])),
//    ]
//    static let numberedListMarkdown = """
//"""
//}

import NotionSwift

//extension Page {
//    static func mocked(
//        id: String = UUID().uuidString,
//        createdTime: Date = .now,
//        lastEditedTime: Date = .now,
//        createdBy: PartialUser = .mocked(),
//        lastEditedBy: PartialUser = .mocked(),
//        icon: IconFile? = nil,
//        cover: CoverFile? = nil,
//        parent: PageParentType = .unknown(typeName: ""),
//        archived: Bool = false,
//        properties: [PropertyName: PageProperty] = [:],
//        url: URL = .init(string: "https://www.notion.so/")!
//    ) -> Page {
//        self.init(
//            id: .init(id),
//            createdTime: createdTime,
//            lastEditedTime: lastEditedTime,
//            createdBy: createdBy,
//            lastEditedBy: lastEditedBy,
//            icon: icon,
//            cover: cover,
//            parent: parent,
//            archived: archived,
//            properties: properties,
//            url: url
//        )
//    }
//}
