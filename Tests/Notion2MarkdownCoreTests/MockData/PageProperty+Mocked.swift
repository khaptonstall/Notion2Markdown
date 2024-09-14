//
//  File.swift
//  
//
//  Created by Kyle Haptonstall on 9/14/24.
//

import Foundation
import NotionSwift

extension PageProperty {
    static func mocked(
        id: String = UUID().uuidString,
        type: PagePropertyType
    ) -> PageProperty {
        .init(id: .init(id), type: type)
    }
}
