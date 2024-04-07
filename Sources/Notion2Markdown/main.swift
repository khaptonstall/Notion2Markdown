//
//  main.swift
//  
//
//  Created by Kyle Haptonstall on 4/5/24.
//

import Foundation

do {
    guard let notionToken = ProcessInfo.processInfo.environment["NOTION_TOKEN"] else {
        throw Notion2MarkdownError.missingNotionToken
    }

    guard let databaseID = ProcessInfo.processInfo.environment["DATABASE_ID"] else {
        throw Notion2MarkdownError.missingDatabaseID
    }

    guard let outputDirectory = ProcessInfo.processInfo.environment["OUTPUT_DIRECTORY"],
          let outputDirectoryURL = URL(string: outputDirectory) else {
        throw Notion2MarkdownError.missingOutputDirectory
    }

    try await Notion2Markdown(notionToken: notionToken)
        .run(
            databaseID: databaseID,
            outputDirectory: outputDirectoryURL
        )
} catch {
    print(error.localizedDescription)
}

