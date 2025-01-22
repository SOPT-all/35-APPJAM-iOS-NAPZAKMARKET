//
//  PresignedService.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/22/25.
//

import Moya

protocol PresignedServiceProtocol {
    func getPresignedURL(imageNameList: [String], completion: @escaping (NetworkResult<PresignedResponseDTO>) -> ())
}

final class PresignedService: BaseService, PresignedServiceProtocol {
    
    let provider = MoyaProvider<PresignedAPI>.init(plugins: [MoyaPlugin()])

    func getPresignedURL(imageNameList: [String], completion: @escaping (NetworkResult<PresignedResponseDTO>) -> ()) {
        provider.request(.getPresignedURL(imageNameList: imageNameList)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PresignedResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )

                print("[networkResult] : \(networkResult)")
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
}
