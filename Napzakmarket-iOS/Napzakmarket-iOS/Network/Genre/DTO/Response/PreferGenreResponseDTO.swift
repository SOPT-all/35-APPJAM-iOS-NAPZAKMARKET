//
//  PreferGenreResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct PreferGenreResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PreferGenreData
}

struct PreferGenreData: Codable {
    let genreList: [PreferGenre]
    var nextCursor: String?
}

struct PreferGenre: Codable {
    let genreId: Int
    let genreName: String
    let genrePhoto: String
}
