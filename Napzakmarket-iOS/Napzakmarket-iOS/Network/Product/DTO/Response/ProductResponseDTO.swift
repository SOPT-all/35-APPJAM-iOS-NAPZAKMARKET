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
    let productRecommendList: [Product]
}

struct PopularSellProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PopularSellProductData
}

struct PopularSellProductData: Codable {
    let productSellList: [Product]
}

struct RecommandedBuyProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: RecommandedBuyProductData
}

struct RecommandedBuyProductData: Codable {
    let productBuyList: [Product]
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

enum ProductType: String, Codable {
    case buy = "BUY"
    case sell = "SELL"
}

struct Product: Codable {
    let productId: Int
    let genreName: String
    let productName: String
    let photo: String
    let price: Int
    let uploadTime: String
    let isInterested: Bool
    let tradeType: ProductType
    let tradeStatus: String
    let isOwnedByCurrentUser: Bool
    let isPriceNegotiable: Bool?
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
