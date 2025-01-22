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
    case putPresignedURL(url: String, imageData: Data)
    case sellProductRequest(registerItem: RegisterSellProductRequestDTO)
    case buyProductRequest
    case sellProductResponse(productId: Int)
    case buyProductResponse
}

extension ProductAPI: BaseTargetType {
    
    var baseURL: URL {
        switch self {
        case .putPresignedURL(let url, _):
            // 프리사인드 URL을 절대 경로로 처리
            return URL(string: url) ?? URL(string: "")!
        default:
            guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
                  let url = URL(string: urlString) else {
                fatalError("🚨Base URL을 찾을 수 없습니다🚨")
            }
            return url
        }
        
    }
    
    var headerType: HeaderType {
        switch self {
        case .putPresignedURL:
            return .noneHeader
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
        case .putPresignedURL:
            return ""
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
        case .putPresignedURL:
            return .put
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
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        case .sellProductRequest(let registerItem):
            return .requestJSONEncodable(registerItem)
        case .buyProductRequest:
            return .requestPlain    //
        case .sellProductResponse(let productId):
            return .requestParameters(parameters: ["productId" : productId.description], encoding: URLEncoding.queryString)
        case .buyProductResponse:
            return .requestPlain    //
        }
    }
    
}
