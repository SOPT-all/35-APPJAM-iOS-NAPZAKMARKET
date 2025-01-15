//
//  MarketView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/13/25.
//

import SwiftUI

struct MarketView: View {
    @State private var selectedTab = "팔아요"
    @State private var tags: [Tag] = MarketMockData.tags
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 배경 이미지와 네비게이션 바
            ZStack(alignment: .top) {
                // 배경색을 먼저 설정
                Color(red: 0.91, green: 0.91, blue: 0.91)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 138)
                
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Image("img_market_bg_character")
                        .resizable()
                        .frame(width: 138, height: 111, alignment: .trailing)
                        .padding(.top, 27)
                }
                
                // 네비게이션 
                HStack {
                    Button(action: {
                        // 뒤로가기 액션
                    }) {
                        Image("ic_back")
                            .foregroundColor(Color.napzakGrayScale(.gray900))
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            
            // 프로필 섹션
            VStack(spacing: 12) {
                Image("img_profile_md")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88, height: 88)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .offset(y: -50)
                
                Text("납작아요임다")
                    .font(.napzakFont(.title2Bold20))
                    .applyNapzakTextStyle(napzakFontStyle: .title2Bold20)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .offset(y: -50)
                
                HStack(spacing: 8) {
                   ForEach(tags) { tag in
                       Text(tag.name)
                           .font(.system(size: 12))
                           .foregroundColor(Color.napzakGrayScale(.gray500))
                           .padding(.horizontal, 8)
                           .padding(.vertical, 4)
                           .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                           .cornerRadius(4)
                           .offset(y: -50)
                   }
               }
               .padding(.horizontal, 16)
                
                Text("마이멜로디, 시나모롤 제일 좋아합니다 :) 해당 장르 상품들 판매 및 제시 채팅 언제든 환영합니다!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .padding(.top, 4)
                    .offset(y: -60)
                    .font(.napzakFont(.caption3Medium12))
                    .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                    .foregroundStyle(Color.napzakGrayScale(.gray700))
            }
            
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            Spacer()
        }
        .background(Color.napzakGrayScale(.gray50))
        .navigationBarHidden(true)
    }
}

#Preview {
    MarketView()
}
