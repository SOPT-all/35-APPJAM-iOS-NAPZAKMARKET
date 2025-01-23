//
//  StoreService.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/21/25.
//

import Moya

protocol StoreServiceProtocol {
    func postPreferGenre(selectedGenres: RegisterPreferGenreRequestDTO, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
    func getMyPageInfo(completion: @escaping (NetworkResult<MyPageInfoResponseDTO>) -> ())
    func getStoreInfo(storeId: Int, completion: @escaping (NetworkResult<StoreInfoResponseDTO>) -> ())
}

final class StoreService: BaseService, StoreServiceProtocol {
    
    private let provider = MoyaProvider<StoreAPI>.init(plugins: [MoyaPlugin()])
    
    func postPreferGenre(selectedGenres: RegisterPreferGenreRequestDTO, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        request(.postPreferGenres(request: selectedGenres), completion: completion)
    }
    
    func getMyPageInfo(completion: @escaping (NetworkResult<MyPageInfoResponseDTO>) -> ()) {
        request(.getMyPageInfo, completion: completion)
    }
    
    func getStoreInfo(storeId: Int, completion: @escaping (NetworkResult<StoreInfoResponseDTO>) -> ()) {
        request(.getStoreInfo(storeId: storeId), completion: completion)
    }
    
    private func request<T: Decodable>(_ target: StoreAPI, completion: @escaping (NetworkResult<T>) -> ()) {
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
