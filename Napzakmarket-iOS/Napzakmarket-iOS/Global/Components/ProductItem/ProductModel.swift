//
//  ProductModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/15/25.
//

import Foundation

final class ProductModel: ObservableObject, Identifiable {
    
    //MARK: - Property Wrappers
    
    @Published var isLiked: Bool
    
    //MARK: - Properties
    
    let id: Int
    let genreName: String
    let productName: String
    let price: String
    let uploadTime: String
    let productType: ProductType
    let isPriceNegotiable: Bool?
    
    //MARK: - Init
    
    init(id: Int, isLiked: Bool, genreName: String, productName: String, price: String, uploadTime: String, productType: ProductType, isPriceNegotiable: Bool?) {
        self.id = id
        self.isLiked = isLiked
        self.genreName = genreName
        self.productName = productName
        self.price = price
        self.uploadTime = uploadTime
        self.productType = productType
        self.isPriceNegotiable = isPriceNegotiable
    }
}

extension ProductModel {
    
    //MARK: - Func
    
    func toggleLike() {
        isLiked.toggle()
    }
    
    //MARK: - Dummy Model List
    
    static func sellDummyList() -> [ProductModel] {
        return [
            ProductModel(
                id: 1,
                isLiked: true,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 2,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 3,
                isLiked: true,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 4,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 5,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 6,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .sell,
                isPriceNegotiable: false
            ),
            ProductModel(
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
    }
    
    static func buyDummyList() -> [ProductModel] {
        return [
            ProductModel(
                id: 1,
                isLiked: true,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 2,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: true
            ),
            ProductModel(
                id: 3,
                isLiked: true,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 4,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: true
            ),
            ProductModel(
                id: 5,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 6,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: true
            ),
            ProductModel(
                id: 7,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: false
            ),
            ProductModel(
                id: 8,
                isLiked: false,
                genreName: "산리오",
                productName: "딸기 마이멜로디 마스코트 인형",
                price: "35,000원",
                uploadTime: "3시간 전",
                productType: .buy,
                isPriceNegotiable: false
            ),
            ProductModel(
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
}
