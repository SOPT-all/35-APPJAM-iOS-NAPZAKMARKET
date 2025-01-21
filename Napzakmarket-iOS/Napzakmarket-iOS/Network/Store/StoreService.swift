//
//  StoreService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

protocol StoreServiceProtocol {
    func postPreferGenre(selectedGenres: RegisterPreferGenreRequestDTO, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
}

final class StoreService: BaseService, StoreServiceProtocol {
    
    private let provider = MoyaProvider<StoreAPI>.init(plugins: [MoyaPlugin()])
    
    func postPreferGenre(selectedGenres: RegisterPreferGenreRequestDTO, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        request(.postPreferGenres(request: selectedGenres), completion: completion)
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
