//
//  RegisterProductState.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterProductState: View {
    @Binding var productState: String
    
    // 물건 상태
    private let options = ["미개봉", "아주 좋은 상태", "약간의 사용감", "사용감 있음"]
    
    var body: some View {
        VStack(alignment: .leading) {
            titleSection
            optionSection
        }
    }
}

// MARK: - Subviews

extension RegisterProductState {
    
    private var titleSection: some View {
        Text("상품 상태")
            .font(.napzakFont(.body2SemiBold16))
            .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .padding(.bottom, 12)
    }
    
    private var optionSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
            ForEach(options, id: \.self) { option in
                Button {
                    productState = option
                } label: {
                    Text(option)
                        .font(.napzakFont(.body6Medium14))
                        .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .foregroundColor(
                            productState == option ? .white : Color
                                .napzakGrayScale(.gray900)
                        )
                        .background(productState == option ? Color
                            .napzakGrayScale(.gray900) : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    Color.napzakGrayScale(.gray200),
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
    }
    
}
