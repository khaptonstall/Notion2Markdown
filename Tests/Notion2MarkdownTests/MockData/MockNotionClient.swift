//
//  MockNotionClient.swift
//
//
//  Created by Kyle Haptonstall on 4/11/24.
//

import Foundation
import NotionSwift

class MockNotionClient: NotionClientType {
    // MARK: Blocks

    var blockChildrenResponses: [Result<ListResponse<ReadBlock>, NotionClientError>] = []

    func blockChildren(
        blockId: Block.Identifier,
        params: BaseQueryParams,
        completed: @escaping (Result<ListResponse<ReadBlock>, NotionClientError>) -> Void
    ) {
        guard !blockChildrenResponses.isEmpty else {
            completed(.failure(.unsupportedResponseError))
            return
        }
        completed(blockChildrenResponses.removeFirst())
    }

    func blockDelete(blockId: Block.Identifier, completed: @escaping (Result<ReadBlock, NotionClientError>) -> Void) {}
    func blockAppend(blockId: Block.Identifier, children: [WriteBlock], completed: @escaping (Result<ListResponse<ReadBlock>, NotionClientError>) -> Void) {}
    func blockUpdate(blockId: Block.Identifier, value: UpdateBlock, completed: @escaping (Result<ReadBlock, NotionClientError>) -> Void) {}

    // MARK: Page

    func pageUpdateProperties(pageId: Page.Identifier, request: PageProperiesUpdateRequest, completed: @escaping (Result<Page, NotionClientError>) -> Void) {}
    func pageCreate(request: PageCreateRequest, completed: @escaping (Result<Page, NotionClientError>) -> Void) {}
    func page(pageId: Page.Identifier, completed: @escaping (Result<Page, NotionClientError>) -> Void) {}


    // MARK: Database

    func databaseUpdate(databaseId: Database.Identifier, request: DatabaseUpdateRequest, completed: @escaping (Result<Database, NotionClientError>) -> Void) {}
    func databaseCreate(request: DatabaseCreateRequest, completed: @escaping (Result<Database, NotionClientError>) -> Void) {}
    func databaseQuery(databaseId: Database.Identifier, params: DatabaseQueryParams, completed: @escaping (Result<ListResponse<Page>, NotionClientError>) -> Void) {}
    func database(databaseId: Database.Identifier, completed: @escaping (Result<Database, NotionClientError>) -> Void) {}

    // MARK: Search

    func search(request: SearchRequest, completed: @escaping (Result<SearchResponse, NotionClientError>) -> Void) {}


    // MARK: Users

    func usersMe(completed: @escaping (Result<User, NotionClientError>) -> Void) {}
    func usersList(params: BaseQueryParams, completed: @escaping (Result<ListResponse<User>, NotionClientError>) -> Void) {}
    func user(userId: User.Identifier, completed: @escaping (Result<User, NotionClientError>) -> Void) {}
}
