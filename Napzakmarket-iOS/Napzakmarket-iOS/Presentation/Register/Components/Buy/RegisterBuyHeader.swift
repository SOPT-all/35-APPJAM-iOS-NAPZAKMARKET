//
//  RegisterBuyHeader.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/12/25.
//

import SwiftUI

struct RegisterBuyHeader: View {
    var body: some View {
        HStack{
            Button {
                print("뒤로가기 버튼")
            } label: {
                Image(systemName: "multiply")
            }
            .foregroundStyle(.black)
            
            Spacer()
            Text("구해요 등록")
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
        Divider()
    }
}

#Preview {
    RegisterBuyHeader()
}
