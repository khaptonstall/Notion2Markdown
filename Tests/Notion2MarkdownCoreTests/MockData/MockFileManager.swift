//
//  File.swift
//  Notion2Markdown
//
//  Created by Kyle Haptonstall on 9/21/24.
//

import Foundation
@testable import Notion2MarkdownCore

class MockFileManager: FileManaging {
    func write(
        _ string: String,
        to url: URL,
        atomically useAuxiliaryFile: Bool,
        encoding enc: String.Encoding
    ) throws {}
    
    func moveItem(at srcURL: URL, to dstURL: URL) throws {}
}
