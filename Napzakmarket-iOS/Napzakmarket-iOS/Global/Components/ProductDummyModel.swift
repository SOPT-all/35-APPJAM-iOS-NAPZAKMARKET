//
//  ProductDummyModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

struct ProductDummyModel: Hashable {
    let id: Int
    var isLiked: Bool
    let genreName: String
    let productName: String
    let price: String
    let uploadTime: String
    let productType: ProductType
    let isPriceNegotiable: Bool?
}

extension ProductDummyModel {
    static let sellDummy = [
        ProductDummyModel(
            id: 1,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 2,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 3,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 4,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 5,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 6,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 7,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        )
    ]
    
    static let buyDummy = [
        ProductDummyModel(
            id: 1,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 2,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: 3,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 4,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: 5,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 6,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: 7,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 8,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: 9,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        )
    ]
}
