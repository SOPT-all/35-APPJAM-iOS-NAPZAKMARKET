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
    @Published var registerType: RegisterType = .sell
    @Published var productId: Int?
    @Published var completeUploading: Bool = false
        
    // MARK: - 유효성 검사 및 버튼 활성화 로직
    
    // 팔아요, 구해요 상관없이 기본적인 등록 과정의 검증
    func baseValidate() -> Bool {
        return !registerInfo.images.isEmpty &&
        !registerInfo.title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.description.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.genre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !registerInfo.price.trimmingCharacters(in: .whitespaces).isEmpty && Int(registerInfo.price) != 0
    }
    
    // 팔아요 등록 과정의 검증
    func sellValidate() -> Bool {
        return !registerInfo.productState.trimmingCharacters(in: .whitespaces).isEmpty &&
        (registerInfo.deliveryChargeFree ||
         !registerInfo.normalDeliveryCharge.isEmpty ||
         !registerInfo.halfDeliveryCharge.isEmpty)
    }
    
    
    // MARK: - presigned url GET 로직
    
    func registerPresignedRequest(registerType: RegisterType) async {
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
                    
                    print("프리사인드 URL 발급 성공!")
                    
                    self.putImagesToPresignedUrls(registerType: registerType)
                    
                default:
                    break
                }
            }
    }
    
    
    // MARK: - presigned url에 이미지 업로드 PUT 로직
    
    func putImagesToPresignedUrls(registerType: RegisterType) {
        
        let group = DispatchGroup()
        var uploadSuccess = true
        
        func compressImage(_ image: UIImage) -> Data? {
            let maxSize: CGFloat = 1024
            let scale = max(maxSize/image.size.width, maxSize/image.size.height)
            
            if scale < 1 {
                let newSize = CGSize(width: image.size.width * scale,
                                     height: image.size.height * scale)
                UIGraphicsBeginImageContext(newSize)
                image.draw(in: CGRect(origin: .zero, size: newSize))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return resizedImage?.jpegData(compressionQuality: 0.5)
            }
            
            return image.jpegData(compressionQuality: 0.5)
        }
        
        for (index, presignedUrl) in presignedUrlList.enumerated() {
            guard let url = presignedUrl.productPresignedUrls.values.first,
                  index < registerInfo.images.count,
                  let imageData = compressImage(registerInfo.images[index]) else {
                print("업로드 준비 실패: index \(index)")
                continue
            }
            
            group.enter()
            print("이미지 \(index + 1) 업로드 시작")
            
            NetworkService.shared.presignedService
                .putImageToPresignedUrl(url: url, imageData: imageData) { result in
                    switch result {
                    case .success:
                        print("이미지 \(index + 1) 업로드 성공")
                    default:
                        uploadSuccess = false
                        print("이미지 \(index + 1) 업로드 실패")
                    }
                    group.leave()
                }
        }
        
        guard self.presignedUrlList.count == self.registerInfo.images.count else {
            print("프리사인드 URL과 이미지 개수가 일치하지 않습니다.")
            return
        }
        
        group.notify(queue: .main) {
            guard uploadSuccess else {
                print("일부 이미지 업로드 실패")
                return
            }
            
            switch registerType {
            case .sell:
                self.sellRegisterRequest()
            case .buy:
                self.buyRegisterRequest()
            }
        }
        
    }
    
    
    // MARK: - url 필요한 부분만 추출하는 로직
    
    func simplifyUrl(url: String) -> String? {
        // URL에서 ? 이전의 도메인과 경로만 추출
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        // URL의 도메인과 경로 구성
        var simplifiedUrl = "\(urlComponents.scheme ?? "https")://\(urlComponents.host ?? "")\(urlComponents.path)"
        
        // ? 이후의 쿼리 문자열 제거
        if let queryIndex = simplifiedUrl.firstIndex(of: "?") {
            simplifiedUrl = String(simplifiedUrl[..<queryIndex])
        }
        
        return simplifiedUrl
    }
    
    
    // MARK: - Sell Register Post 로직

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
            price: registerInfo.price.convertInt(),
            productCondition: registerProductCondition,
            isDeliveryIncluded: registerInfo.deliveryChargeFree,
            standardDeliveryFee: registerInfo.normalDeliveryCharge.convertInt(),
            halfDeliveryFee: registerInfo.halfDeliveryCharge.convertInt()
        )
        
        NetworkService.shared.productService.postRegisterSellRequest(registerSellProduct: registerItem) { result in
            switch result {
            case .success(let response):
                self.productId = response?.data.productId
                self.completeUploading = true
                print("업로드 상태 : \(self.completeUploading)")
                print("Post 성공!")
            default:
                break
            }
        }
    }
    
    
    // MARK: - Sell Register Post 로직
    
    func buyRegisterRequest() {
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
        
        let registerItem = RegisterBuyProductRequestDTO(
            productPhotoList: registerPhotoList,
            genreId: registerInfo.genreId,
            title: registerInfo.title,
            description: registerInfo.description,
            price: "\(registerInfo.price)000".convertInt(),
            isPriceNegotiable: registerInfo.suggestPrice
        )
        
        NetworkService.shared.productService.postRegisterBuyRequest(registerBuyProduct: registerItem) { result in
            switch result {
            case .success(let response):
                self.productId = response?.data.productId
                self.completeUploading = true
                print("Post 성공!")
            default:
                break
            }
        }
        
    }
    
}
