//
//  BuyRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct BuyRegisterView: View {
    @ObservedObject var registerModel: RegisterModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                RegisterImage(selectedImages: $registerModel.registerInfo.images)
                    .padding(.top, 15)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)
                
                RegisterGenre(genre: $registerModel.registerInfo.genre)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)
                
                RegisterTitle(title: $registerModel.registerInfo.title)
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)
                
                RegisterDescription(description: $registerModel.registerInfo.description)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)
                
                // 가격 구분선
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 8)
                    .padding(.bottom, 40)
                
                RegisterBuyPrice(
                    price: $registerModel.registerInfo.price,
                    suggestPrice: $registerModel.registerInfo.suggestPrice
                )
                .padding(.horizontal, 20)
                
            }
            .padding(.bottom, 38)
        }
    }
    
}
