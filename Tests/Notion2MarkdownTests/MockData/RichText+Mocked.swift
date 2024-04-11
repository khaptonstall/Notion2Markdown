// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension RichText {
    static func mocked(
        string: String = "",
        annotations: Annotations = .init()
    ) -> Self {
        .init(string: string, annotations: annotations)
    }
}
