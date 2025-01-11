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
            Text("상품 상태")
                .padding(.bottom, 12)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Button {
                        productState = option
                    } label: {
                        Text(option)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .foregroundColor(productState == option ? .white : .black)
                            .background(productState == option ? .black : .white)
                            .clipShape(.rect(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray, lineWidth: 1))
                        
                    }
                }
            }
            
        }
        .padding(.horizontal, 20)
    }
}

