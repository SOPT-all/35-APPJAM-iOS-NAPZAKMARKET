//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

enum StoreAPI {
    case getStoreInfo
}

extension StoreAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .getStoreInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getStoreInfo:
            return "stores/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStoreInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getStoreInfo:
            return .requestPlain
        }
    }
}
