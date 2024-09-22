// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension BlockType {
    /// Attempts converting the block to its markdown equivalent.
    var asMarkdown: String? {
        switch self {
        case let .bookmark(value):
            return value.asMarkdown
        case let .bulletedListItem(textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown
                .convertedToMarkdown(.bulletedListItem)
        case let .callout(calloutBlockValue):
            return calloutBlockValue.asMarkdown
                .convertedToMarkdown(.quote)
        case let .code(codeBlockValue):
            return codeBlockValue.asMarkdown
                .convertedToMarkdown(.codeBlock(language: codeBlockValue.language))
        case .divider:
            return "___"
        case let .embed(value):
            return value.asMarkdown.convertedToMarkdown(.link(url: value.url))
        case let .equation(value):
            return value.expression
        case let .heading1(headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading1)
        case let .heading2(headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading2)
        case let .heading3(headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading3)
        case let .numberedListItem(textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown.convertedToMarkdown(.numberedListItem())
        case let .paragraph(textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown
        case let .quote(quoteBlockValue):
            return quoteBlockValue.asMarkdown.convertedToMarkdown(.quote)
        case let .toDo(toDoBlockValue):
            return toDoBlockValue.asMarkdown
                .convertedToMarkdown(.todo(checked: toDoBlockValue.checked ?? false))
        case .column, .columnList:
            // ColumnList and Column aren't converted directly to markdown,
            // however the Column children will be converted (given the child BlockType is supported).
            return nil
        case .audio,
             .breadcrumb,
             .childDatabase,
             .childPage,
             .file,
             .image,
             .linkToPage,
             .pdf,
             .syncedBlock,
             .table,
             .tableOfContents,
             .tableRow,
             .template,
             .toggle,
             .unsupported,
             .video:
            print("⚠️ Skipping unsupported block type \(String(describing: self))")
            return nil
        }
    }
}

extension BlockType.FileBlockValue {
    /// Downloads the associated image file and produces a markdown string using a relative link to the downloaded image.
    /// - Parameter parentDirectory: The directory that will be the parent to the images subdirectory.
    func asMarkdownImage(parentDirectory: String) async throws -> String {
        switch self.file {
        case let .external(urlString),
            let .file(urlString, _):
            guard let url = URL(string: urlString), !url.pathExtension.isEmpty else {
                throw Notion2MarkdownError.invalidFileURL
            }

            let (downloadURL, _) = try await URLSession.shared.download(for: URLRequest(url: url))

            let outputURL = URL(fileURLWithPath: parentDirectory).appending(path: "images")
            try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

            let fileName = "\(UUID().uuidString).\(url.pathExtension)"
            try FileManager.default.moveItem(
                at: downloadURL,
                to: outputURL.appending(path: fileName)
            )

            return "![](images/\(fileName))"
        case .unknown:
            return ""
        }
    }
}
