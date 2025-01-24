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
    @StateObject var registerModel: RegisterModel = RegisterModel()
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    var registerType: RegisterType
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
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
                
                if isLoading {
                    Color.black.opacity(0.4) // 반투명 배경
                        .ignoresSafeArea()
                    ProgressView() // 로딩 인디케이터
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }
            }
            .navigationDestination(isPresented: $registerModel.completeUploading) {
                ProductDetailView(isChangedInterest: .constant(nil), productId: registerModel.productId ?? 1)
            }
        }
        .scrollIndicators(.hidden)
        
    }
}


extension RegisterView {
    
    private var registerButton: some View {
        Button(action: {
            print("등록 버튼 클릭")
            isLoading = true
            
            Task {
                switch registerType {
                case .sell:
                    if registerModel.baseValidate() && registerModel.sellValidate() {
                        await registerModel.registerPresignedRequest(registerType: registerType)
                        print("registerPresignedRequest 완료")
                    } else {
                        print("유효성 검증 실패")
                    }
                case .buy:
                    if registerModel.baseValidate() {
                    await registerModel.registerPresignedRequest(registerType: registerType)
                        print("registerPresignedRequest 완료")
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
        .disabled(registerType == .buy ? !registerModel.baseValidate() : !registerModel.baseValidate() && !registerModel.sellValidate())
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
