// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension PartialUser {
    static func mocked(id: UUIDv4 = "") -> Self {
        .init(id: .init(id))
    }
}
