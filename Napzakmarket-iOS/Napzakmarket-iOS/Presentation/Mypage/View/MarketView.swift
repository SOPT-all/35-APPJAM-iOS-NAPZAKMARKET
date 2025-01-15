//
//  MarketView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/13/25.
//

import SwiftUI

struct MarketView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTab = "팔아요"
    @State private var tags: [Tag] = MarketMockData.tags
    
    var body: some View {
        VStack(spacing: 0) {
            navigationSection
            profileSection
            Spacer()
        }
        .background(Color.napzakGrayScale(.gray50))
        .navigationBarHidden(true)
    }
    
    // MARK: - Navigation Section
    private var navigationSection: some View {
        ZStack(alignment: .top) {
            // 배경색
            Color.napzakGrayScale(.gray300)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 120)
            
            // 배경 이미지
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image("img_market_bg_character")
                    .resizable()
                    .frame(width: 138, height: 111, alignment: .trailing)
                    .padding(.top, 9)
            }
            
            // 네비게이션 바
            HStack {
                Button(action: {
                    dismiss()
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
    }
    
    // MARK: - Profile Section
    private var profileSection: some View {
        VStack(spacing: 12) {
            // 프로필 이미지
            Image("img_profile_md")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .offset(y: -60)
            
            // 사용자 이름
            Text("아요핑들")
                .font(.napzakFont(.title2Bold20))
                .applyNapzakTextStyle(napzakFontStyle: .title2Bold20)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .offset(y: -65)
            
            // 태그 목록
            tagListView
            
            // 소개 텍스트
            Text("마이멜로디, 시나모롤 제일 좋아합니다 :) 해당 장르 상품들 판매 및 제시 채팅 언제든 환영합니다!")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .offset(y: -85)
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray700))
        }
    }
    
    // MARK: - Tag List
    private var tagListView: some View {
        HStack(spacing: 8) {
            ForEach(tags) { tag in
                Text(tag.name)
                    .font(.system(size: 12))
                    .foregroundColor(Color.napzakGrayScale(.gray800))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.napzakGrayScale(.gray100))
                    .cornerRadius(4)
                    .offset(y: -73)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MarketView()
}
