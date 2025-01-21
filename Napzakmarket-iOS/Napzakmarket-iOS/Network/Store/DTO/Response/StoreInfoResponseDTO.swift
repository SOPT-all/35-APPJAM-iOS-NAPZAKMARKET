//
//  StoreInfoResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct StoreInfoResponseDTO: Codable {
    let status: Int
    let message: String
    let data: StoreInfoData
}

struct StoreInfoData: Codable {
    let storeId: Int
    let storeNickName: String
    let description: String
    let storePhoto: String
    let storeCover: String
    let genrePreferenceList: [GenreName]
}
