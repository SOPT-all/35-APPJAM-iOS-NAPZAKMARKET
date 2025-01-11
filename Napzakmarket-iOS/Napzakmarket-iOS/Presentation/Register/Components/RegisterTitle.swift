//
//  RegisterTitle.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterTitle: View {
    @Binding var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("제목")
                .padding(.bottom, 12)
            
            TextField("제목을 적어주세요.", text: $title)
                .maxLength(50, text: $title)
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                }
            
            HStack {
                Spacer()
                Text("\(title.count) / 50")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 4)
            
        }
        .padding(.vertical, 35)
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    SellRegisterView()
}
