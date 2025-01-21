//
//  ProductResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct PersonalProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PersonalProductData
}

struct PersonalProductData: Codable {
    let productBuyList: [BuyProduct]
    let productSellList: [SellProduct]
}

struct PopularSellProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PopularSellProductData
}

struct PopularSellProductData: Codable {
    let productSellList: [SellProduct]
}

struct RecommandedBuyProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: RecommandedBuyProductData
}

struct RecommandedBuyProductData: Codable {
    let productBuyList: [BuyProduct]
}

struct SellProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PopularSellProductData
}

struct SellProductData: Codable {
    let productSellList: [SellProduct]
    var nextCursor: String?
}

struct BuyProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: BuyProductData
}

struct BuyProductData: Codable {
    let productBuyList: [BuyProduct]
    var nextCursor: String?
}

struct BuyProduct: Codable {
    let productId: Int
    let genreName: String
    let productName: String
    let photo: String
    let price: Int
    let uploadTime: String
    let isInterested: Bool
    let tradeType: String
    let tradeStatus: String
    let isPriceNegotiable: Bool
    let isOwnedByCurrentUser: Bool
}

struct SellProduct: Codable {
    let productId: Int
    let genreName: String
    let productName: String
    let photo: String
    let price: Int
    let uploadTime: String
    let isInterested: Bool
    let tradeType: String
    let tradeStatus: String
    let isOwnedByCurrentUser: Bool
}
