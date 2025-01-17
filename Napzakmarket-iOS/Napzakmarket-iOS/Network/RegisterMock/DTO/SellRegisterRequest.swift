//
//  SellRegisterRequest.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/17/25.
//

import Foundation

// MARK: - SellRegisterRequest
struct SellRegisterRequest: Codable {
    let productPhotoList: [ProductPhotoList]?
    let productInfo: ProductInfo?
}

// MARK: - ProductInfo
struct ProductInfo: Codable {
    let genreID: Int?
    let genreName, title, description, condition: String?
    let price: Int?
    let isDeliveryIncluded: Bool?
    let standardDeliveryFee, halfDeliveryFee: Int?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case genreName, title, description, condition, price, isDeliveryIncluded, standardDeliveryFee, halfDeliveryFee
    }
}

// MARK: - ProductPhotoList
struct ProductPhotoList: Codable {
    let photoURL: String?
    let photoSequence: Int?

    enum CodingKeys: String, CodingKey {
        case photoURL = "photoUrl"
        case photoSequence
    }
}
