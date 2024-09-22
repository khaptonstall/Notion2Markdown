// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

/// A type which can convert an input string to a specific Markdown element.
struct MarkdownConverter {
    private let converter: (String) -> String

    init(_ converter: @escaping (String) -> String) {
        self.converter = converter
    }

    func convert(_ input: String) -> String {
        converter(input)
    }
}

// MARK: - Default Markdown Converters

extension MarkdownConverter {
    static let bold: Self = .init { "**\($0)**" }
    static let italic: Self = .init { "*\($0)*" }
    static let strikeThrough: Self = .init { "~~\($0)~~" }

    static let heading1: Self = .init { "# \($0)" }
    static let heading2: Self = .init { "## \($0)" }
    static let heading3: Self = .init { "### \($0)" }

    static let code: Self = .init { "`\($0)`" }
    static func codeBlock(language: String?) -> Self {
        .init { input in
            """
            ```\(language ?? "")
            \(input)
            ```
            """
        }
    }

    static let quote: Self = .init { "> \($0)" }
    static let bulletedListItem: Self = .init { "- \($0)" }

    static func numberedListItem(number: Int = 1) -> Self {
        .init { "\(number). \($0)" }
    }

    static func todo(checked: Bool) -> Self {
        .init { input in
            if checked == true {
                "- [x] \(input)"
            } else {
                "- [ ] \(input)"
            }
        }
    }

    static func link(url: String) -> Self {
        .init { "[\($0)](\(url))" }
    }
}

// MARK: - String + MarkdownConverter

extension String {
    func convertedToMarkdown(_ converter: MarkdownConverter) -> String {
        converter.convert(self)
    }
}
