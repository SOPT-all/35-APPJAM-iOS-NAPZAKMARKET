//
//  APIResponse.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/11/25.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T?
}
