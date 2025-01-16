//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @State private var images: [UIImage] = []
    @State private var title = ""
    @State private var description = ""
    @State private var genre = ""
    @State private var productState = ""
    @State private var price = ""
    @State private var deliveryChargeFree = true        // 배달비 여부
    @State private var normalDelivery = false           // 일반 배달비 선택 여부
    @State private var normalDeliveryCharge = ""        // 일반 배달비 금액
    @State private var halfDelivery = false             // 알뜰,반값 배달비 선택 여부
    @State private var halfDeliveryCharge = ""          // 알뜰,반값 배달비 금액

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // 상품 이미지
                RegisterImage(images: $images)
                    .padding(.top, 15)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)

                // 장르
                RegisterGenre(genre: $genre)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 제목
                RegisterTitle(title: $title)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 설명
                RegisterDescription(description: $description)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                // 상품 상태
                RegisterProductState(productState: $productState)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)

                // 가격 구분선
                Rectangle()
                    .fill(Color.napzakGrayScale(.gray50))
                    .frame(height: 8)
                
                // 가격
                RegisterSellPrice(price: $price)
                    .padding(.vertical, 35)
                    .padding(.horizontal, 20)

                // 배송비
                RegisterDeliveryCharge(
                    deliveryChargeFree: $deliveryChargeFree,
                    normalDelivery: $normalDelivery,
                    normalDeliveryCharge: $normalDeliveryCharge,
                    halfDelivery: $halfDelivery,
                    halfDeliveryCharge: $halfDeliveryCharge
                )
                .padding(.horizontal, 20)

            }
            .padding(.bottom, 67)
        }
        
    }

}
