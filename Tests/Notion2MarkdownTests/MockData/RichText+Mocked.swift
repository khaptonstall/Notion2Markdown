//
//  RichText+Mocked.swift
//  
//
//  Created by Kyle Haptonstall on 4/10/24.
//

import Foundation
import NotionSwift

extension RichText {
    static func mocked(
        string: String = "",
        annotations: Annotations = .init()
    ) -> Self {
        .init(string: string, annotations: annotations)
    }
}
