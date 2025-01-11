//
//  RegisterHeaderView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterHeaderView: View {
    var body: some View {
        HStack{
            Button {
                print("뒤로가기 버튼")
            } label: {
                Image(systemName: "multiply")
            }
            .foregroundStyle(.black)
            
            Spacer()
            Text("팔아요 등록")
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
        Divider()
    }
}

#Preview {
    RegisterHeaderView()
}
