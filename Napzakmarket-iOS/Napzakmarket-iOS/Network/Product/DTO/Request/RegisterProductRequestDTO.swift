//
//  RegisterProductRequestDTO.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

struct RegisterSellProductRequestDTO: Codable {
    let productPhotoList: [RegisteredPhoto]
    let genreId: Int
    let title: String
    let description: String
    let price: Int
    let productCondition: String
    let isDeliveryIncluded: Bool
    let standardDeliveryFee: Int
    let halfDeliveryFee: Int
}

struct RegisterBuyProductRequestDTO: Codable {
    let productPhotoList: [RegisteredPhoto]
    let genreId: Int
    let title: String
    let description: String
    let price: Int
    let isPriceNegotiable: Bool
}

struct RegisteredPhoto: Codable {
    let photoUrl: String
    let sequence: Int
}
