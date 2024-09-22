// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension [ReadBlock] {
    /// Enumerates all blocks and returns each url representing a private (i.e. non-external) image file.
    var imageURLs: [URL] {
        compactMap { block in
            switch block.type {
            case let .image(value):
                switch value.file {
                case let .file(urlString, _):
                    URL(string: urlString)
                default:
                    nil
                }
            default:
                nil
            }
        }
    }
}
