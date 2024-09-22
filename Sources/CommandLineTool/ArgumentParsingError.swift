// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

enum ArgumentParsingError: LocalizedError {
    case invalidStatusFilter

    var errorDescription: String? {
        switch self {
        case .invalidStatusFilter:
            "Ensure your filter matches the format '<name><value>'"
        }
    }
}
