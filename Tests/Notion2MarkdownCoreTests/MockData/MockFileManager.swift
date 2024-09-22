// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
@testable import Notion2MarkdownCore
import XCTest

class MockFileManager: FileManaging {
    /// An expectation fulfilled when `write(_:to:atomically:encoding:)` is invoked.
    var writeExpectation: XCTestExpectation?

    /// The latest input string sent through the `write(_:to:atomically:encoding:)` method.
    var writeInput: String?

    func write(
        _ string: String,
        to url: URL,
        atomically useAuxiliaryFile: Bool,
        encoding enc: String.Encoding
    ) throws {
        writeInput = string
        writeExpectation?.fulfill()
    }

    func moveItem(at srcURL: URL, to dstURL: URL) throws {}
}
