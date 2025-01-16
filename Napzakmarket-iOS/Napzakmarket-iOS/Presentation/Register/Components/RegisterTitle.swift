//
//  RegisterTitle.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterTitle: View {
    @Binding var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("제목")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 12)
            
            TextField("제목을 적어주세요.", text: $title)
                .maxLength(50, text: $title)
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
                .frame(height: 42)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
                }
            
            HStack(spacing: 0) {
                Spacer()
                Text(title.count.description)
                    .foregroundStyle(title.count == 0 ? Color.napzakGrayScale(.gray400) : Color.napzakGrayScale(.gray900))
                
                Text("/50")
                    .foregroundStyle(Color.napzakGrayScale(.gray400))
            }
            .font(.napzakFont(.caption3Medium12))
            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
            .padding(.top, 4)
            
        }
        
    }
}
