//
//  PreferGenreResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct PreferGenreResponseDTO: Decodable {
    let status: Int
    let message: String
    let data: PreferGenreData
}

struct PreferGenreData: Decodable {
    let genreList: [PreferGenre]
    var nextCursor: String?
}

struct PreferGenre: Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case name = "genreName"
        case image = "genrePhoto"
    }
}
