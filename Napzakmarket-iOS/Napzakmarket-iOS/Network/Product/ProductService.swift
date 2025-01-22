//
//  ProductService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

protocol ProductServiceProtocol {
    func getBanners(completion: @escaping (NetworkResult<BannerResponseDTO>) -> ())
    func getPersonalProducts(completion: @escaping (NetworkResult<PersonalProductResponseDTO>) -> ())
    func getPopularSellProducts(completion: @escaping (NetworkResult<PopularSellProductResponseDTO>) -> ())
    func getRecommandedBuyProducts(completion: @escaping (NetworkResult<RecommandedBuyProductResponseDTO>) -> ())
}

final class ProductService: BaseService, ProductServiceProtocol {
    
    private let provider = MoyaProvider<ProductAPI>.init(plugins: [MoyaPlugin()])
    
    func getBanners(completion: @escaping (NetworkResult<BannerResponseDTO>) -> ()) {
        request(.getBanners, completion: completion)
    }
    
    func getPersonalProducts(completion: @escaping (NetworkResult<PersonalProductResponseDTO>) -> ()) {
        request(.getPersonalProducts, completion: completion)
    }
    
    func getPopularSellProducts(completion: @escaping (NetworkResult<PopularSellProductResponseDTO>) -> ()) {
        request(.getPopularSellProducts, completion: completion)
    }
    
    func getRecommandedBuyProducts(completion: @escaping (NetworkResult<RecommandedBuyProductResponseDTO>) -> ()) {
        request(.getRecommandedBuyProducts, completion: completion)
    }
    
    private func request<T: Decodable>(_ target: ProductAPI, completion: @escaping (NetworkResult<T>) -> ()) {
        provider.request(target) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<T> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
