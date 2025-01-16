//
//  MarketModel.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/15/25.
//

import Foundation

struct Tag: Identifiable {
    let id: String
    let name: String
}

//MockData
struct MarketMockData {
    static let tags: [Tag] = [
        Tag(id: UUID().uuidString, name: "최강아요"),
        Tag(id: UUID().uuidString, name: "납작어진"),
        Tag(id: UUID().uuidString, name: "납작혜린"),
        Tag(id: UUID().uuidString, name: "납작호근"),
        Tag(id: UUID().uuidString, name: "납작한열")
    ]
}


