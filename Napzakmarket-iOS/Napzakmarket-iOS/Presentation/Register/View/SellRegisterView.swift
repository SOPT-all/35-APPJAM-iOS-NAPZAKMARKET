//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var selectedOption = ""
    
    private let descriptionPlaceholder = "자세히 작성하면 더 빠르고 원활한 거래를 할 수 있어요."
    + "\n예) 출시 연도, 사이즈, 한정판 여부, 네고 여부 등"
    private let options = ["미개봉", "아주 좋은 상태", "약간의 사용감", "사용감 있음"]

    
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
                    .padding(.vertical, 20)
                    
                    
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
                    .padding(.vertical, 20)

                    
                    // MARK: - 구분선
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                    
                    
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
                    .padding(.vertical, 35)
                    
                    
                    // MARK: - 설명
                    
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

                    
                    
                    // MARK: - 상품 상태
                    
                    VStack(alignment: .leading) {
                        Text("상품 상태")
                            .padding(.bottom, 12)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                            ForEach(options, id: \.self) { option in
                                Button {
                                    selectedOption = option
                                } label: {
                                    Text(option)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .foregroundColor(selectedOption == option ? .white : .black)
                                        .background(selectedOption == option ? .black : .white)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.gray, lineWidth: 1))
                                        
                                }
                            }
                        }
                        
                    }
                    
                    
                }
                .padding(.horizontal, 20)
                
            }
            
        }
    }
}

#Preview {
    SellRegisterView()
}
