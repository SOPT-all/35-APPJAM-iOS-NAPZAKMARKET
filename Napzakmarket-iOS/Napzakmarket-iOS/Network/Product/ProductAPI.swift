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
    case getSellProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool)
    case getBuyProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool)
    case getSellProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool)
    case getBuyProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool)
    case getProductDetail(productId: Int)
    case getStoreOwnerSellProduct(Int, ProductFetchOption)
    case getStoreOwnerBuyProduct(Int, ProductFetchOption)
    case postInterest(productId: Int)
    case deleteInterest(productId: Int)
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
        default:
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
        case .getSellProduct:
            return "products/sell"
        case .getBuyProduct:
            return "products/buy"
        case .getSellProductForSearch:
            return "products/sell/search"
        case .getBuyProductForSearch:
            return "products/buy/search"
        case .getProductDetail(let productId):
            return "products/\(productId)"
        case .getStoreOwnerSellProduct(let storeOwnerId, _):
            return "products/sell/stores/\(storeOwnerId)"
        case .getStoreOwnerBuyProduct(let storeOwnerId, _):
            return "products/buy/stores/\(storeOwnerId)"
        case .postInterest(let productId), .deleteInterest(let productId):
            return "interest/\(productId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putPresignedURL:
            return .put
        case .postInterest:
            return .post
        case .deleteInterest:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts, .postInterest, .deleteInterest, .getProductDetail:
            return .requestPlain
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        case .getSellProduct(let sortOption, let genreIDs, let isOnSale, let isUnopened):
            return .requestParameters(parameters: ["sortOption" : sortOption,
                                                   "genreId" : genreIDs ?? [],
                                                   "isOnSale" : isOnSale,
                                                   "isUnopened" : isUnopened],
                                      encoding: URLEncoding.queryString)
        case .getBuyProduct(let sortOption, let genreIDs, let isOnSale):
            return .requestParameters(parameters: ["sortOption" : sortOption,
                                                   "genreId" : genreIDs ?? [],
                                                   "isOnSale" : isOnSale],
                                      encoding: URLEncoding.queryString)
        case .getSellProductForSearch(let searchWord, let sortOption, let genreIDs, let isOnSale, let isUnopened):
            return .requestParameters(parameters: ["searchWord" : searchWord,
                                                   "sortOption" : sortOption,
                                                   "genreId" : genreIDs ?? [],
                                                   "isOnSale" : isOnSale,
                                                   "isUnopened" : isUnopened],
                                      encoding: URLEncoding.queryString)
        case .getBuyProductForSearch(let searchWord, let sortOption, let genreIDs, let isOnSale):
            return .requestParameters(parameters: ["searchWord" : searchWord,
                                                   "sortOption" : sortOption,
                                                   "genreId" : genreIDs ?? [],
                                                   "isOnSale" : isOnSale],
                                      encoding: URLEncoding.queryString)
        case .getStoreOwnerSellProduct(_, let option):
            return .requestParameters(parameters: ["sortOption": option.sortOptionValue,
                                                   "genreId": option.genreIDs,
                                                   "isOnSale": option.isOnSale,
                                                   "isUnopened": option.isUnopened],
                                        encoding: URLEncoding.queryString)
        case .getStoreOwnerBuyProduct(_, let option):
            return .requestParameters(parameters: ["sortOption": option.sortOptionValue,
                                                   "genreId": option.genreIDs,
                                                   "isOnSale": option.isOnSale],
                                        encoding: URLEncoding.queryString
            )
        }
    }
}
