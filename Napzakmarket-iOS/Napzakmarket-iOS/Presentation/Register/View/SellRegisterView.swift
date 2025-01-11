//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var productState = ""
    @State private var price = ""
    @State private var deliveryChargeFree = true        // 배달비 여부
    @State private var normalDelivery = false           // 일반 배달비 선택 여부
    @State private var normalDeliveryCharge = ""        // 일반 배달비 금액
    @State private var halfDelivery = false             // 알뜰,반값 배달비 선택 여부
    @State private var halfDeliveryCharge = ""          // 알뜰,반값 배달비 금액

    var body: some View {
        NavigationStack {
            RegisterSellHeader()
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // MARK: - 상품 이미지
                    RegisterImage()
                    
                    // MARK: - 장르
                    RegisterGenre()
                    
                    // MARK: - 제목
                    RegisterTitle(title: $title)
                    
                    // MARK: - 설명
                    RegisterDescription(description: $description)
                    
                    // MARK: - 상품 상태
                    RegisterProductState(productState: $productState)
                    
                    // MARK: - 가격 구분선
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 8)
                        .padding(.vertical, 40)
                    
                    // MARK: - 가격
                    RegisterSellPrice(price: $price)

                    
                    // MARK: - 배송비
                    RegisterDeliveryCharge(
                        deliveryChargeFree: $deliveryChargeFree,
                        normalDelivery: $normalDelivery,
                        normalDeliveryCharge: $normalDeliveryCharge,
                        halfDelivery: $halfDelivery,
                        halfDeliveryCharge: $halfDeliveryCharge
                    )
                    
                }
                .padding(.bottom, 67)
            }
            
            Button(action: {
                print(("tapped button"))
            }, label: {
                Text("등록하기")
            })
            .frame(maxWidth: .infinity, minHeight: 52)
            .foregroundStyle(.white)
            .background(.gray.opacity(1))
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
        }
        .scrollIndicators(.hidden)
        
        
    }

}

#Preview {
    SellRegisterView()
}
