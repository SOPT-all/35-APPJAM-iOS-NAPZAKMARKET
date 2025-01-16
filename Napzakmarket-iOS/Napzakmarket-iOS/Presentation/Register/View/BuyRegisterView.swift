//
//  BuyRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct BuyRegisterView: View {
    @State private var images: [UIImage] = []
    @State private var title = ""
    @State private var description = ""
    @State private var genre = ""
    @State private var price = ""
    @State private var suggestPrice = false

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
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)
                
                // 가격 구분선
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 8)
                    .padding(.bottom, 40)
                
                // MARK: - 가격
                RegisterBuyPrice(price: $price, suggestPrice: $suggestPrice)
                    .padding(.horizontal, 20)

            }
            .padding(.bottom, 38)
        }
    }

}
