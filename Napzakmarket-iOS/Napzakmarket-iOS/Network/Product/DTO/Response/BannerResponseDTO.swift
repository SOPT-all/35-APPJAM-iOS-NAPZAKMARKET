//
//  BannerResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct BannerResponseDTO: Decodable {
    let status: Int
    let message: String
    let data: BannerData
}

struct BannerData: Decodable {
    let bannerList: [Banner]
}

struct Banner: Decodable {
    let bannerId: Int
    let bannerPhoto: String
    let bannerUrl: String?
    let bannerSequence: Int
}
