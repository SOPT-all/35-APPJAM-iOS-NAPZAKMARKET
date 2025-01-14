//
//  RegisterView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct RegisterView: View {
    // 뷰 불러올 때 Sell 이냐 Buy냐로 구분해서 보여주면 될 듯 나중에 탭바에서 Boolean값으로 바인딩 받아오기
    private var RegisterType = "Sell"
    
    var body: some View {
        NavigationStack {
            if RegisterType == "Sell" {
                RegisterSellHeader()
            } else {
                RegisterBuyHeader()
            }
            
            if RegisterType == "Sell" {
                SellRegisterView()
            } else {
                BuyRegisterView()
            }
            
            Button(action: {
                print(("tapped button"))
            }, label: {
                Text("등록하기")
            })
            .frame(maxWidth: .infinity, minHeight: 52)
            .font(.napzakFont(.body1Bold16))
            .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
            .foregroundStyle(.white)
            .background(Color.napzakGrayScale(.gray400))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.vertical, 1)
        }
        .scrollIndicators(.hidden)
    }
}
