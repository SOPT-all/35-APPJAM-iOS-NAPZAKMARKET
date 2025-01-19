//
//  GenreSearchModel.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/16/25.
//

struct GenreSearchModel: Equatable {
    let genreId: Int
    let genreName: String
}

extension GenreSearchModel {

    //MARK: - Dummy Model List

    static let genreDummyList = [
        GenreSearchModel(genreId: 0, genreName: "산리오"),
        GenreSearchModel(genreId: 1, genreName: "은혼"),
        GenreSearchModel(genreId: 2, genreName: "주술회전"),
        GenreSearchModel(genreId: 3, genreName: "디즈니/픽사"),
        GenreSearchModel(genreId: 4, genreName: "원피스"),
        GenreSearchModel(genreId: 5, genreName: "레고"),
        GenreSearchModel(genreId: 6, genreName: "건담"),
        GenreSearchModel(genreId: 7, genreName: "귀멸의 칼날"),
        GenreSearchModel(genreId: 8, genreName: "나루토"),
        GenreSearchModel(genreId: 9, genreName: "나의 히어로 아카데미아"),
        GenreSearchModel(genreId: 10, genreName: "도쿄 리벤저스"),
        GenreSearchModel(genreId: 11, genreName: "드래곤볼"),
        GenreSearchModel(genreId: 12, genreName: "리락쿠마"),
        GenreSearchModel(genreId: 13, genreName: "마블"),
        GenreSearchModel(genreId: 14, genreName: "명탐정 코난"),
        GenreSearchModel(genreId: 15, genreName: "버추얼"),
        GenreSearchModel(genreId: 16, genreName: "보컬로이드"),
        GenreSearchModel(genreId: 17, genreName: "브라이스"),
        GenreSearchModel(genreId: 18, genreName: "블루아카이브"),
        GenreSearchModel(genreId: 19, genreName: "사카모토 데이즈"),
        GenreSearchModel(genreId: 20, genreName: "슈가슈가룬"),
        GenreSearchModel(genreId: 21, genreName: "스파이 패밀리"),
        GenreSearchModel(genreId: 22, genreName: "슬램덩크"),
        GenreSearchModel(genreId: 23, genreName: "실바니안"),
        GenreSearchModel(genreId: 24, genreName: "앙상블스타즈"),
        GenreSearchModel(genreId: 25, genreName: "에반게리온"),
        GenreSearchModel(genreId: 26, genreName: "원신"),
        GenreSearchModel(genreId: 27, genreName: "지브리 스튜디오"),
        GenreSearchModel(genreId: 28, genreName: "진격의 거인"),
        GenreSearchModel(genreId: 29, genreName: "짱구는 못말려"),
        GenreSearchModel(genreId: 30, genreName: "치이카와"),
        GenreSearchModel(genreId: 31, genreName: "캐릭캐릭체인지"),
        GenreSearchModel(genreId: 32, genreName: "팝마트"),
        GenreSearchModel(genreId: 33, genreName: "페이트"),
        GenreSearchModel(genreId: 34, genreName: "포켓몬스터"),
        GenreSearchModel(genreId: 35, genreName: "프로젝트 세카이"),
        GenreSearchModel(genreId: 36, genreName: "하이큐"),
        GenreSearchModel(genreId: 37, genreName: "헌터x헌터"),
        GenreSearchModel(genreId: 38, genreName: "넨도로이드"),
        GenreSearchModel(genreId: 39, genreName: "인형"),
        GenreSearchModel(genreId: 40, genreName: "피규어"),
        GenreSearchModel(genreId: 41, genreName: "기타 장르")
    ]
}
