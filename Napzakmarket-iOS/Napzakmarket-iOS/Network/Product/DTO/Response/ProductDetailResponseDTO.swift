//
//  ProductDetailResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

enum ProductStatus: String, Codable {
    case beforeTrade = "BEFORE_TRADE"
    case reserved = "RESERVED"
    case completed = "COMPLETED"
}

enum ProductCondition: String, Codable {
    case new = "NEW"
    case likeNew = "LIKE_NEW"
    case slightlyUsed = "SLIGHTLY_USED"
    case used = "USED"
}

struct ProductDetailResponseDTO: Codable {
    let status: Int
    let message: String
    let data: ProductDetailData
}

struct ProductDetailData: Codable {
    var isInterested: Bool
    let productDetail: ProductDetail
    let productPhotoList: [ProductPhoto]
    let storeInfo: Store
    let storeReviewList: [Review]
}

struct ProductDetail: Codable {
    let productId: Int
    let tradeType: ProductType
    let genreName: String
    let productName: String
    let price: Int
    let uploadTime: String
    let viewCount: Int
    let interestCount: Int
    let description: String
    let productCondition: ProductCondition?
    let isDeliveryIncluded: Bool
    let standardDeliveryFee: Int
    let halfDeliveryFee: Int
    let isPriceNegotiable: Bool
    let tradeStatus: String
    let isOwnedByCurrentUser: Bool
}

struct ProductPhoto: Codable, Hashable, Identifiable {
    let id: Int
    let photoUrl: String
    let photoSequence: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "photoId"
        case photoUrl
        case photoSequence
    }
}

struct Store: Codable {
    let userId: Int
    let storePhoto: String
    let nickname: String
    let totalProducts: Int
    let totalTransactions: Int
}

struct Review: Codable {
    let reviewId: Int
    let reviewerNickname: String
    let rating: Double
    let comment: String
    let relatedProductId: Int
    let relatedProductName: String
}
