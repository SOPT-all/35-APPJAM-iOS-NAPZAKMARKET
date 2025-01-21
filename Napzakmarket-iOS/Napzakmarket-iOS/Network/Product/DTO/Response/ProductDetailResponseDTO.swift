//
//  ProductDetailResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct ProductDetailResponseDTO: Codable {
    let status: Int
    let message: String
    let data: PersonalProductData
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
    let tradeType: String
    let genreName: String
    let productName: String
    let price: Int
    let uploadTime: String
    let viewCount: Int
    let interestCount: Int
    let description: String
    let productCondition: String?
    let isDeliveryIncluded: Bool
    let standardDeliveryFee: Int
    let halfDeliveryFee: Int
    let isPriceNegotiable: Bool
    let tradeStatus: String
    let isOwnedByCurrentUser: Bool
}

struct ProductPhoto: Codable {
    let photoId: Int
    let photoUrl: String
    let photoSequence: Int
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
