//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

enum StoreAPI {
    case getmypageInfo
}

extension StoreAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .getmypageInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getmypageInfo:
            return "stores/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getmypageInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getmypageInfo:
            return .requestPlain
        }
    }
}
