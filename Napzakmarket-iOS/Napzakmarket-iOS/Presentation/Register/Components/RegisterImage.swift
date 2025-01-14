//
//  RegisterImage.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterImage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("상품 이미지")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            Text("다양한 상품 이미지를 등록하면 판매 확률이 올라가요!")
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray600))
            
            Button {
                print("버튼 눌림")
            } label: {
                VStack(alignment: .center){
                    Image(.icPhoto)
                    Text("0/10")
                }
            }
            .frame(width: 80, height: 80)
            .font(.napzakFont(.caption2SemiBold12))
            .applyNapzakTextStyle(napzakFontStyle: .caption2SemiBold12)
            .background(Color.napzakGrayScale(.gray100))
            .foregroundStyle(Color.napzakGrayScale(.gray500))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.top, 12)
        }
        .padding(20)
        
        
    }
}
