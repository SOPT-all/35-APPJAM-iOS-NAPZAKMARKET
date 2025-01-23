//
//  RegisterView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

enum RegisterType: String {
    case sell
    case buy
    
    var displayName: String {
        switch self {
        case .sell: return "팔아요"
        case .buy: return "구해요"
        }
    }
}

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss

    var registerType: RegisterType
    @StateObject private var registerModel = RegisterModel()
        
    var body: some View {
        NavigationStack {
            switch registerType {
            case .sell:
                RegisterSellHeader()
                SellRegisterView(registerModel: registerModel)
            case .buy:
                RegisterBuyHeader()
                BuyRegisterView(registerModel: registerModel)
            }
            
            registerButton
        }
        .scrollIndicators(.hidden)
    }
}

extension RegisterView {
    
    private var registerButton: some View {
        Button(action: {
            print("등록 버튼 클릭")
            print("--------------------------------------------------------------------")
            
            Task {
                switch registerType {
                case .sell:
                    if registerModel.baseValidate() && registerModel.sellValidate() {
                        await registerModel.registerPresignedRequest(registerType: registerType)
                        print("registerPresignedRequest 완료")
                        dismiss()
                    } else {
                        print("유효성 검증 실패")
                    }
                 case .buy:
                     if registerModel.baseValidate() {
                         await registerModel.registerPresignedRequest(registerType: registerType)
                         print("registerPresignedRequest 완료")
                         dismiss()
                     } else {
                         print("유효성 검증 실패")
                     }
                }
            }
                                    
        }) {
            Text("등록하기")
                .font(.napzakFont(.body1Bold16))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
        }
        .background(content: {
            switch registerType {
            case .sell:
                registerModel.baseValidate() && registerModel.sellValidate()
                ? Color.napzakPurple(.purple30)
                : Color.napzakGrayScale(.gray400)
            case .buy:
                registerModel.baseValidate()
                ? Color.napzakPurple(.purple30)
                : Color.napzakGrayScale(.gray400)
            }
        })
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.bottom, 35)
        .padding(.top, 20)
    }
}
