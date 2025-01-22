//
//  ProductAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

enum ProductAPI {
    case putPresignedURL(url: String, imageData: Data)
}

extension ProductAPI: BaseTargetType {
    var baseURL: URL {
        switch self {
        case .putPresignedURL(let url, _):
            // 프리사인드 URL을 절대 경로로 처리
            return URL(string: url) ?? URL(string: "https://napzak-dev-bucket.s3.ap-northeast-2.amazonaws.com")!
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .putPresignedURL:
            return .noneHeader
        }
    }

    var path: String {
        switch self {
        case .putPresignedURL(let url, _):
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .putPresignedURL:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case .putPresignedURL(_, let imageData):
            return .requestData(imageData)
        }
    }

}
