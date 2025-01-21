//
//  GenreService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Moya

protocol GenreServiceProtocol {
    func getAllPreferGenre(completion: @escaping (NetworkResult<PreferGenreResponseDTO>) -> ())
    func getSearchPreferGenre(searchWord: String, completion: @escaping(NetworkResult<PreferGenreResponseDTO>) -> ())
    func getAllGenreName(completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
    func getSearchGenreName(searchWord: String, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ())
}

final class GenreService: BaseService, GenreServiceProtocol {
    
    private let provider = MoyaProvider<GenreAPI>.init(plugins: [MoyaPlugin()])
    
    func getAllPreferGenre(completion: @escaping (NetworkResult<PreferGenreResponseDTO>) -> ()) {
        request(.getAllPreferGenre, completion: completion)
    }
    
    func getSearchPreferGenre(searchWord: String, completion: @escaping (NetworkResult<PreferGenreResponseDTO>) -> ()) {
        request(.getSearchPreferGenre(searchWord: searchWord), completion: completion)
    }
    
    func getAllGenreName(completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        request(.getAllGenreName, completion: completion)
    }
    
    func getSearchGenreName(searchWord: String, completion: @escaping (NetworkResult<GenreNameResponseDTO>) -> ()) {
        request(.getSearchGenreName(searchWord: searchWord), completion: completion)
    }
    
    private func request<T: Decodable>(_ target: GenreAPI, completion: @escaping (NetworkResult<T>) -> ()) {
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
