//
//  SearchView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - Property Wrappers
    
    @State var sellProducts = ProductModel.sellDummyList()
    @State var buyProducts = ProductModel.buyDummyList()
    @State var selectedTabIndex = 0
    @State var selectedSortOption: SortOption = .latest
    @State var sortModalViewIsPresented = false
    
    //MARK: - Properties
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    //MARK: - Main Body
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                searchButton
                NZSegmentedControl(
                    selectedIndex: $selectedTabIndex,
                    tabs: ["팔아요", "구해요"],
                    spacing: 15
                )
                filterButtons
                productScrollView
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
                }
            }
            .ignoresSafeArea(.all)
            .animation(.interactiveSpring(), value: sortModalViewIsPresented)
        }
    }
}

extension SearchView {
    
    //MARK: - UI Properties
    
    private var searchButton: some View {
        Button {
            print("searchButtonTapped")
        } label: {
            HStack {
                Text("어떤 아이템을 찾고 계신가요?")
                    .font(.napzakFont(.body5SemiBold14))
                    .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                    .foregroundStyle(Color.napzakGrayScale(.gray400))
                Spacer()
                Image(.iconSearch)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 44)
        .background(Color.napzakGrayScale(.gray100))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
    }
    
    private var filterButtons: some View {
        HStack(alignment: .center, spacing: 6) {
            Button {
                print("장르 필터 선택")
            } label: {
                Image(.chipGenre)
                    .resizable()
                    .frame(width: 67, height: 33)
            }
            .padding(.leading, 20)

            Button {
                print("품절 제외 필터 선택")
            } label: {
                Image(.chipSoldout)
                    .resizable()
                    .frame(width: 69, height: 33)
            }
            
            if selectedTabIndex == 0 {
                Button {
                    print("미개봉 필터 선택")
                } label: {
                    Image(.chipUnopen)
                        .resizable()
                        .frame(width: 59, height: 33)
                }
            }
            Spacer()

        }
        .frame(height: 53)
        .background(Color.napzakGrayScale(.gray50))
    }
    
    private var productScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                let products = selectedTabIndex == 0 ? sellProducts : buyProducts
                
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
                            print("정렬 버튼 선택")
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
                    .id("header")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        if selectedTabIndex == 0 {
                            ForEach(sellProducts) { product in
                                ProductItemView(
                                    product: product,
                                    isLikeButtonExist: true
                                )
                            }
                        } else if selectedTabIndex == 1 {
                            ForEach(buyProducts) { product in
                                ProductItemView(
                                    product: product,
                                    isLikeButtonExist: true
                                )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .onChange(of: selectedTabIndex) { _ in
                selectedSortOption = .latest
                proxy.scrollTo("header", anchor: .top)
            }
        }
    }
}
