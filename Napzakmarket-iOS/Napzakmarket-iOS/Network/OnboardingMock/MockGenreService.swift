//
//  MockGenreService.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/11/25.
//

import Foundation

final class MockGenreService {
    
    // MARK: - Properties
    
    static let shared = MockGenreService()
    
    private init() {}
    
    // MARK: - Func
    
    func fetchGenres() async throws -> [Genre] {
        guard let url = Bundle.main.url(forResource: "mock_genres_39", withExtension: "json") else {
            throw MockGenreError.fileNotFound
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response: APIResponse<GenreResponse>
        
        do {
            response = try decoder.decode(APIResponse<GenreResponse>.self, from: data)
        } catch {
            throw MockGenreError.decodingFailed
        }
        
        guard let genres = response.data?.genres else {
            throw MockGenreError.emptyData
        }
        
        return genres
    }
    
    func fetchGenresFiltered(by query: String) async throws -> [Genre] {
        let allGenres = try await fetchGenres()
        
        guard !query.isEmpty else {
            return allGenres
        }
        
        let filteredGenres = allGenres.filter { genre in
            genre.name.localizedCaseInsensitiveContains(query)
        }
        
        print("검색어: \(query), 검색 결과: \(filteredGenres.count)개")
        return filteredGenres
    }
    
}
