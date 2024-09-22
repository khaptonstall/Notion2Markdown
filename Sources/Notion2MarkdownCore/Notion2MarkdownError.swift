// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

public enum Notion2MarkdownError: LocalizedError {
    /// Occurs when providing invalid input (e.g. anything but an integer) when prompted to select a page to publish
    case invalidPageSelectionInput

    /// Occurs when providing an invalid index when prompted to select a page to publish
    case invalidPageSelectionIndex

    case pageMissingTitle

    /// Occurs when a Notion file is invalid, such as when it cannot be converted to a `URL` type or if its missing a file extension.
    case invalidFileURL

    public var errorDescription: String? {
        switch self {
        case .invalidPageSelectionInput:
            "Please enter a valid integer index."
        case .invalidPageSelectionIndex:
            "Please choose a valid page index."
        case .pageMissingTitle:
            "Unable to find or parse the title for the page"
        case .invalidFileURL:
            "The file url is invalid or missing a file extension"
        }
    }
}
