//
//  PartialUser+Mocked.swift
//  
//
//  Created by Kyle Haptonstall on 4/10/24.
//

import Foundation
import NotionSwift

extension PartialUser {

    static func mocked(id: UUIDv4 = "") -> Self {
        .init(id: .init(id))
    }

}
