//
//  ProductDummyModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

struct ProductDummyModel: Hashable {
    let id: UUID
    let isLikeButtonExist: Bool
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
            id: .init(),
            isLikeButtonExist: true,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .sell,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
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
            id: .init(),
            isLikeButtonExist: true,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: true,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: false
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
            isLiked: false,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            price: "35,000원",
            uploadTime: "3시간 전",
            productType: .buy,
            isPriceNegotiable: true
        ),
        ProductDummyModel(
            id: .init(),
            isLikeButtonExist: true,
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
