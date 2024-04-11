// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension RichText {
    var asMarkdown: String {
        switch type {
        case let .text(value):
            let content = value.content.asMarkdown(annotations: annotations)
            if let url = value.link?.url {
                return content.convertedToMarkdown(.link(url: url))
            } else {
                return content
            }
        case let .equation(value):
            return value.expression
        case let .mention(value):
            switch value.type {
            case let .user(user):
                return user.name ?? ""
            case let .page(pageMentionValue):
                return pageMentionValue.id.description
            case let .database(databaseMentionValue):
                return databaseMentionValue.id.description
            case let .date(dateRange):
                return [
                    dateRange.start.dateString,
                    dateRange.end?.dateString,
                ]
                .compactMap { $0 }
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
