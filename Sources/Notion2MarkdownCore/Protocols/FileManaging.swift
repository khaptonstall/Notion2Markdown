//
//  File.swift
//  Notion2Markdown
//
//  Created by Kyle Haptonstall on 9/21/24.
//

import Foundation

/// Used to abstract file management.
protocol FileManaging {
    func write(_ string: String,
               to url: URL,
               atomically useAuxiliaryFile: Bool,
               encoding enc: String.Encoding) throws

    func moveItem(at srcURL: URL, to dstURL: URL) throws
}

// MARK: FileManager + FileManaging

extension FileManager: FileManaging {
    func write(_ string: String,
               to url: URL,
               atomically useAuxiliaryFile: Bool,
               encoding enc: String.Encoding) throws {
        try string.write(to: url, atomically: useAuxiliaryFile, encoding: enc)
    }
}
