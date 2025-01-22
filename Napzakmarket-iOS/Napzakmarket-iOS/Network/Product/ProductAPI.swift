//
//  ProductAPI.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

enum ProductAPI {
    case uploadImage(image: UIImage)
}

extension ProductAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .uploadImage:
            return .noneHeader
        }
    }

    var path: String {
        switch self {
        case .uploadImage:
            return "products/sell"
        }
    }

    var method: Moya.Method {
        switch self {
        case .uploadImage:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .uploadImage(let image):
            let imageData = image.jpegData(compressionQuality: 0.8)!
            let formData = MultipartFormData(provider: .data(imageData), name: "file")
            return .uploadMultipart([formData])
        }
    }

    
}
