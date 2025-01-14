//
//  RegisterDescription.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterDescription: View {
    @Binding var description: String
    
    private let descriptionPlaceholder = "자세히 작성하면 더 빠르고 원활한 거래를 할 수 있어요."
    + "\n예) 출시 연도, 사이즈, 한정판 여부, 네고 여부 등"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("설명")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 12)
            
            ZStack(alignment: .topLeading){
                TextEditor(text: $description)
                    .maxLength(250, text: $description)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                
                if description.isEmpty {
                    Text(descriptionPlaceholder)
                        .foregroundStyle(Color.napzakGrayScale(.gray400))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 11)
                }
            }
            .font(.napzakFont(.body6Medium14))
            .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
            .frame(height: 182)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
            }
            
            HStack(spacing: 0) {
                Spacer()
                Text(description.count.description)
                    .foregroundStyle(description.count == 0
                                     ? Color.napzakGrayScale(.gray400)
                                     : Color.napzakGrayScale(.gray900))
                
                Text("/250")
                    .foregroundStyle(Color.napzakGrayScale(.gray400))
            }
            .font(.napzakFont(.caption3Medium12))
            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
            .padding(.top, 4)
            
        }
        .padding(.bottom, 35)
        .padding(.horizontal, 20)
    }
}
