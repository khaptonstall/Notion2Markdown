// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

extension DateValue {
    var dateString: String {
        switch self {
        case let .dateOnly(date):
            return DateFormatter.iso8601DateOnly.string(from: date)
        case let .dateAndTime(date):
            return DateFormatter.iso8601Full.string(from: date)
        }
    }
}
