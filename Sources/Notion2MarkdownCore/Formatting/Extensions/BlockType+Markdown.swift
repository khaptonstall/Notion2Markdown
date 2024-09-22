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
        case .image(let fileBlockValue):
            let altText = fileBlockValue.asMarkdown

            switch fileBlockValue.file {
            case let .external(urlString):
                return altText.convertedToMarkdown(.image(url: urlString))
            case let .file(urlString, _):
                // urlString should be a signed S3 URL, where the lastPathComponent will be the file name
                // e.g. https://prod-files-secure.s3.us-west-2.amazonaws.com/<uuid>/<uuid>/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&....
                guard let url = URL(string: urlString) else { return nil }
                return altText.convertedToMarkdown(.image(url: url.lastPathComponent))
            case .unknown:
                return nil
            }
        case .audio,
             .breadcrumb,
             .childDatabase,
             .childPage,
             .file,
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
