//
//  RegisterModel.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/16/25.
//

import SwiftUI

struct RegisterInfo {
    // 공통 데이터
    var images: [UIImage] = []
    var title: String = ""
    var description: String = ""
    var genre: String = ""
    var genreId: Int = 0
    var price: String = ""
    
    // 판매 등록글 사용 데이터
    var productState: String = ""
    var deliveryChargeFree: Bool = true             // 배달비 여부
    var normalDelivery: Bool = false                // 일반 배달비 선택 여부
    var normalDeliveryCharge: String = ""           // 일반 배달비 금액
    var halfDelivery: Bool = false                  // 알뜰,반값 배달비 선택 여부
    var halfDeliveryCharge: String = ""             // 알뜰,반값 배달비 금액
    
    // 구매 등록글 사용 데이터
    var suggestPrice: Bool = false
}

final class RegisterModel: ObservableObject {
    @Published var registerInfo = RegisterInfo()
    
    @Published var imageNameList: [String] = []

    @Published var presignedUrlList: [productPresignedUrls] = []
    
    // MARK: - 유효성 검사 및 버튼 활성화 로직
    
    // 팔아요, 구해요 상관없이 기본적인 등록 과정의 검증
    func baseValidate() -> Bool {
        return !registerInfo.images.isEmpty &&
        !registerInfo.title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.description.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.genre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.price.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // 팔아요 등록 과정의 검증
    func sellValidate() -> Bool {
        return !registerInfo.productState.trimmingCharacters(in: .whitespaces).isEmpty &&
        (registerInfo.deliveryChargeFree ||
         !registerInfo.normalDeliveryCharge.isEmpty ||
         !registerInfo.halfDeliveryCharge.isEmpty)
    }

    
    // MARK: - presigned url 요청 로직
    
    func registerPresignedRequest() async {
        NetworkService.shared.presignedService
            .getPresignedURL(imageNameList: self.imageNameList) { result in
                switch result {
                case .success(let response):
                    guard let response = response else { return }
                    
                    // 딕셔너리 데이터를 productPresignedUrls 배열로 변환
                    let convertedUrls = response.data.presignedURL.map { key, value in
                         productPresignedUrls(presignedURL: [key: value])
                     }
                     
                     // presignedUrlList에 추가
                     self.presignedUrlList.append(contentsOf: convertedUrls)
                    
                    print("프리사인드 URL 발급 성공!")
                    print(self.presignedUrlList)
                default:
                    break
                }
            }
    }
    
    
    // MARK: - 장르 검색 RESPONSE GET 로직

    
    
    
}
