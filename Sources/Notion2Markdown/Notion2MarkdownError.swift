//
//  Notion2MarkdownError.swift
//  
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation

enum Notion2MarkdownError: Error {
    /// Occurs when providing invalid input (e.g. anything but an integer) when prompted to select a page to publish
    case invalidPageSelectionInput
    
    /// Occurs when providing an invalid index when prompted to select a page to publish
    case invalidPageSelectionIndex

    case pageMissingTitle
}

extension Notion2MarkdownError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidPageSelectionInput:
            "Please enter a valid integer index."
        case .invalidPageSelectionIndex:
            "Please choose a valid page index."
        case .pageMissingTitle:
            "Unable to find or parse the title for the page"
        }
    }
}
