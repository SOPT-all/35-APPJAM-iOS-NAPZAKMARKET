//
//  MyPageModel.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/14/25.
//

import Foundation

enum MyPageModel: CaseIterable {
    case purchase
    case favorite
    case review
    case recent
    
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
