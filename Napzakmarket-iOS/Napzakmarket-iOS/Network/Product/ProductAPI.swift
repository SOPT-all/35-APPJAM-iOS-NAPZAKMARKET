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
    case putPresignedURL(url: String, imageData: Data)
    case getChatInfo(productId: Int)
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
    
    var headerType: HeaderType {
        switch self {
        case .sellProductResponse, .buyProductResponse:
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
        case .sellProductRequest:
            return "products/sell"
        case .buyProductRequest:
            return "products/buy"
        case .sellProductResponse:
            return "products/sell"
        case .buyProductResponse:
            return "products/buy"
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
        case .getChatInfo(let prodeuctId):
            return "products/chat/\(prodeuctId)"
        case .putPresignedURL:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postInterest:
            return .post
        case .deleteInterest:
            return .delete
        case .sellProductRequest, .buyProductRequest, .putPresignedURL:
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBanners, .getPersonalProducts, .getPopularSellProducts, .getRecommandedBuyProducts, .postInterest, .deleteInterest, .getProductDetail, .getChatInfo:
            return .requestPlain
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        case .sellProductRequest(let registerItem):
            return .requestJSONEncodable(registerItem)
        case .buyProductRequest(let registerItem):
            return .requestJSONEncodable(registerItem)
        case .sellProductResponse(let productId):
            return .requestParameters(parameters: ["productId" : productId.description], encoding: URLEncoding.queryString)
        case .buyProductResponse(let productId):
            return .requestParameters(parameters: ["productId" : productId.description], encoding: URLEncoding.queryString)
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
