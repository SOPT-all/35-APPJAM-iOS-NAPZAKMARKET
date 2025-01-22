//
//  MyPageStoreResponseDTO.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Foundation

struct MyPageInfoResponseDTO: Codable {
    let status: Int
    let message: String
    let data: MyPageInfoData
}

struct MyPageInfoData: Codable {
    let storeId: Int
    let storeNickname: String
    let storePhoto: String
}
