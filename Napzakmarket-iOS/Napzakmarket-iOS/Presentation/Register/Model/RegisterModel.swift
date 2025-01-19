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

    
    
    // MARK: - 등록정보 REQUEST POST 로직
    
    
    // MARK: - 장르 검색 RESPONSE GET 로직
    
    
    
}
