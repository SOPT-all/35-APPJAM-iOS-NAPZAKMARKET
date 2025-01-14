//
//  RegisterHeaderView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterSellHeader: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "multiply")
            }
            .foregroundStyle(Color.napzakGrayScale(.gray900))

            Spacer()
            Text("팔아요 등록")
                .font(.napzakFont(.title5SemiBold18))
                .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
        Divider()
    }
}

