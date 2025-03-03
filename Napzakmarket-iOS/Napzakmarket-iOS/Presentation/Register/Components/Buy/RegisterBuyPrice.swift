//
//  RegisterBuyPrice.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/14/25.
//

import SwiftUI

struct RegisterBuyPrice: View {
    @Binding var price: String
    @Binding var suggestPrice: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleSection
            descriptionSection
            priceSection
            suggestPriceSection
        }
    }
}

// MARK: - Subviews

extension RegisterBuyPrice {
    
    private var titleSection: some View {
        Text("가격")
            .font(.napzakFont(.body2SemiBold16))
            .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .padding(.bottom, 4)
    }
        
    private var descriptionSection: some View {
        Text("구하려는 상품 가격 범위는 1,000원대부터 입력 가능해요.")
            .font(.napzakFont(.body6Medium14))
            .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
            .foregroundStyle(Color.napzakGrayScale(.gray600))
            .padding(.bottom, 24)
    }
        
    private var priceSection: some View {
        HStack(spacing: 2) {
            VStack(spacing: 0){
                Spacer()
                
                TextField("000", text: $price)
                    .maxLength(3, text: $price)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .font(.napzakFont(.body3Medium16))
                    .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .onChange(of: price) { newValue in
                        if price == "0" {
                            price = ""
                        }
                    }
                
                Spacer()
                
                Divider()
                    .frame(height: 1)
                    .foregroundStyle(Color.napzakGrayScale(.gray300))
            }

            Text(",000원대")
                .multilineTextAlignment(TextAlignment.trailing)
                .font(.napzakFont(.body3Medium16))
                .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
        }
        .frame(width: 152, height: 30)
        .padding(.bottom, 20)
    }
    
    private var suggestPriceSection: some View {
        HStack(spacing: 8) {
            Button {
                suggestPrice.toggle()
            } label: {
                Image(suggestPrice ? .icCheckboxSelected : .icCheckbox)
            }

            Text("가격 제시")
                .font(.napzakFont(.body5SemiBold14))
                .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                .foregroundStyle(Color.napzakGrayScale(.gray700))
        }
    }
}
