//
//  RichText+Markdown.swift
//
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation
import NotionSwift

extension RichText {
    var asMarkdown: String {
        switch type {
        case .text(let value):
            let content = value.content.asMarkdown(annotations: annotations)
            if let url = value.link?.url {
                return content.convertedToMarkdown(.link(url: url))
            } else {
                return content
            }
        case .equation(let value):
            return value.expression
        case .mention(let value):
            switch value.type {
            case .user(let user):
                return user.name ?? ""
            case .page(let pageMentionValue):
                return pageMentionValue.id.description
            case .database(let databaseMentionValue):
                return databaseMentionValue.id.description
            case .date(let dateRange):
                return [
                    dateRange.start.dateString,
                    dateRange.end?.dateString,
                ]
                    .compactMap({ $0 })
                    .joined(separator: "...")
            case .unknown:
                return ""
            }
        case .unknown:
            return ""
        }
    }
}

// MARK: - String + Markdown Annotations

private extension String {
    func asMarkdown(annotations: RichText.Annotations) -> String {
        var str = self
        if annotations.bold {
            str = str.convertedToMarkdown(.bold)
        }
        if annotations.italic {
            str = str.convertedToMarkdown(.italic)
        }
        if annotations.strikethrough {
            str = str.convertedToMarkdown(.strikeThrough)
        }
        if annotations.code {
            str = str.convertedToMarkdown(.code)
        }
        return str
    }
}
