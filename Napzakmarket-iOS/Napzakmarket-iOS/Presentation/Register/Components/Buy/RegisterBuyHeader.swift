//
//  RegisterBuyHeader.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct RegisterBuyHeader: View {
    var body: some View {
        HStack{
            Button {
                print("뒤로가기 버튼")
            } label: {
                Image(systemName: "xmark")
            }
            .frame(width: 24, height: 24)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            Spacer()
            
            Text("구해요 등록")
                .font(.napzakFont(.title5SemiBold18))
                .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
        Divider()
    }
}
