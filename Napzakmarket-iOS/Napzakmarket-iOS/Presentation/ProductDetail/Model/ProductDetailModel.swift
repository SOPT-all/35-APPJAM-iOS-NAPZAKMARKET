//
//  ProductDetailModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/17/25.
//

import Foundation

@MainActor
final class ProductDetailModel: ObservableObject, Identifiable {
    
    //MARK: - Property Wrappers
    
    @Published var isInterested = Bool()
    @Published var productDetail: ProductDetail?
    @Published var productPhotoList: [ProductPhoto] = []
    @Published var storeInfo: Store?
    @Published var storeReviewList: [Review] = []
    
    //MARK: - Property
    
    
    //MARK: - Init
    
    init() {}
    
    init(dto: ProductDetailData) {
        self.isInterested = dto.isInterested
        self.productDetail = dto.productDetail
        self.productPhotoList = dto.productPhotoList
        self.storeInfo = dto.storeInfo
        self.storeReviewList = dto.storeReviewList
    }
}

extension ProductDetailModel {
    
    //MARK: - Func
    
    func getProductDetail(productId: Int) async {
        NetworkService.shared.productService.getProductDetail(productId: productId) { result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self.isInterested = response.data.isInterested
                self.productDetail = response.data.productDetail
                self.productPhotoList = response.data.productPhotoList
                self.storeInfo = response.data.storeInfo
                self.storeReviewList = response.data.storeReviewList
            default:
                break
            }
        }
    }
    
    func postInterestToggle(productId: Int) async {
        await withCheckedContinuation { continuation in
            if isInterested {
                NetworkService.shared.interestService.deleteInterest(productId: productId) { [weak self] result in
                    switch result {
                    case .success:
                        self?.isInterested = false
                    default:
                        break
                    }
                    continuation.resume()
                }
            } else {
                NetworkService.shared.interestService.postInterest(productId: productId) { [weak self] result in
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
