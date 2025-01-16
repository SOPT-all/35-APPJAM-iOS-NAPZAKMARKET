//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @ObservedObject var registerModel: RegisterModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // 상품 이미지
                RegisterImage(images: $registerModel.registerInfo.images)
                    .padding(.top, 15)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)

                // 장르
                RegisterGenre(genre: $registerModel.registerInfo.genre)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 제목
                RegisterTitle(title: $registerModel.registerInfo.title)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 설명
                RegisterDescription(description: $registerModel.registerInfo.description)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 상품 상태
                RegisterProductState(productState: $registerModel.registerInfo.productState)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)

                // 가격 구분선
                Rectangle()
                    .fill(Color.napzakGrayScale(.gray50))
                    .frame(height: 8)
                
                // 가격
                RegisterSellPrice(price: $registerModel.registerInfo.price)
                    .padding(.vertical, 35)
                    .padding(.horizontal, 20)

                // 배송비
                RegisterDeliveryCharge(
                    deliveryChargeFree: $registerModel.registerInfo.deliveryChargeFree,
                    normalDelivery: $registerModel.registerInfo.normalDelivery,
                    normalDeliveryCharge: $registerModel.registerInfo.normalDeliveryCharge,
                    halfDelivery: $registerModel.registerInfo.halfDelivery,
                    halfDeliveryCharge: $registerModel.registerInfo.halfDeliveryCharge
                )
                .padding(.horizontal, 20)

            }
            .padding(.bottom, 67)
        }
        
    }

}
