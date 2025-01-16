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
    @State var filledRegisterInfo: Bool = false     // 변수명 뭔가뭔가임... 흠
    @State var registerInfo = RegisterInfo()
    
    // MARK: - 유효성 검사 및 버튼 활성화 로직
    
    
    
    // MARK: - 등록정보 REQUEST POST 로직
    
    
    // MARK: - 장르 검색 RESPONSE GET 로직
    
    
    
}
