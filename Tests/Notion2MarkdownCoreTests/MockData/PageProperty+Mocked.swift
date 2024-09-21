// Copyright © 2024 Kyle Haptonstall. All rights reserved.

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
