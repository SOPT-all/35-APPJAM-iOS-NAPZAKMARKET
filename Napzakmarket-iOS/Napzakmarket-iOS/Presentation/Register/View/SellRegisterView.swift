//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @State private var title = ""
    
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
                    
                    
                    // MARK: - 장르
                    
                    HStack(alignment: .center) {
                        NavigationLink {
                            Text("장르 뷰")
                        } label: {
                            HStack{
                                Text("장르")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(20)

                    
                    // MARK: - 구분선
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                        .padding(.horizontal, 20)
                    
                    
                    // MARK: - 제목
                    
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 35)
                    
                    
                }
            }
        }
    }
}

extension TextField {
    func maxLength(_ length: Int, text: Binding<String>) -> some View {
        self
            .onChange(of: text.wrappedValue, { oldValue, newValue in
                if newValue.count > length {
                    text.wrappedValue = String(newValue.prefix(length))
                }
            })
    }
}

#Preview {
    SellRegisterView()
}
