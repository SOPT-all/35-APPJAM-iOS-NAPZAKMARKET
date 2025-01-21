//
//  BannerResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct BannerResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PreferGenreData
}

struct BannerData: Codable {
    let bannerList: [Banner]
}

struct Banner: Codable {
    let bannerId: Int
    let bannerPhoto: String
    let bannerUrl: String
    let bannerSequence: Int
}
