//
//  GenreService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

protocol GenreServiceProtocol {
    func getAllGenreName(completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
    func getSearchGenreName(searchWord: String, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
}

final class GenreService: BaseService, GenreServiceProtocol {
    
    let provider = MoyaProvider<GenreAPI>.init(plugins: [MoyaPlugin()])
    
    func getAllGenreName(completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        provider.request(.getAllGenreName) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GenreNameResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getSearchGenreName(searchWord: String,completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        provider.request(.getSearchGenreName(searchWord: searchWord)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GenreNameResponseDTO> = self.fetchNetworkResult(
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
