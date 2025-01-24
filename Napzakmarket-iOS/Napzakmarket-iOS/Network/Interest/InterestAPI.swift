//
//  InterestAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

enum InterestAPI {
    case postInterest(productId: Int)
    case deleteInterest(productId: Int)
}

extension InterestAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .postInterest, .deleteInterest:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .postInterest(let productId), .deleteInterest(let productId):
            return "interest/\(productId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postInterest:
            return .post
        case .deleteInterest:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postInterest, .deleteInterest:
            return .requestPlain
        }
    }
    
    
}
