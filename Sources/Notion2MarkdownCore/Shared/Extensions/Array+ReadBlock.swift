//
//  File.swift
//  Notion2Markdown
//
//  Created by Kyle Haptonstall on 9/21/24.
//

import Foundation
import NotionSwift

extension Array where Element == ReadBlock {
    /// Enumerates all blocks and returns each url representing a private (i.e. non-external) image file.
    var imageURLs: [URL] {
        compactMap { block in
            switch block.type {
            case .image(let value):
                switch value.file {
                case let .file(urlString, _):
                    return URL(string: urlString)
                default:
                    return nil
                }
            default:
                return nil
            }
        }
    }
}
