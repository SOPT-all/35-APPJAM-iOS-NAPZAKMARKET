//
//  ProductDetailModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/17/25.
//

import Foundation

enum ProductCondition {
    case unopened
    case excellent
    case slightlyUsed
    case used
}

struct ProductInfo {
    let productId: Int
    let productType: ProductType
    let genreName: String
    let productName: String
    let price: Int
    let uploadTime: String
    let viewCount: Int
    let interestCount: Int
    let description: String
    let productCondition: ProductCondition
    let isDeliveryIncluded: Bool
    let standardDeliveryFee: Int
    let halfDeliveryFee: Int
    let isPriceNegotiable: Bool
    let tradeStatus: String
    let isOwnedByCurrentUser: Bool
}

struct PhotoInfo {
    let photoId: Int
    let photoUrl: String
    let photoSequence: Int
}

struct StoreInfo {
    let userId: Int
    let storePhoto: String
    let nickname: String
    let totalProducts: Int
    let totalTransactions: Int
}

struct StoreReview {
    let reviewId: Int
    let reviewerNickname: String
    let rating: Double
    let comment: String
    let relatedProductId: Int
    let relatedProductName: String
}

final class ProductDetailModel: ObservableObject, Identifiable {
    
    //MARK: - Property Wrappers
    
    @Published var isInterested: Bool
    
    //MARK: - Properties
    
    let productDetail: ProductInfo
    let productPhotoList: [PhotoInfo]
    let storeInfo: StoreInfo
    let storeReviewList: [StoreReview]
    
    //MARK: - Init
    
    init(isInterested: Bool, productDetail: ProductInfo, productPhotoList: [PhotoInfo], storeInfo: StoreInfo, storeReviewList: [StoreReview]) {
        self.isInterested = isInterested
        self.productDetail = productDetail
        self.productPhotoList = productPhotoList
        self.storeInfo = storeInfo
        self.storeReviewList = storeReviewList
    }
}

extension ProductDetailModel {
    
    //MARK: - Func
    
    func toggleLike() {
        isInterested.toggle()
    }
    
    //MARK: - Dummy Model List
    
    static func dummySellProductDetail() -> ProductDetailModel {
        return ProductDetailModel(
            isInterested: true,
            productDetail: ProductInfo(
                productId: 1,
                productType: .sell,
                genreName: "치이카와",
                productName: "박어진 판매합니다. !!",
                price: 35000,
                uploadTime: "3억시간 전",
                viewCount: 27,
                interestCount: 4,
                description: "박어진 판매합니다!\n연남동에서 구매했어요 한정판.. ㅠㅠㅠ 보내기 아깝다.\n마감 임박 빨리 데려가세요... ㄷㄷ ",
                productCondition: .unopened,
                isDeliveryIncluded: true,
                standardDeliveryFee: 3800,
                halfDeliveryFee: 1800,
                isPriceNegotiable: false,
                tradeStatus: "거래 중",
                isOwnedByCurrentUser: false
            ),
            productPhotoList: [
                PhotoInfo(photoId: 1,
                          photoUrl: "http://example.com/photo1.jpg",
                          photoSequence: 1
                         ),
                PhotoInfo(photoId: 2,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 2
                         ),
                PhotoInfo(photoId: 3,
                          photoUrl: "http://example.com/photo3.jpg",
                          photoSequence: 3
                         )
                
            ],
            storeInfo: StoreInfo(
                userId: 1,
                storePhoto: "http://example.com/photo3.jpg",
                nickname: "납작한 빼꼼이",
                totalProducts: 349,
                totalTransactions: 77
            ),
            storeReviewList: [StoreReview(reviewId: Int(), reviewerNickname: String(), rating: Double(), comment: String(), relatedProductId: Int(), relatedProductName: String())]
        )
    }
    
    static func dummyBuyProductDetail() -> ProductDetailModel {
        return ProductDetailModel(
            isInterested: true,
            productDetail: ProductInfo(
                productId: 1,
                productType: .buy,
                genreName: "앙상블스타즈",
                productName: "앙스타 토모에 히요리 이츠누이 함께사는누이 곰인형",
                price: 100000,
                uploadTime: "1시간 전",
                viewCount: 27,
                interestCount: 4,
                description: "현물로 토모에 히요리 이츠누이 간절히 구해봅니다.\n사진과 함께 채팅 부탁드려요! 가격 제시는 가능하나 과한 플미는 어려울 것 같습니다 ㅠ0ㅠ",
                productCondition: .unopened,
                isDeliveryIncluded: false,
                standardDeliveryFee: 3800,
                halfDeliveryFee: 1800,
                isPriceNegotiable: true,
                tradeStatus: "거래 중",
                isOwnedByCurrentUser: true
            ),
            productPhotoList: [
                PhotoInfo(photoId: 1,
                          photoUrl: "http://example.com/photo1.jpg",
                          photoSequence: 1
                         ),
                PhotoInfo(photoId: 2,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 2
                         ),
                PhotoInfo(photoId: 3,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 3
                         ),
                PhotoInfo(photoId: 4,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 4
                         ),
                PhotoInfo(photoId: 5,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 5
                         ),
                PhotoInfo(photoId: 6,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 6
                         ),
                PhotoInfo(photoId: 7,
                          photoUrl: "http://example.com/photo2.jpg",
                          photoSequence: 7
                         ),
                PhotoInfo(photoId: 8,
                          photoUrl: "http://example.com/photo3.jpg",
                          photoSequence: 8
                         )
                
            ],
            storeInfo: StoreInfo(
                userId: 1,
                storePhoto: "http://example.com/photo3.jpg",
                nickname: "납작한 빼꼼이",
                totalProducts: 349,
                totalTransactions: 77
            ),
            storeReviewList: [StoreReview(reviewId: Int(), reviewerNickname: String(), rating: Double(), comment: String(), relatedProductId: Int(), relatedProductName: String())]
        )
    }

}
