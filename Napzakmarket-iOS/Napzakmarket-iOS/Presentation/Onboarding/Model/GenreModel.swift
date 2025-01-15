//
//  GenreModel.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/12/25.
//

import Foundation

@MainActor
final class GenreModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var genres: [Genre] = []
    @Published var selectedGenres: [Genre] = []
    @Published var searchText: String = ""
    
    private let service: MockGenreService
    
    init(service: MockGenreService = .shared) {
        self.service = service
    }
    
    // MARK: - Func
    
    func fetchGenres() async throws {
        do {
            genres = try await service.fetchGenres()
            print("가져온 장르 데이터: \(genres)")
        } catch {
            print("Error fetching genres: \(error.localizedDescription)")
        }
    }
    
    func fetchGenresFiltered() async throws {
        self.genres = try await service.fetchGenresFiltered(by: searchText)
    }
    
    func removeSelection(_ newNames: [String] ) {
        selectedGenres.removeAll { !newNames.contains($0.name) }
    }
    
}
