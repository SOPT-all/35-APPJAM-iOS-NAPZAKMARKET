//
//  RegisterHeaderView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterSellHeader: View {
    var body: some View {
        HStack{
            Button {
                print("뒤로가기 버튼")
            } label: {
                Image(systemName: "multiply")
            }
            .foregroundStyle(.black)
            
            Spacer()
            Text("팔아요 등록")
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

