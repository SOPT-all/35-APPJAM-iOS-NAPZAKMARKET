//
//  RegisterSellPrice.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterSellPrice: View {
    @Binding var price: String
    
    private let maxPrice: Int = 1_000_000       // 최대 금액 100만원
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("가격")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 12)
            
            HStack(alignment: .center, spacing: 2){
                TextField("0", text: $price)
                    .keyboardType(.numberPad)
                    .font(.napzakFont(.body3Medium16))
                    .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .onChange(of: price) { oldValue, newValue in
                        price = convertPrice(input: newValue)
                    }
                
                Text("원")
                    .font(.napzakFont(.body3Medium16))
                    .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                    .foregroundStyle(Color.napzakGrayScale(.gray600))
            }
            .frame(minWidth: 291)
            .frame(height: 22)
            .padding(.horizontal, 14)
            .padding(.vertical, 11)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
            }
            
        }
        .padding(.bottom, 35)
        .padding(.horizontal, 20)
    }
}

extension RegisterSellPrice {
    // MARK: - 문자열을 금액 형태로 바꿔주는 함수
    private func convertPrice(input: String) -> String {
        // 숫자만 남기기
        let filteredPrice = input.filter { $0.isNumber }
        guard let price = Int(filteredPrice) else { return "" }
        
        // 최대 금액 제한
        let limitedPrice = min(price, maxPrice)
        
        // 숫자를 3자리마다 쉼표로 구분
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: limitedPrice as NSNumber) ?? ""
    }
}

#Preview {
    RegisterView()
}
