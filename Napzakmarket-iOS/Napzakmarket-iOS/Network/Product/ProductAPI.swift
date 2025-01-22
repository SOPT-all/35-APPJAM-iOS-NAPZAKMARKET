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
    case getChatInfo(productId: Int)
}

extension ProductAPI: BaseTargetType {
    
    var baseURL: URL {
        switch self {
        case .putPresignedURL(let url, _):
            // 프리사인드 URL을 절대 경로로 처리
            return URL(string: url) ?? URL(string: "https://napzak-dev-bucket.s3.ap-northeast-2.amazonaws.com")!
            
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
            
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts, .getChatInfo:
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
        case .putPresignedURL:
            return ""
        case .getChatInfo(let prodeuctId):
            return "products/chat/\(prodeuctId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts, .getChatInfo:
            return .get
        case .putPresignedURL:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts, .getChatInfo:
            return .requestPlain
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        }
    }
    
}
