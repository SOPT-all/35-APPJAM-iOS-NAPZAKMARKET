//
//  BuyRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct BuyRegisterView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var genre = ""
    @State private var price = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // 상품 이미지
                RegisterImage()
                
                // 장르
                RegisterGenre(genre: $genre)
                
                // 제목
                RegisterTitle(title: $title)
                
                // 설명
                RegisterDescription(description: $description)
                
                // 가격 구분선
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 8)
                    .padding(.vertical, 40)
                
                // 가격
                RegisterSellPrice(price: $price)

            }
            .padding(.bottom, 67)
        }
    }

}

