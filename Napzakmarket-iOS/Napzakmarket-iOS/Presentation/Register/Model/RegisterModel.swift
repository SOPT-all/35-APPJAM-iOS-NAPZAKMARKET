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
    
    @Published var compleatedCount: Int = 0
    
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
    
    func registerPresignedRequest() async {
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
        
        for (index, presignedUrl) in presignedUrlList.enumerated() {
            guard let url = presignedUrl.productPresignedUrls.values.first,
                  index < registerInfo.images.count,
                  let imageData = registerInfo.images[index].jpegData(compressionQuality: 0.8) else {
                print("업로드 준비 실패: index \(index)")
                continue
            }
            
            print("이미지 \(index + 1) 업로드 시작")
            
            NetworkService.shared.productService
                .putImageToPresignedUrl(url: url, imageData: imageData) { result in
                    switch result {
                    case .success:
                        if self.presignedUrlList.count == self.registerInfo.images.count {
                            print("이미지 \(index + 1) 업로드 성공")
                        }
                    default:
                        break
                    }
                }
            
        }
        guard self.presignedUrlList.count == self.registerInfo.images.count else {
            print("프리사인드 URL과 이미지 개수가 일치하지 않습니다.")
            return
        }
        self.sellRegisterRequest()
    }
    
    
    // MARK: - Sell Register Post 로직
    
    func simplifyUrl(url: String) -> String? {
        // URL에서 도메인과 중요한 경로만 추출
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        // URL에서 도메인과 경로만 추출
        let simplifiedUrl = "\(urlComponents.scheme ?? "https")://\(urlComponents.host ?? "")\(urlComponents.path)"
        
        return simplifiedUrl
    }
    
    func sellRegisterRequest() {
        var registerPhotoList: [RegisteredPhoto] = []
        
        // uiimage를 RegisteredPhoto 로 변경
        for (index, image) in registerInfo.images.enumerated() {
            if image.jpegData(compressionQuality: 0.8) != nil {
                if let actualUrl = presignedUrlList[index].productPresignedUrls.values.first {
                    if let simplifiedUrl = simplifyUrl(url: actualUrl) {
                        let registeredPhoto = RegisteredPhoto(photoUrl: simplifiedUrl, sequence: index + 1)
                        registerPhotoList.append(registeredPhoto)
                    } else {
                        print("URL 추출 실패: index \(index)")
                    }
                }
            }
        }
        
        var registerProductCondition = ""
        
        switch registerInfo.productState {
        case "미개봉":
            registerProductCondition = "NEW"
        case "아주 좋은 상태":
            registerProductCondition = "LIKE_NEW"
        case "약간의 사용감":
            registerProductCondition = "SLIGHTLY_USED"
        default:
            registerProductCondition = "USED"
        }
        
        let registerItem = RegisterSellProductRequestDTO(
            productPhotoList: registerPhotoList,
            genreId: registerInfo.genreId,
            title: registerInfo.title,
            description: registerInfo.description,
            price: Int(registerInfo.price) ?? 0,
            productCondition: registerProductCondition,
            isDeliveryIncluded: registerInfo.deliveryChargeFree,
            standardDeliveryFee: Int(registerInfo.normalDeliveryCharge) ?? 0,
            halfDeliveryFee: Int(registerInfo.halfDeliveryCharge) ?? 0
        )
        
        NetworkService.shared.productService.postRegisterSellRequest(registerSellProduct: registerItem) { result in
            switch result {
            case .success:
                print("Post 성공!")
            default:
                print("default 가 실행됨")
                print(result) // decodeErr
                break
            }
        }
        
    }
    
    
    
    
}
