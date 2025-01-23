//
//  PresignedAPI.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/22/25.
//

import SwiftUI

import Moya

enum PresignedAPI {
    case getPresignedURL(imageNameList: [String])
    case putPresignedURL(url: String, imageData: Data)
}

extension PresignedAPI: BaseTargetType {
    
    var baseURL: URL {
        switch self {
        case .putPresignedURL(let url, _):
            // 프리사인드 URL을 절대 경로로 처리
            return URL(string: url) ?? URL(string: "")!
        default:
            guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
                  let url = URL(string: urlString) else {
                fatalError("🚨Base URL을 찾을 수 없습니다🚨")
            }
            return url
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .putPresignedURL:
            return .noneHeader
        case .getPresignedURL:
            return .noneHeader
        }
    }

    var path: String {
        switch self {
        case .getPresignedURL:
            return "presigned-url/product"
        case .putPresignedURL:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPresignedURL:
            return .get
        case .putPresignedURL:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case .getPresignedURL(let imageNameList):
            return .requestParameters(parameters: ["productImages" : imageNameList], encoding: URLEncoding.queryString)
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        }
    }

    
}
