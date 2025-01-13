//
//  ProductDummyModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

struct ProductDummyModel: Hashable {
    let id: UUID
    let isLikeButtonExist: Bool
    let isLiked: Bool
    let genreName: String
    let productName: String
    let price: String
    let uploadTime: String
    let productType: ProductType
    let isPriceNegotiable: Bool?
}
