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
    
    // TODO: - 페이징에 필요한 속성들 잠시 주석처리 하겠습니다.
//    @Published var nextCursor: String? = nil
//    @Published var isLoading: Bool = false
//    @Published var hasMorePages: Bool = true
//    @Published var isFiltering: Bool = false
    
    private let pageSize = 15
    
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
    
    func registerPreferGenres() async {
        let genreIds = selectedGenres.map { $0.id }
        let requestDTO = RegisterPreferGenreRequestDTO(genreIds: genreIds)
        
        NetworkService.shared.storeService.postPreferGenre(selectedGenres: requestDTO) { result in
            switch result {
            case .success(let dto):
                if let data = dto {
                    print("[등록된 데이터] \n \(data.jsonString)")
                }
                
            default:
                break
            }
        }
    }
    
    func removeSelection(_ selectedIDs: [Int]) {
        selectedGenres.removeAll { !selectedIDs.contains($0.id) }
    }
    
    
//    func resetSearch() {
//        genres.removeAll()
//        nextCursor = nil
//        hasMorePages = true
//        isFiltering = false
//        isLoading = false
//    }
    
}
