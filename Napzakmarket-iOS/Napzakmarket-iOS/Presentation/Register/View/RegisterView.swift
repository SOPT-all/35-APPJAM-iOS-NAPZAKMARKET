//
//  RegisterView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct RegisterView: View {
    @Binding var registerType: Bool
    
    @StateObject private var registerModel = RegisterModel()
    
    var body: some View {
        NavigationStack {
            if registerType {
                RegisterSellHeader()
            } else {
                RegisterBuyHeader()
            }
            
            if registerType {
                SellRegisterView()
            } else {
                BuyRegisterView()
            }
            
            Button(action: {
                print(("tapped button"))
            }, label: {
                Text("등록하기")
                    .font(.napzakFont(.body1Bold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 52)
            })
            .background(
                registerModel.filledRegisterInfo
                ? Color.napzakPurple(.purple30)
                : Color.napzakGrayScale(.gray400)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.bottom, 35)
        }
        .scrollIndicators(.hidden)
    }
}
