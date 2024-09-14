//
//  File.swift
//  
//
//  Created by Kyle Haptonstall on 9/14/24.
//

import Foundation
import NotionSwift

extension Page {
    static func mocked(
        id: String = UUID().uuidString,
        createdTime: Date = .now,
        lastEditedTime: Date = .now,
        createdBy: PartialUser = .mocked(),
        lastEditedBy: PartialUser = .mocked(),
        icon: IconFile? = nil,
        cover: CoverFile? = nil,
        parent: PageParentType = .unknown(typeName: ""),
        archived: Bool = false,
        properties: [PropertyName: PageProperty] = [:],
        url: URL = .init(string: "https://www.notion.so/")!
    ) -> Page {
        self.init(
            id: .init(id),
            createdTime: createdTime,
            lastEditedTime: lastEditedTime,
            createdBy: createdBy,
            lastEditedBy: lastEditedBy,
            icon: icon,
            cover: cover,
            parent: parent,
            archived: archived,
            properties: properties,
            url: url
        )
    }

    static func titledPage(_ title: String) -> Page {
        self.mocked(
            properties: [
                "Title": .mocked(
                    type: .title([.init(plainText: title, type: .text(.init(content: title)))])
                )]
        )
    }
}

