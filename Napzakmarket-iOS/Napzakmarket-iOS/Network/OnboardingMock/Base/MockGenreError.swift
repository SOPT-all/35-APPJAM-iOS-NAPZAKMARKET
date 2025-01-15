//
//  MockGenreError.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/12/25.
//

import Foundation

enum MockGenreError: Error {
    case fileNotFound
    case decodingFailed
    case emptyData
    
    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .decodingFailed:
            return "Decoding failed"
        case .emptyData:
            return "Empty data"
        }
    }
    
}
