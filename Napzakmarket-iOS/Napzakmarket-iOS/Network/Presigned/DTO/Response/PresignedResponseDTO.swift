//
//  PresignedResponse.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/22/25.
//

import Foundation

struct PresignedResponseDTO: Codable {
    let status: Int
    let message: String
    let data: ProductPresignedUrlsData
}

struct ProductPresignedUrlsData: Codable {
    let productPresignedUrls: [String: String]
}
