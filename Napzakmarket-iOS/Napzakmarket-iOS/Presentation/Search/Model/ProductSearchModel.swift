//
//  ProductSearchModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/16/25.
//

import Foundation

struct ProductFetchOption: Equatable {
    var sortOption: SortOption
    var genreIDs: [Int]
    var isOnSale: Bool
    var isUnopened: Bool
}

final class ProductSearchModel: ObservableObject {

    //MARK: - Property Wrappers

    @Published var sellProducts: [ProductModel] = []
    @Published var buyProducts: [ProductModel] = []
}

extension ProductSearchModel {

    //MARK: - API Request Func

    func getSellProducts(productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getSellProduct(sortOption: productFetchOption.sortOption.rawValue, genreIDs: productFetchOption.genreIDs, isOnSale: productFetchOption.isOnSale, isUnopened: productFetchOption.isUnopened) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self?.sellProducts = response.data.productSellList.map { ProductModel(dto: $0) }
            default:
                break
            }
        }
    }

    func getBuyProducts(productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getBuyProduct(sortOption: productFetchOption.sortOption.rawValue, genreIDs: productFetchOption.genreIDs, isOnSale: productFetchOption.isOnSale) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self?.buyProducts = response.data.productBuyList.map { ProductModel(dto: $0) }
            default:
                break
            }
        }
    }

    func getSellProductsForSearch(searchWord: String, productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getSellProductForSearch(searchWord: searchWord, sortOption: productFetchOption.sortOption.rawValue, genreIDs: productFetchOption.genreIDs, isOnSale: productFetchOption.isOnSale, isUnopened: productFetchOption.isUnopened) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self?.sellProducts = response.data.productSellList.map { ProductModel(dto: $0) }
            default:
                break
            }
        }
    }

    func getBuyProductsForSearch(searchWord: String, productFetchOption: ProductFetchOption) async {
        NetworkService.shared.productService.getBuyProductForSearch(searchWord: searchWord, sortOption: productFetchOption.sortOption.rawValue, genreIDs: productFetchOption.genreIDs, isOnSale: productFetchOption.isOnSale) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self?.buyProducts = response.data.productBuyList.map { ProductModel(dto: $0) }
            default:
                break
            }
        }
    }

}
