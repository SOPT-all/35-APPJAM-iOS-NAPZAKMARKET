//
//  ProductService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

protocol ProductServiceProtocol {
    func getBanners(completion: @escaping (NetworkResult<BannerResponseDTO>) -> ())
    func getPersonalProducts(completion: @escaping (NetworkResult<PersonalProductResponseDTO>) -> ())
    func getPopularSellProducts(completion: @escaping (NetworkResult<PopularSellProductResponseDTO>) -> ())
    func getRecommandedBuyProducts(completion: @escaping (NetworkResult<RecommandedBuyProductResponseDTO>) -> ())
    

    // register 관련
    func postRegisterSellRequest(registerSellProduct: RegisterSellProductRequestDTO,
                                 completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ())
    
    func getRegisterSellResponse(productId: Int, completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ())
    
    func postRegisterBuyRequest(registerBuyProduct: RegisterBuyProductRequestDTO,
                                completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ())
    
    func getRegisterBuyResponse(productId: Int, completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ())
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
    

    
    func postRegisterSellRequest(registerSellProduct: RegisterSellProductRequestDTO, completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ()) {
        request(.sellProductRequest(registerItem: registerSellProduct), completion: completion)
    }
    
    func getRegisterSellResponse(productId: Int, completion: @escaping
    (NetworkResult<RegisterSellProductResponseDTO>) -> ()) {
        request(.sellProductResponse(productId: productId), completion: completion)
    }
    
    func postRegisterBuyRequest(registerBuyProduct: RegisterBuyProductRequestDTO, completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ()) {
        request(.buyProductRequest(registerItem: registerBuyProduct), completion: completion)
    }
    
    func getRegisterBuyResponse(productId: Int, completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ()) {
        request(.buyProductResponse(productId: productId), completion: completion)
    }
    
}
