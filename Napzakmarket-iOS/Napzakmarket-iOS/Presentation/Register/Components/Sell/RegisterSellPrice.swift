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
            titleSection
            inputPriceSection
        }
    }
}

// MARK: - Subviews

extension RegisterSellPrice {
    
    private var titleSection : some View {
        Text("가격")
            .font(.napzakFont(.body2SemiBold16))
            .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .padding(.bottom, 12)
    }
    
    private var inputPriceSection: some View {
        HStack(alignment: .center, spacing: 2){
            TextField("0", text: $price)
                .keyboardType(.decimalPad)
                .font(.napzakFont(.body3Medium16))
                .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .onChange(of: price) { newValue in
                    price = newValue.convertPrice(maxPrice: maxPrice)
                }
            
            Text("원")
                .font(.napzakFont(.body3Medium16))
                .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                .foregroundStyle(Color.napzakGrayScale(.gray600))
        }
        .frame(height: 22)
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
        }
    }
}
