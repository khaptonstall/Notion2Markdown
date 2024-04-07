//
//  Page+Convenience.swift
//  
//
//  Created by Kyle Haptonstall on 4/6/24.
//

import Foundation
import NotionSwift

extension Page {
    var plainTextTitle: String? {
        getTitle()?.compactMap({ $0.plainText }).joined(separator: " ")
    }
}
