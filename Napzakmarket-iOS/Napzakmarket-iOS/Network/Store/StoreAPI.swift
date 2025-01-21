//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

enum MyPageAPI {
    case fetchMyPageInfo
}

extension MyPageAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .fetchMyPageInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchMyPageInfo:
            return "stores/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyPageInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMyPageInfo:
            return .requestPlain
        }
    }
}
