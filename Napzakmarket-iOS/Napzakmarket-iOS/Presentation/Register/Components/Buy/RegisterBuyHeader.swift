//
//  RegisterBuyHeader.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct RegisterBuyHeader: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack{
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                
                Spacer()
            }
            .padding(.leading, 20)
            
            HStack {
                Spacer()
                
                Text("구해요 등록")
                    .font(.napzakFont(.title5SemiBold18))
                    .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                
                Spacer()
            }
            .padding(.vertical, 10)
        }

        
        Divider()
    }
}

#Preview {
    @State var state = false
    RegisterView(registerType: $state)
}
