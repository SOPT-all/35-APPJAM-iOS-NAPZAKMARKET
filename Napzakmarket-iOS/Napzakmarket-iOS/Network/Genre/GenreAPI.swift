//
//  GenreAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

enum GenreAPI {
    case getAllPreferGenre
    case getSearchPreferGenre(searchWord: String)
    case getAllGenreName
    case getSearchGenreName(searchWord: String)
}

extension GenreAPI: BaseTargetType {

    var headerType: HeaderType {
        switch self {
        case .getAllPreferGenre, .getSearchPreferGenre, .getAllGenreName, .getSearchGenreName:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getAllPreferGenre:
            return "onboarding/genres"
        case .getSearchPreferGenre:
            return "onboarding/genres/search"
        case .getAllGenreName:
            return "genres"
        case .getSearchGenreName:
            return "genres/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPreferGenre, .getSearchPreferGenre, .getAllGenreName, .getSearchGenreName:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllPreferGenre, .getAllGenreName:
            return .requestPlain
        case .getSearchPreferGenre(let searchWord):
            return .requestParameters(parameters: ["searchWord" : searchWord], encoding: URLEncoding.queryString)
        case .getSearchGenreName(let searchWord):
            return .requestParameters(parameters: ["searchWord" : searchWord], encoding: URLEncoding.queryString)
        }
    }
}
