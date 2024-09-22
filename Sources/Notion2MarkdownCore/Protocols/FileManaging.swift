// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

/// Used to abstract file management.
protocol FileManaging {
    func write(
        _ string: String,
        to url: URL,
        atomically useAuxiliaryFile: Bool,
        encoding enc: String.Encoding
    ) throws

    func moveItem(at srcURL: URL, to dstURL: URL) throws
}

// MARK: FileManager + FileManaging

extension FileManager: FileManaging {
    func write(
        _ string: String,
        to url: URL,
        atomically useAuxiliaryFile: Bool,
        encoding enc: String.Encoding
    ) throws {
        try string.write(to: url, atomically: useAuxiliaryFile, encoding: enc)
    }
}
