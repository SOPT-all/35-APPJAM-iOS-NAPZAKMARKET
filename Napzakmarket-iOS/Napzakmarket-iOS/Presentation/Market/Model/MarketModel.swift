//
//  MarketModel.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/15/25.
//

import Foundation

@MainActor
final class MarketModel: ObservableObject {
    
    // Mark: - properties
    
    @Published var buyProducts: [ProductModel] = []
    @Published var sellProducts: [ProductModel] = []
    
    
    func getStoreOwnerSellProducts(storeId: Int, productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getStoreOwnerSellProduct(
            storeOwnerId: storeId,
            sortOption: productFetchOption.sortOption.rawValue,
            genreIDs: productFetchOption.genreIDs,
            isOnSale: productFetchOption.isOnSale,
            isUnopened: productFetchOption.isUnopened) { [weak self] result in
                switch result {
                case .success(let dto):
                    if let data = dto?.data {
                        self?.sellProducts = data.productSellList.map { ProductModel(dto: $0)}
                    }
                    
                default:
                    break
                }
            }
    }
    
    func getStoreOwnerBuyProducts(storeId: Int, productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getStoreOwnerBuyProduct(
            storeOwnerId: storeId,
            sortOption: productFetchOption.sortOption.rawValue,
            genreIDs: productFetchOption.genreIDs,
            isOnSale: productFetchOption.isOnSale) { [weak self] result in
                switch result {
                case .success(let dto):
                    if let data = dto?.data {
                        self?.buyProducts = data.productBuyList.map { ProductModel(dto: $0)}
                    }
                    
                default:
                    break
                }
            }
    }
    
}


