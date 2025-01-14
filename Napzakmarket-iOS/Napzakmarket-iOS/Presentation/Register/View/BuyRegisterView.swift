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
    @State private var suggestPrice = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // MARK: - 상품 이미지
                RegisterImage()
                
                // MARK: - 장르
                RegisterGenre(genre: $genre)
                
                // MARK: - 제목
                RegisterTitle(title: $title)
                
                // MARK: - 설명
                RegisterDescription(description: $description)
                
                // MARK: - 가격 구분선
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 8)
                    .padding(.bottom, 40)
                
                // MARK: - 가격
                RegisterBuyPrice(price: $price, suggestPrice: $suggestPrice)

            }
            .padding(.bottom, 67)
        }
    }

}

#Preview {
    TabBarView()
}
