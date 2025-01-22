//
//  ProductAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

enum ProductAPI {
    case getBanners
    case getPersonalProducts
    case getPopularSellProducts
    case getRecommandedBuyProducts
}

extension ProductAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getBanners:
            return "banners/home"
        case .getPersonalProducts:
            return "products/home/recommend"
        case .getPopularSellProducts:
            return "products/home/sell"
        case .getRecommandedBuyProducts:
            return "products/home/buy"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .requestPlain
        }
    }
    
}
