//
//  DateValue+String.swift
//  
//
//  Created by Kyle Haptonstall on 4/6/24.
//

import Foundation
import NotionSwift

extension DateValue {
    var dateString: String {
        switch self {
        case .dateOnly(let date):
            return DateFormatter.iso8601DateOnly.string(from: date)
        case .dateAndTime(let date):
            return DateFormatter.iso8601Full.string(from: date)
        }
    }
}
