//
//  RegisterPreferGenreResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct RegisterPreferGenreResponseDTO: Codable {
    let status: Int
    let message: String
    let data: RegisteredPreferGenreData
}

struct RegisteredPreferGenreData: Codable {
    let genreList: [GenreName]
    var nextCursor: String?
}
