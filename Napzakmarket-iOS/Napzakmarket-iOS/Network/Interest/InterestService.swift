//
//  InterestService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

protocol InterestServiceProtocol {
    func postInterest(productId: Int, completion: @escaping (NetworkResult<Any>) -> ())
    func deleteInterest(productId: Int, completion: @escaping (NetworkResult<Any>) -> ())
}

final class InterestService: BaseService, InterestServiceProtocol {
    
    private let provider = MoyaProvider<InterestAPI>.init(plugins: [MoyaPlugin()])
    
    func postInterest(productId: Int, completion: @escaping (NetworkResult<Any>) -> ()) {
        request(.postInterest(productId: productId), completion: completion)
    }
    
    func deleteInterest(productId: Int, completion: @escaping (NetworkResult<Any>) -> ()) {
        request(.deleteInterest(productId: productId), completion: completion)
    }

    private func request(_ target: InterestAPI, completion: @escaping (NetworkResult<Any>) -> ()) {
        provider.request(target) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let respone):
                let networkResult: NetworkResult<Any> = self.fetchNetworkResult(
                    statusCode: respone.statusCode,
                    data: respone.data
                )
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
