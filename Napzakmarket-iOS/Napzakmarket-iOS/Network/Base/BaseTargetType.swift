//
//  BaseTargetType.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

import Moya

enum HeaderType {
    case noneHeader
    case accessTokenHeader
}

protocol BaseTargetType: TargetType {
    var headerType: HeaderType { get }
}

extension BaseTargetType {
    
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        return url
    }
        
    var headers: [String: String]? {
        
        switch headerType {
        case .noneHeader:
            return .none
        case .accessTokenHeader:
            guard let accessToken = Bundle.main.infoDictionary?["TEMPORARY_ACCESS_TOKEN"] as? String
            else {
                fatalError("🚨accessToken을 찾을 수 없습니다🚨")
            }
            
            let header = ["Content-Type": "application/json",
                          "Authorization": "Bearer \(accessToken)"]

            return header
        }
    }
}
