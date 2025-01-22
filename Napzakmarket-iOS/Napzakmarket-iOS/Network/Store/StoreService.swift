//
//  StoreService.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Foundation
import Moya

protocol StoreServiceProtocol {
    func getmypageInfo(completion: @escaping (NetworkResult<MyPageInfoResponseDTO>) -> ())
}

final class StoreService: BaseService, StoreServiceProtocol {
    let provider = MoyaProvider<StoreAPI>()
    
    func getmypageInfo(completion: @escaping (NetworkResult<MyPageInfoResponseDTO>) -> ()) {
        provider.request(.getmypageInfo) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<MyPageInfoResponseDTO> = self.fetchNetworkResult(
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
