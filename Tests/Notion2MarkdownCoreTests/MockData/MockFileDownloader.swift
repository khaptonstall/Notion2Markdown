//
//  File.swift
//  Notion2Markdown
//
//  Created by Kyle Haptonstall on 9/21/24.
//

import Foundation
@testable import Notion2MarkdownCore

class MockFileDownloader: FileDownloading {
    func download(for request: URLRequest) async throws -> (URL, URLResponse) {
        let url = URL(filePath: "./")
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        return (url, response)
    }
}
