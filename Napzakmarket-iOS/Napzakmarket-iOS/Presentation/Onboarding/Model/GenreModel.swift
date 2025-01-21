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
    
    @Published var genres: [PreferGenre] = []
    @Published var selectedGenres: [PreferGenre] = []
    @Published var searchText: String = ""
    
    // MARK: - Func
    
    func fetchGenres() async {
        NetworkService.shared.genreService.getAllPreferGenre { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.genres = data.genreList
                }
                
            default:
                break
            }
        }
    }
    
    func fetchGenresFiltered() async {
        guard !searchText.isEmpty else {
            await fetchGenres()
            return
        }
        
        NetworkService.shared.genreService.getSearchPreferGenre(searchWord: searchText) { [weak self] result in
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.genres = data.genreList
                }
                
            default:
                break
            }
        }
    }
    
    func removeSelection(_ selectedIDs: [Int]) {
        selectedGenres.removeAll { !selectedIDs.contains($0.id) }
    }
    
}
