//
//  SearchView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    //상품
    @State var sellProducts = ProductModel.sellDummyList()
    @State var buyProducts = ProductModel.buyDummyList()
    
    //세그먼트 컨트롤
    @State var selectedTabIndex = 0
    
    //정렬
    @State var selectedSortOption: SortOption = .latest
    
    //필터
    @State var selectedGenres: [GenreName] = []
    @State var selectedGenreStrings: [String] = []
    @State var isSoldoutFilterOn = false
    @State var isUnopenFilterOn = false
    
    //화면 전환
    @State var sortModalViewIsPresented = false
    @State var filterModalViewIsPresented = false
    @State var searchInputViewIsPresented = false

    //검색 결과
    @State var isBackButtonHidden = true
    @State var searchResultText: String = ""
    
    let width = (UIScreen.main.bounds.width - 55) / 2
    
    //MARK: - Properties
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    //MARK: - Main Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
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
                    .ignoresSafeArea(edges: [.horizontal, .bottom])
                    .frame(width: geometry.size.width, height: geometry.size.height)

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
                            
//                            GenreFilterModalView(
//                                selectedGenres: $selectedGenres,
//                                selectedGenreStrings: $selectedGenreStrings,
//                                filterModalViewIsPresented: $filterModalViewIsPresented
//                            )
                        }
                    }
                    .ignoresSafeArea(.all)
                    .animation(.interactiveSpring(), value: sortModalViewIsPresented)
                    .animation(.interactiveSpring(), value: filterModalViewIsPresented)
                    .onChange(of: sortModalViewIsPresented) { _ in
                        if sortModalViewIsPresented == false {
                            tabBarState.isTabBarHidden = false
                        }
                    }
                    .onChange(of: filterModalViewIsPresented) { _ in
                        if filterModalViewIsPresented == false {
                            tabBarState.isTabBarHidden = false
                        }
                    }
                }
                .ignoresSafeArea(.keyboard)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $searchInputViewIsPresented) {
                SearchInputView()
            }
        }
    }
}

extension SearchView {
    
    //MARK: - UI Properties
    
    private var searchButton: some View {
        HStack(alignment: .center, spacing: 4) {
            if !isBackButtonHidden {
                Button {
                    dismiss()
                } label: {
                    Image(.icBack)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.top, 4)
                }
            }
            Button {
                if isBackButtonHidden {
                    searchInputViewIsPresented = true
                } else {
                    dismiss()
                }
            } label: {
                HStack(alignment: .center) {
                    Text(searchResultText.isEmpty ? "어떤 아이템을 찾고 계신가요?" : "\(searchResultText)")
                        .font(.napzakFont(.body5SemiBold14))
                        .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                        .foregroundStyle(searchResultText.isEmpty ? Color.napzakGrayScale(.gray400) : Color.napzakGrayScale(.gray900))
                    Spacer()
                    Image(.iconSearch)
                }
                .frame(height: 44)
                .padding(.horizontal, 12)
                .background(Color.napzakGrayScale(.gray100))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.top, 18)
        .padding(.leading, isBackButtonHidden ? 20 : 0 )
        .padding(.trailing, 20)
    }
    
    private var filterButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 6) {
                Button {
                    print("장르 필터 선택")
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
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
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
                    print("품절 제외 필터 선택")
                    isSoldoutFilterOn.toggle()
                } label: {
                    Image(isSoldoutFilterOn ? .chipSoldoutSelect : .chipSoldout)
                        .resizable()
                        .frame(width: 69, height: 33)
                }
                
                if selectedTabIndex == 0 {
                    Button {
                        print("미개봉 필터 선택")
                        isUnopenFilterOn.toggle()
                    } label: {
                        Image(isUnopenFilterOn ? .chipUnopenSelect : .chipUnopen)
                            .resizable()
                            .frame(width: 59, height: 33)
                    }
                }
                Spacer()
            }
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
                                NavigationLink(destination: ProductDetailView()) {
                                    ProductItemView(
                                        product: product,
                                width: width
                                    )
                                }
                            }
                        }
                        else if selectedTabIndex == 1 {
                            ForEach(buyProducts) { product in
                                NavigationLink(destination: ProductDetailView()) {
                                    ProductItemView(
                                        product: product,
                                        width: width
                                    )
                                }
                            }
                        }
                    }
                    .padding(.bottom, 130)
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
