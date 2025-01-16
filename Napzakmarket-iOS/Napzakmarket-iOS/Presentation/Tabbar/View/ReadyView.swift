//
//  ReadyView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/14/25.
//

import SwiftUI

struct ReadyComponent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("img_ready")
                .resizable()
                .scaledToFit()
                .frame(width: 142, height: 128)
                .padding(.leading, -21)
            
            VStack(spacing: 6) {
                Text("준비중이에요")
                    .font(.napzakFont(.title3SemiBold20))
                    .foregroundStyle(Color.napzakGrayScale(.gray800))
                    .padding(.top, -10)

                Text("조금만 기다려주세요!")
                    .font(.napzakFont(.body6Medium14))
                    .foregroundStyle(Color.napzakGrayScale(.gray600))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ReadyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.napzakGrayScale(.gray900))
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            ReadyComponent()
        }
        .navigationBarHidden(true)
    }
}
