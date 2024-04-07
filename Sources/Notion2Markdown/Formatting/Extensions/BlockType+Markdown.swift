//
//  BlockType+Markdown.swift
//
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation
import NotionSwift

extension BlockType {
    /// Attempts converting the **top-level** block to its markdown equivalent.
    var asMarkdown: String {
        switch self {
        case .bookmark(let value):
            return value.asMarkdown
        case .bulletedListItem(let textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown
                .convertedToMarkdown(.bulletedListItem)
        case .callout(let calloutBlockValue):
            return calloutBlockValue.asMarkdown
                .convertedToMarkdown(.quote)
        case .code(let codeBlockValue):
            return codeBlockValue.asMarkdown
                .convertedToMarkdown(.codeBlock(language: codeBlockValue.language))
        case .divider:
            return "___"
        case .embed(let value):
            return value.asMarkdown.convertedToMarkdown(.link(url: value.url))
        case .equation(let value):
            return value.expression
        case .heading1(let headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading1)
        case .heading2(let headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading2)
        case .heading3(let headingBlockValue):
            return headingBlockValue.asMarkdown.convertedToMarkdown(.heading3)
        case .numberedListItem(let textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown
        case .paragraph(let textAndChildrenBlockValue):
            return textAndChildrenBlockValue.asMarkdown
        case .quote(let quoteBlockValue):
            return quoteBlockValue.asMarkdown.convertedToMarkdown(.quote)
        case .toDo(let toDoBlockValue):
            return toDoBlockValue.asMarkdown
                .convertedToMarkdown(.todo(checked: toDoBlockValue.checked ?? false))
        case .audio,
                .breadcrumb,
                .childDatabase,
                .childPage,
                .column,
                .columnList,
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
            return ""
        }
    }
}
