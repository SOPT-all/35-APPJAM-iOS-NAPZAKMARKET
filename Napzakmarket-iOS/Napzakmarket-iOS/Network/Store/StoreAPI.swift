//
//  StoreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

enum StoreAPI {
    case postPreferGenres(request: RegisterPreferGenreRequestDTO)
}

extension StoreAPI: BaseTargetType {
    
    var headerType: HeaderType {
        switch self {
        case .postPreferGenres: return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .postPreferGenres:
            return "stores/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPreferGenres:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postPreferGenres(let request):
              return .requestJSONEncodable(request)
        }
    }
    
}
