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
    @Published var nextCursor: String? = nil
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true
    @Published var isFiltering: Bool = false
    
    private let pageSize = 15
    
    // MARK: - Func
    
    func fetchGenres(initialLoad: Bool = false) async {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        
        if initialLoad {
            resetSearch()
        }
        
        NetworkService.shared.genreService.getAllPreferGenre(
            size: pageSize,
            cursor: nextCursor
        ) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.genres.append(contentsOf: data.genreList)
                    self?.nextCursor = data.nextCursor
                    
                    if data.nextCursor == nil {
                        self?.hasMorePages = false
                    }
                }
                
            default:
                break
            }
        }
    }
    
    func fetchGenresFiltered(initialLoad: Bool = false) async {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        
        if initialLoad {
            resetSearch()
            isFiltering = true
        }
        
        NetworkService.shared.genreService.getSearchPreferGenre(
            size: pageSize,
            cursor: nextCursor,
            searchWord: searchText
        ) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let dto):
                if let data = dto?.data {
                    self?.genres.append(contentsOf: data.genreList)
                    self?.nextCursor = data.nextCursor
                    
                    if data.nextCursor == nil {
                        self?.hasMorePages = false
                    }
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
    
    func resetSearch() {
        genres.removeAll()
        nextCursor = nil
        hasMorePages = true
        isFiltering = false
        isLoading = false
    }
    
}
