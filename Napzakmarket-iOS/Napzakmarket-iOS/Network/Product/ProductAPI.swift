//
//  ProductAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

enum ProductAPI {
    case getBanners
    case getPersonalProducts
    case getPopularSellProducts
    case getRecommandedBuyProducts
    
    
    case sellProductRequest(registerItem: RegisterSellProductRequestDTO)
    case buyProductRequest(registerItem: RegisterBuyProductRequestDTO)
    
    case sellProductResponse(productId: Int)
    case buyProductResponse(productId: Int)
}

extension ProductAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .accessTokenHeader
        case .sellProductRequest, .buyProductRequest:
            return .accessTokenHeader
        case .sellProductResponse, .buyProductResponse:
            return .noneHeader
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
        case .sellProductRequest:
            return "products/sell"
        case .buyProductRequest:
            return "products/buy"
        case .sellProductResponse:
            return "products/sell"
        case .buyProductResponse:
            return "products/buy"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .get
        case .sellProductRequest:
            return .post
        case .buyProductRequest:
            return .post
        case .sellProductResponse:
            return .get
        case .buyProductResponse:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts:
            return .requestPlain
        case .sellProductRequest(let registerItem):
            return .requestJSONEncodable(registerItem)
        case .buyProductRequest(let registerItem):
            return .requestJSONEncodable(registerItem)
        case .sellProductResponse(let productId):
            return .requestParameters(parameters: ["productId" : productId.description], encoding: URLEncoding.queryString)
        case .buyProductResponse(let productId):
            return .requestParameters(parameters: ["productId" : productId.description], encoding: URLEncoding.queryString)
        }
    }
    
}
