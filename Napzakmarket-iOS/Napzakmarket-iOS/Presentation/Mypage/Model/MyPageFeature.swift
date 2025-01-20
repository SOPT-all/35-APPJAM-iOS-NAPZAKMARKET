//
//  MyPageFeature.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/14/25.
//

import Foundation

enum MyPageFeature: CaseIterable, Identifiable {
    case purchase
    case favorite
    case review
    case recent
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .purchase: return "판매/구매 내역"
        case .favorite: return "관심 장르"
        case .review: return "찜한 상품"
        case .recent: return "최근 본 상품"
        }
    }
    
    var iconName: String {
        switch self {
        case .purchase: return "ic_my_history"
        case .favorite: return "ic_my_interest"
        case .review: return "ic_my_like"
        case .recent: return "ic_my_recent"
        }
    }
}

// MARK: - DTO

struct MyPageResponse: Codable {
    let storeId: Int
    let nickname: String
    let storePhoto: String
    
    enum CodingKeys: String, CodingKey {
        case storeId
        case nickname
        case storePhoto
    }
}

// MARK: - Mock Data

extension MyPageResponse {
    static let mockData = MyPageResponse(
        storeId: 12345,
        nickname: "오딩잉",
        storePhoto: "img_profile_md"
    )
}
