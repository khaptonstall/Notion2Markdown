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

extension RichText.Annotations {
    static let bold: Self = .init(bold: true)
    static let italic: Self = .init(italic: true)
    static let strikethrough: Self = .init(strikethrough: true)
    static let underline: Self = .init(underline: true)
    static let code: Self = .init(code: true)
}
