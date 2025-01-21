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
    let data: PreferGenreData
}

struct GenreNameData: Codable {
    let genreList: [GenreName]
    let nextCursor: String
}

struct GenreName: Codable {
    let genreId: Int
    let genreName: String
}
