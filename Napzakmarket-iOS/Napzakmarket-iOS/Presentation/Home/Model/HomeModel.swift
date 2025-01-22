//
//  HomeModel.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/22/25.
//

import Foundation

@MainActor
final class HomeModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var banners: [Banner] = []
    @Published var personalProducts: [ProductModel] = []
    @Published var popularSellProducts: [ProductModel] = []
    @Published var recommendedBuyProducts: [ProductModel] = []
    
    var bannerImageUrls: [String] {
        banners.map { $0.bannerPhoto }
    }
    
    // MARK: - Functions
    
    func fetchBanners() async {
        NetworkService.shared.productService.getBanners { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.banners = data.bannerList
                }
                
            default:
                break
            }
        }
    }
    
    func fetchPersonalProducts() async {
        NetworkService.shared.productService.getPersonalProducts { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.personalProducts = data.productRecommendList.map { ProductModel(dto: $0) }
                }
                
            default:
                break
            }
        }
    }
    
    func fetchPopularSellProducts() async {
        NetworkService.shared.productService.getPopularSellProducts { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.popularSellProducts = data.productSellList.map { ProductModel(dto: $0) }
                }
                
            default:
                break
            }
        }
    }
    
    func fetchRecommendedBuyProducts() async {
        NetworkService.shared.productService.getRecommandedBuyProducts { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.recommendedBuyProducts = data.productBuyList.map { ProductModel(dto: $0) }
                }
            default:
                break
            }
        }
    }
    
}
