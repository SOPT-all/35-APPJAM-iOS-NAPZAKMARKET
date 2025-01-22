//
//  RegisterModel.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/16/25.
//

import SwiftUI
import Moya

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
    
    @Published var presignedUrlList: [ProductPresignedUrlsData] = []
    
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
    
    
    // MARK: - presigned url GET 로직
    
    func registerPresignedRequest() {
        NetworkService.shared.presignedService
            .getPresignedURL(imageNameList: self.imageNameList) { result in
                switch result {
                case .success(let response):
                    guard let response = response else { return }
                    
                    // 딕셔너리 데이터를 productPresignedUrls 배열로 변환
                    let convertedUrls = response.data.productPresignedUrls.map { key, value in
                        ProductPresignedUrlsData(productPresignedUrls: [key: value])
                    }
                    
                    // presignedUrlList에 추가
                    self.presignedUrlList.append(contentsOf: convertedUrls)
                    
                    print("프리사인드 URL 목록의 길이: \(self.presignedUrlList.count)")
                    print("이미지 목록의 길이: \(self.registerInfo.images.count)")
                    print("프리사인드 URL 발급 성공!")
                    
                    self.putImagesToPresignedUrls()
                    
                default:
                    break
                }
            }
    }
    
    
    // MARK: - presigned url에 이미지 업로드 PUT 로직
    
    func putImagesToPresignedUrls() {
        
        guard self.presignedUrlList.count == self.registerInfo.images.count else {
            print("프리사인드 URL과 이미지 개수가 일치하지 않습니다.")
            return
        }
        
        
        for (index, presignedUrl) in presignedUrlList.enumerated() {
            guard let url = presignedUrl.productPresignedUrls.values.first,
                  index < registerInfo.images.count,
                  let imageData = registerInfo.images[index].jpegData(compressionQuality: 0.8) else {
                continue
            }
            
            NetworkService.shared.productService
                .putImageToPresignedUrl(url: url, imageData: imageData) { result in
                    switch result {
                    case .success:
                        print("이미지 \(index + 1) 업로드 성공")
                    default:
                        print("지금 이건 디폴트 값이야")
                    }
                    
                }
            
            print("과정이 안 끝난건가?")
        }
        
        print("모든 이미지 업로드 작업 완료")
    }
    
    
    
    // MARK: - 장르 검색 RESPONSE GET 로직
    
    
    
    
}
