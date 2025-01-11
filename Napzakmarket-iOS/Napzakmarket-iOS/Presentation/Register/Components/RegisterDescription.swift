//
//  RegisterDescription.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterDescription: View {
    @Binding var description: String
    
    private let descriptionPlaceholder = "자세히 작성하면 더 빠르고 원활한 거래를 할 수 있어요."
    + "\n예) 출시 연도, 사이즈, 한정판 여부, 네고 여부 등"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("설명")
                .padding(.bottom, 12)
            
            ZStack(alignment: .topLeading){
                TextEditor(text: $description)
                    .maxLength(250, text: $description)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                
                if description.isEmpty {
                    Text(descriptionPlaceholder)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 19)
                }
            }
            .frame(height: 132)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
            }
            
            HStack {
                Spacer()
                Text("\(description.count) / 250")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 4)
            
        }
        .padding(.bottom, 35)
        .padding(.horizontal, 20)
    }
}
