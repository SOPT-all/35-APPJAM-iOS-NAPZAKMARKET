//
//  ChatInfoResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct ChatInfoResponseDTO: Codable {
    let status: Int
    let message: String
    let data: ChatInfoData
}

struct ChatInfoData: Codable {
    let nickname: String
    let firstPhoto: String
    let tradeType: ProductType
    let title: String
    let price: Int
    let isPriceNegotiable: Bool
}
