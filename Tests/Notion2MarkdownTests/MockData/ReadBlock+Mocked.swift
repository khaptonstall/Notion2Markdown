//
//  ReadBlock+Mocked.swift
//
//
//  Created by Kyle Haptonstall on 4/10/24.
//

import Foundation
import NotionSwift

extension ReadBlock {
    static func mocked(
        id: UUIDv4 = "",
        archived: Bool = false,
        type: BlockType,
        createdTime: Date = .now,
        lastEditedTime: Date = .now,
        hasChildren: Bool = false,
        createdBy: PartialUser = .mocked(),
        lastEditedBy: PartialUser = .mocked()
    ) -> Self {
        .init(
            id: .init(id),
            archived: archived,
            type: type,
            createdTime: createdTime,
            lastEditedTime: lastEditedTime,
            hasChildren: hasChildren,
            createdBy: createdBy,
            lastEditedBy: lastEditedBy
        )
    }
}


