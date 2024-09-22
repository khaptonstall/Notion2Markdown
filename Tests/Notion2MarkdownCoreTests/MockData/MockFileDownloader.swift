// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
@testable import Notion2MarkdownCore

class MockFileDownloader: FileDownloading {
    func download(for request: URLRequest) async throws -> (URL, URLResponse) {
        let url = URL(filePath: "./")
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        return (url, response)
    }
}
