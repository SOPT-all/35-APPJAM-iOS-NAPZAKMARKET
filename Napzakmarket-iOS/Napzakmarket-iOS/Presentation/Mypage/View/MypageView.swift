//
//  MypageView.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/11/25.
//

import SwiftUI

struct MyPageView: View {
    @State private var navigateToMarket = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                titleSection
                
                ZStack(alignment: .top) {
                    backgroundSection
                    
                    VStack(spacing: 0) {
                        dividerLine
                        
                        VStack(spacing: 0) {
                            profileSection
                            menuSection
                            Spacer()
                        }
                    }
                }
            }
            .background(Color.clear)
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Title
    
    private var titleSection: some View {
        Text("마이페이지")
            .font(.napzakFont(.title4Bold18))
            .applyNapzakTextStyle(napzakFontStyle: .title4Bold18)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color.napzakGrayScale(.white))
    }
    
    // MARK: - Background
    
    private var backgroundSection: some View {
        Color.napzakGrayScale(.gray50)
            .frame(height: 342)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    // MARK: - 구분선
    
    private var dividerLine: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color.napzakGrayScale(.gray200))
    }
    
    // MARK: - Profile Section
    
    private var profileSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image("img_profile_md")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                Text("납자기님")
                    .font(.napzakFont(.title2Bold20))
                    .applyNapzakTextStyle(napzakFontStyle: .title2Bold20)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                
                Spacer()
            }
            
            marketButton
        }
        .padding(20)
        .frame(width: 360)
        .background(Color.napzakGrayScale(.white))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
        )
        .padding(.top, 20)
    }
    
    // MARK: - 내마켓보기 버튼
    
    private var marketButton: some View {
        NavigationLink(destination: MarketView()) {
            Text("내 마켓 보기")
                .font(.napzakFont(.body1Bold16))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.napzakPurple(.purple30))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    // MARK: - 메뉴드
    
    private var menuSection: some View {
        HStack(spacing: 31) {
            ForEach(MyPageFeature.allCases) { menu in
                menuItem(menu)
            }
        }
        .padding(.top, 38)
    }
    
    private func menuItem(_ menu: MyPageFeature) -> some View {
        NavigationLink(destination: ReadyView()) {
            VStack(spacing: 8) {
                Image(menu.iconName)
                    .resizable()
                    .frame(width: 34, height: 34)
                    .padding(10)
                    .background(Color.napzakGrayScale(.white))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(menu.title)
                    .font(.napzakFont(.body6Medium14))
                    .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                    .font(.system(size: 13))
                    .foregroundColor(Color.napzakGrayScale(.gray700))
            }
        }
    }
}

#Preview {
    MyPageView()
}

