//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // MARK: - 상품 이미지
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("상품 이미지")
                            .font(.system(size: 16))
                        
                        Text("다양한 상품 이미지를 등록하면 판매 확률이 올라가요!")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        
                        Button {
                            print("버튼 눌림")
                        } label: {
                            VStack(alignment: .center){
                                Image(systemName: "camera")
                                Text("0/10")
                            }
                        }
                        .frame(width: 80, height: 80)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.top, 12)
                    }
                    .padding(20)
                    
                    
                }
            }
        }
    }
}

#Preview {
    SellRegisterView()
}
