//
//  GenreNameResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct GenreNameResponseDTO: Codable {
    let status: Int
    let message: String
    let data: GenreNameData
}

struct GenreNameData: Codable {
    let genreList: [GenreName]
    let nextCursor: String?
}

struct GenreName: Identifiable, Codable, Hashable {
    let id: Int
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case genreName
    }
}
