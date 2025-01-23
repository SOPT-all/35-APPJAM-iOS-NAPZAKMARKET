//
//  ProductModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/15/25.
//

import Foundation

@MainActor
final class ProductModel: Identifiable, ObservableObject {
    
    let id: Int
    let genreName: String
    let productName: String
    let photo: String
    let price: Int
    let uploadTime: String
    @Published var isInterested: Bool
    let tradeType: ProductType
    let tradeStatus: String
    let isPriceNegotiable: Bool?
    let isOwnedByCurrentUser: Bool
    
    init(
        id: Int,
        genreName: String,
        productName: String,
        photo: String,
        price: Int,
        uploadTime: String,
        isInterested: Bool,
        tradeType: ProductType,
        tradeStatus: String,
        isPriceNegotiable: Bool?,
        isOwnedByCurrentUser: Bool
    ) {
        self.id = id
        self.genreName = genreName
        self.productName = productName
        self.photo = photo
        self.price = price
        self.uploadTime = uploadTime
        self.isInterested = isInterested
        self.tradeType = tradeType
        self.tradeStatus = tradeStatus
        self.isPriceNegotiable = isPriceNegotiable
        self.isOwnedByCurrentUser = isOwnedByCurrentUser
    }
    
    // DTO를 도메인 모델로 변환하는 이니셜라이저
    init(dto: Product) {
        self.id = dto.productId
        self.genreName = dto.genreName
        self.productName = dto.productName
        self.photo = dto.photo ?? ""
        self.price = dto.price
        self.uploadTime = dto.uploadTime
        self.isInterested = dto.isInterested
        self.tradeType = dto.tradeType
        self.tradeStatus = dto.tradeStatus
        self.isPriceNegotiable = dto.isPriceNegotiable
        self.isOwnedByCurrentUser = dto.isOwnedByCurrentUser
    }
    
    func postInterestToggle() async {
        await withCheckedContinuation { continuation in
            if isInterested {
                NetworkService.shared.interestService.deleteInterest(productId: id) { [weak self] result in
                    switch result {
                    case .success:
                        self?.isInterested = false
                    default:
                        break
                    }
                    continuation.resume()
                }
            } else {
                NetworkService.shared.interestService.postInterest(productId: id) { [weak self] result in
                    switch result {
                    case .success:
                        self?.isInterested = true
                    default:
                        break
                    }
                    continuation.resume()
                }
            }
        }
    }
    
}

extension ProductModel {
    static let dummyProducts: [ProductModel] = [
        ProductModel(
            id: 1,
            genreName: "산리오",
            productName: "딸기 마이멜로디 마스코트 인형",
            photo: "https://example.com/photo1.jpg",
            price: 35000,
            uploadTime: "3시간 전",
            isInterested: true,
            tradeType: .sell,
            tradeStatus: "available",
            isPriceNegotiable: false,
            isOwnedByCurrentUser: false
        ),
        ProductModel(
            id: 2,
            genreName: "디즈니",
            productName: "미키마우스 한정판 피규어",
            photo: "https://example.com/photo2.jpg",
            price: 50000,
            uploadTime: "1일 전",
            isInterested: false,
            tradeType: .buy,
            tradeStatus: "sold",
            isPriceNegotiable: true,
            isOwnedByCurrentUser: false
        ),
        ProductModel(
            id: 3,
            genreName: "포켓몬",
            productName: "피카츄 봉제인형",
            photo: "https://example.com/photo3.jpg",
            price: 27000,
            uploadTime: "2일 전",
            isInterested: true,
            tradeType: .sell,
            tradeStatus: "pending",
            isPriceNegotiable: nil,
            isOwnedByCurrentUser: true
        ),
        ProductModel(
            id: 4,
            genreName: "마블",
            productName: "아이언맨 액션 피규어",
            photo: "https://example.com/photo4.jpg",
            price: 60000,
            uploadTime: "5시간 전",
            isInterested: false,
            tradeType: .buy,
            tradeStatus: "available",
            isPriceNegotiable: true,
            isOwnedByCurrentUser: false
        ),
        ProductModel(
            id: 5,
            genreName: "DC 코믹스",
            productName: "배트맨 한정판 마스크",
            photo: "https://example.com/photo5.jpg",
            price: 80000,
            uploadTime: "1시간 전",
            isInterested: true,
            tradeType: .sell,
            tradeStatus: "sold",
            isPriceNegotiable: false,
            isOwnedByCurrentUser: false
        ),
        ProductModel(
            id: 6,
            genreName: "지브리",
            productName: "토토로 인형 세트",
            photo: "https://example.com/photo6.jpg",
            price: 45000,
            uploadTime: "3일 전",
            isInterested: false,
            tradeType: .buy,
            tradeStatus: "available",
            isPriceNegotiable: nil,
            isOwnedByCurrentUser: true
        ),
        ProductModel(
            id: 7,
            genreName: "스타워즈",
            productName: "다스베이더 광선검",
            photo: "https://example.com/photo7.jpg",
            price: 70000,
            uploadTime: "30분 전",
            isInterested: true,
            tradeType: .sell,
            tradeStatus: "pending",
            isPriceNegotiable: true,
            isOwnedByCurrentUser: false
        )
    ]
}
