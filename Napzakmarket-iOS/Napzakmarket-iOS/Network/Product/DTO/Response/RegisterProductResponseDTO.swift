//
//  RegisterProductResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct RegisterSellProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: RegisterSellProductData
}

struct RegisterSellProductData: Codable {
    let productId: Int
    let productPhotoList: [RegisterPhoto]
    let genreId: Int
    let title: String
    let description: String
    let productCondition: String
    let price: Int
    let isDeliveryIncluded: Bool
    let standardDeliveryFee: Int
    let halfDeliveryFee: Int
    let createdAt: String
}

struct RegisterBuyProductResponseDTO: Codable {
    let status: Int
    let message: String
    let data: RegisterBuyProductData
}

struct RegisterBuyProductData: Codable {
    let productId: Int
    let productPhotoList: [RegisterPhoto]
    let genreId: Int
    let title: String
    let description: String
    let price: Int
    let isPriceNegotiable: Bool
    let createdAt: String
}

struct RegisterPhoto: Codable {
    let photoId: Int
    let photoUrl: String
    let sequence: Int
}

