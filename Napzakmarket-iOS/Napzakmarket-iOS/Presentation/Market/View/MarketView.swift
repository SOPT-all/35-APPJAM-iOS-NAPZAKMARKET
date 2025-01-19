//
//  MarketView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/13/25.
//

import SwiftUI

struct MarketView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel
        
    @State private var tags: [Tag] = MarketMockData.tags
    @State private var selectedIndex = 0
    @State private var sellProducts = ProductModel.sellDummyList()
    @State private var buyProducts = ProductModel.buyDummyList()
    @State private var selectedSortOption: SortOption = .latest
    @State private var selectedGenres: [GenreSearchModel] = []
    @State private var selectedGenreStrings: [String] = []
    @State private var sortModalViewIsPresented = false
    @State private var filterModalViewIsPresented = false
    @State private var isSoldoutFilterOn = false
    @State private var isUnopenFilterOn = false
   
    
    let width = (UIScreen.main.bounds.width - 55) / 2
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationSection
                profileSection
               
                NZSegmentedControl(
                    selectedIndex: $selectedIndex,
                    tabs: ["팔아요", "구해요", "후기"],
                    spacing: 15
                )
                .frame(height: 46)
                .padding(.top, 20)
               
                if selectedIndex == 2 {
                    ReadyComponent()
                        .navigationBarHidden(true)
                } else {
                    filterButtons
                    
                    ScrollView(showsIndicators: false) {
                        let products = selectedIndex == 0 ? sellProducts : buyProducts
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 4) {
                                Text("상품")
                                    .font(.napzakFont(.body5SemiBold14))
                                    .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                                Text("\(products.count)개")
                                    .font(.napzakFont(.body5SemiBold14))
                                    .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                                    .foregroundStyle(Color.napzakPurple(.purple30))
                                Spacer()
                                Button {
                                    sortModalViewIsPresented = true
                                } label: {
                                    HStack(spacing: 0) {
                                        Text("\(selectedSortOption.rawValue)")
                                            .font(.napzakFont(.caption3Medium12))
                                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                                            .foregroundStyle(Color.napzakGrayScale(.gray600))
                                        Image(.iconDownSmGray)
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                    }
                                }
                            }
                            .frame(height: 56)
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                if selectedIndex == 0 {
                                    ForEach(sellProducts) { product in
                                        ProductItemView(
                                            product: product,
                                            width: width
                                        )
                                    }
                                } else {
                                    ForEach(buyProducts) { product in
                                        ProductItemView(
                                            product: product,
                                            width: width
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .background(Color(.white))
            .navigationBarHidden(true)
            .onAppear {
                tabBarState.isTabBarHidden = true
            }
            .onDisappear {
                tabBarState.isTabBarHidden = false
            }
            
            ZStack(alignment: .bottom) {
                if sortModalViewIsPresented {
                    Color.napzakTransparency(.black70)
                        .onTapGesture {
                            sortModalViewIsPresented = false
                        }
                    
                    SortModalView(
                        sortModalViewIsPresented: $sortModalViewIsPresented,
                        selectedSortOption: $selectedSortOption
                    )
                } else if filterModalViewIsPresented {
                    Color.napzakTransparency(.black70)
                        .onTapGesture {
                            filterModalViewIsPresented = false
                        }
                    
                    GenreFilterModalView(
                        selectedGenres: $selectedGenres,
                        selectedGenreStrings: $selectedGenreStrings,
                        filterModalViewIsPresented: $filterModalViewIsPresented
                    )
                }
            }
            .ignoresSafeArea(.all)
            .animation(.interactiveSpring(), value: sortModalViewIsPresented)
            .animation(.interactiveSpring(), value: filterModalViewIsPresented)
        }
        .background(Color(.white))
        .navigationBarHidden(true)
    }
    
    private var filterButtons: some View {
        HStack(alignment: .center, spacing: 6) {
            Button {
                filterModalViewIsPresented = true
            } label: {
                if selectedGenres.isEmpty {
                    Image(.chipGenre)
                        .resizable()
                        .frame(width: 67, height: 33)
                } else {
                    HStack(spacing: 4) {
                        Text(selectedGenres.count == 1 ? "\(selectedGenres[0].genreName)" : "\(selectedGenres[0].genreName) 외 \(selectedGenres.count - 1)")
                            .font(.napzakFont(.caption2SemiBold12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption2SemiBold12)
                            .foregroundStyle(Color.napzakGrayScale(.white))
                        Image(.iconDownSmWhite)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color.napzakGrayScale(.gray900))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                }
            }
            .padding(.leading, 20)
            
            Button {
                isSoldoutFilterOn.toggle()
            } label: {
                Image(isSoldoutFilterOn ? .chipSoldoutSelect : .chipSoldout)
                    .resizable()
                    .frame(width: 69, height: 33)
            }
            
            if selectedIndex == 0 {
                Button {
                    isUnopenFilterOn.toggle()
                } label: {
                    Image(isUnopenFilterOn ? .chipUnopenSelect : .chipUnopen)
                        .resizable()
                        .frame(width: 59, height: 33)
                }
            }
            Spacer()
        }
        .frame(height: 53)
        .background(Color.napzakGrayScale(.gray50))
    }
    
    private var navigationSection: some View {
        ZStack(alignment: .top) {
            Color.napzakGrayScale(.gray200)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 138)
            
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image("img_market_bg_character")
                    .resizable()
                    .frame(width: 138, height: 111, alignment: .trailing)
                    .padding(.top, 27)
            }
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.napzakGrayScale(.gray900))
                        .frame(width: 48, height: 48)
                    
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var profileSection: some View {
        VStack(spacing: 0) {
            Image("img_profile_md")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .padding(.top, -55)
            
            Text("아요핑들")
                .font(.napzakFont(.title2Bold20))
                .applyNapzakTextStyle(napzakFontStyle: .title2Bold20)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.top, 6)
            
            tagListView
                .padding(.top, 8)
            
            Text("마이멜로디, 시나모롤 제일 좋아합니다 :) 해당 장르 상품들 판매 및 제시 채팅 언제든 환영합니다!")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray700))
        }
    }
    
    private var tagListView: some View {
        HStack(spacing: 6) {
            ForEach(tags) { tag in
                Text(tag.name)
                    .font(.system(size: 12))
                    .foregroundColor(Color.napzakGrayScale(.gray800))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.napzakGrayScale(.gray100))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        .padding(.horizontal, 16)
    }
}
