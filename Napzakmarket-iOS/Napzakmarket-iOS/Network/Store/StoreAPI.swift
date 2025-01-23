//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

enum StoreAPI {
    case postPreferGenres(request: RegisterPreferGenreRequestDTO)
    case getStoreInfo(storeId: Int)  // 마켓
    case getMyPageInfo // 마이페이지
}

extension StoreAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .postPreferGenres, .getMyPageInfo, .getStoreInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .postPreferGenres:
            return "stores/register"
        case .getMyPageInfo:
            return "stores/mypage"
        case .getStoreInfo(let storeId):
            return "stores/\(storeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPreferGenres:
            return .post
        case .getMyPageInfo, .getStoreInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postPreferGenres(let request):
              return .requestJSONEncodable(request)
            
        case .getMyPageInfo, .getStoreInfo:
            return .requestPlain
        }
    }

}
