//
//  Genre.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/11/25.
//

import Foundation

struct Genre: Identifiable, Hashable, Decodable {
    
    let id: Int
    let name: String
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "genreId"
        case name = "genreName"
        case image = "genrePhoto"
    }
    
}

struct GenreResponse: Decodable {
    
    let genres: [Genre]
    let nextCursor: Int?
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genreList"
        case nextCursor
    }
    
}
