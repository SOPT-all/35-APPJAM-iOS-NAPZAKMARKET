//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

enum StoreAPI {
    case postPreferGenres(request: RegisterPreferGenreRequestDTO)
    case getmypageInfo
}

extension StoreAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .postPreferGenres, .getmypageInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .postPreferGenres:
            return "stores/register"
        case .getmypageInfo:
            return "stores/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPreferGenres:
            return .post
        case .getmypageInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postPreferGenres(let request):
              return .requestJSONEncodable(request)
            
        case .getmypageInfo:
            return .requestPlain
        }
    }

}
