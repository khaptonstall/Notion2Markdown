//
//  RichTextContainer.swift
//
//
//  Created by Kyle Haptonstall on 4/6/24.
//

import Foundation
import NotionSwift

/// Describes a type which supports `RichText`.
protocol RichTextContainer {
    var richText: [RichText] { get }
}

// MARK: Default Properties

extension RichTextContainer {
    /// Converts the `richText` array into a single markdown string with all styling applied.
    var asMarkdown: String {
        richText.map({ $0.asMarkdown }).joined()
    }
}

// MARK: Default Conformances

extension BlockType.CalloutBlockValue: RichTextContainer {}
extension BlockType.CodeBlockValue: RichTextContainer {}
extension BlockType.HeadingBlockValue: RichTextContainer {}
extension BlockType.QuoteBlockValue: RichTextContainer {}
extension BlockType.TextAndChildrenBlockValue: RichTextContainer {}
extension BlockType.ToDoBlockValue: RichTextContainer {}

extension BlockType.EmbedBlockValue: RichTextContainer {
    var richText: [RichText] { caption }
}

extension BlockType.FileBlockValue: RichTextContainer {
    var richText: [RichText] { caption }
}

extension BlockType.BookmarkBlockValue: RichTextContainer {
    var richText: [RichText] { caption }
}
