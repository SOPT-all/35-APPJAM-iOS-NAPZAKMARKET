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
    let data: productPresignedUrls
}

struct productPresignedUrls: Codable {
    let presignedURL: [String: String]
}
