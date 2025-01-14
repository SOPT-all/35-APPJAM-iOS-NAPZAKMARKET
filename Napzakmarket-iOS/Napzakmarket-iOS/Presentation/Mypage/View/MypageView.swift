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
                Text("마이페이지")
                    .font(.napzakFont(.title4Bold18))
                    .applyNapzakTextStyle(napzakFontStyle: .title4Bold18)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.napzakGrayScale(.white))
                
                ZStack(alignment: .top) {
                    Color.napzakGrayScale(.gray50)
                        .frame(height: 342)
                        .edgesIgnoringSafeArea(.horizontal)
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.napzakGrayScale(.gray200))
                        
                        VStack(spacing: 0) {
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
                                
                                NavigationLink(destination: PreView()) {
                                    Text("내 마켓 보기")
                                        .font(.napzakFont(.body1Bold16))
                                        .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(Color.napzakPuple(.purple30))
                                        .cornerRadius(12)
                                }
                            }
                            .padding(20)
                            .frame(width: 360)
                            .background(Color.napzakGrayScale(.white))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
                            )
                            .padding(.top, 20)
                            
                            HStack(spacing: 31) {
                                ForEach(MyPageModel.allCases, id: \.self) { menu in
                                    VStack(spacing: 8) {
                                        Image(menu.iconName)
                                            .resizable()
                                            .frame(width: 34, height: 34)
                                            .padding(10)
                                            .background(Color.napzakGrayScale(.white))
                                            .cornerRadius(12)
                                        Text(menu.title)
                                            .font(.napzakFont(.body6Medium14))
                                            .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.napzakGrayScale(.gray700))
                                    }
                                }
                            }
                            .padding(.top, 38)
                            
                            Spacer()
                        }
                    }
                }
            }
            .background(Color.clear)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MyPageView()
}
