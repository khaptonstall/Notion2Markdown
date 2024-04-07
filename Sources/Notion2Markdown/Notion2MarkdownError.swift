//
//  Notion2MarkdownError.swift
//  
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation

enum Notion2MarkdownError: Error {
    case missingNotionToken

    case missingDatabaseID

    case missingOutputDirectory

    /// Occurs when providing invalid input (e.g. anything but an integer) when prompted to select a page to publish
    case invalidPageSelectionInput
    
    /// Occurs when providing an invalid index when prompted to select a page to publish
    case invalidPageSelectionIndex

    case pageMissingTitle
}

extension Notion2MarkdownError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingNotionToken:
            "Please provide a valid Notion integration token"
        case .missingDatabaseID:
            "Please provide a valid Notion database id"
        case .missingOutputDirectory:
            "Please provide a valid output directory to save the markdown file"
        case .invalidPageSelectionInput:
            "Please enter a valid integer index."
        case .invalidPageSelectionIndex:
            "Please choose a valid page index."
        case .pageMissingTitle:
            "Unable to find or parse the title for the page"
        }
    }
}
