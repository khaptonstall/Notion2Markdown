// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

/// Used to abstract downloading remote files.
protocol FileDownloading {
    func download(for request: URLRequest) async throws -> (URL, URLResponse)
}

// MARK: - URLSession + FileDownloading

extension URLSession: FileDownloading {
    func download(for request: URLRequest) async throws -> (URL, URLResponse) {
        try await download(for: request, delegate: nil)
    }
}
