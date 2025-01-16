//
//  RegisterModel.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/16/25.
//

import SwiftUI

final class RegisterModel: ObservableObject {
    @Published var images: [UIImage] = []
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var genre: String = ""
    @Published var productState: String = ""
    @Published var price: String = ""
    @Published var deliveryChargeFree: Bool = true
    @Published var normalDelivery: Bool = false
    @Published var normalDeliveryCharge: String = ""
    @Published var halfDelivery: Bool = false
    @Published var halfDeliveryCharge: String = ""
    @Published var suggestPrice: Bool = false
    
    // MARK: - 유효성 검사 및 버튼 활성화 로직
    
    func sellValidate() -> Bool {
        return !images.isEmpty &&
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespaces).isEmpty &&
        !genre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !productState.trimmingCharacters(in: .whitespaces).isEmpty &&
        !price.trimmingCharacters(in: .whitespaces).isEmpty &&
        (deliveryChargeFree || !normalDeliveryCharge.isEmpty || !halfDeliveryCharge.isEmpty)
    }
    
    func buyValidate() -> Bool {
        return !images.isEmpty &&
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespaces).isEmpty &&
        !genre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !price.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    // MARK: - 등록정보 REQUEST POST 로직
    
    
    // MARK: - 장르 검색 RESPONSE GET 로직
    
    
    
}
