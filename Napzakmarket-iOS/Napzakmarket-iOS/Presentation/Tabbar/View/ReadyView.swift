//
//  ReadyView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/14/25.
//

import SwiftUI

struct ReadyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("ic_back")
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            VStack {
                Image("img_ready")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 142, height: 148)
                    .padding(.leading, -21)
                    .padding(.bottom, 10)
                
                VStack(spacing: 6) {
                    Text("준비중이에요")
                        .font(.napzakFont(.title3SemiBold20))
                        .foregroundStyle(Color.napzakGrayScale(.gray800))

                    Text("조금만 기다려주세요!")
                        .font(.napzakFont(.body6Medium14))
                        .foregroundStyle(Color.napzakGrayScale(.gray600))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
    }
}
