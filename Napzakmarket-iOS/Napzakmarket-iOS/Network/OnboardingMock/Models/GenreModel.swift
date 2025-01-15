enum GenreModelError: Error {
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .custom(let message):
            return message
        }
    }
}

@MainActor
final class GenreModel: ObservableObject {
    @Published var genres: [Genre] = []
    
    private let manager: MockGenreManager
    
    init(manager: MockGenreManager = .shared) {
        self.manager = manager
    }
    
    func fetchGenres() async throws {
        do {
            self.genres = try await manager.fetchGenres()
        } catch MockGenreError.fileNotFound {
            throw GenreModelError.custom("장르 데이터 파일을 찾을 수 없습니다.")
        } catch MockGenreError.decodingFailed {
            throw GenreModelError.custom("장르 데이터 디코딩에 실패했습니다.")
        } catch MockGenreError.emptyData {
            throw GenreModelError.custom("장르 데이터가 비어있습니다.")
        } catch {
            throw GenreModelError.custom("알 수 없는 오류가 발생했습니다.")
        }
    }
    
    // 장르 정렬 (이름순)
    func sortByName() {
        genres.sort { $0.name < $1.name }
    }
    
    // 장르 정렬 (ID순)
    func sortById() {
        genres.sort { $0.id < $1.id }
    }
    
    // 장르 필터링 (이름으로 검색)
    func filterByName(_ query: String) {
        guard !query.isEmpty else {
            // 검색어가 비어있으면 원래 데이터로 복구
            Task {
                try? await fetchGenres()
            }
            return
        }
        
        genres = genres.filter { $0.name.contains(query) }
    }
}