// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

public extension Page {
    var plainTextTitle: String? {
        getTitle()?.compactMap { $0.plainText }.joined(separator: " ")
    }
}
