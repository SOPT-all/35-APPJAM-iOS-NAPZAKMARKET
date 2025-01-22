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
}

extension PresignedAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getPresignedURL:
            return .noneHeader
        }
    }

    var path: String {
        switch self {
        case .getPresignedURL:
            return "presigned-url/product"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPresignedURL:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getPresignedURL(let imageNameList):
            return .requestParameters(parameters: ["productImages" : imageNameList], encoding: URLEncoding.queryString)
        }
    }

    
}
