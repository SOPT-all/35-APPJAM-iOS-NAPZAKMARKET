//
//  SearchView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

enum SortOption: String {
    case recent = "RECENT"
    case popular = "POPULAR"
    case highPrice = "HIGH_PRICE"
    case lowPrice = "LOW_PRICE"
    
    var title: String {
        switch self {
        case .recent:
            return "최신순"
        case .popular:
            return "인기순"
        case .highPrice:
            return "고가순"
        case .lowPrice:
            return "저가순"
        }
    }
}

struct SearchView: View {
    
    //MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel
    @EnvironmentObject private var appState: AppState
    
    //상품 모델
    @StateObject private var productSearchModel = ProductSearchModel()
    
    //세그먼트 컨트롤
    @State var selectedTabIndex = 0
    
    //필터
    @State var adaptedGenres: [GenreName] = []
    @State var selectedGenreStrings: [String] = []
    
    //상품 분류
    @State var productFetchOption = ProductFetchOption(sortOption: .recent, genreIDs: [], isOnSale: false, isUnopened: false)
    @State var isFiltered = false
    
    //화면 전환
    @State var sortModalViewIsPresented = false
    @State var filterModalViewIsPresented = false
    @State var searchInputViewIsPresented = false
    
    //검색 결과
    @State var isBackButtonHidden = true
    @State var searchResultText: String = ""
    
    //좋아요
    @State var isInterestChangedInSell: Bool? = false
    @State var isInterestChangedInBuy: Bool? = false
    
    //상태 관리
    @State var onAppearState = true
    
    let width = (UIScreen.main.bounds.width - 55) / 2
    
    //MARK: - Properties
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    //MARK: - Main Body
    
    var body: some View {
        ZStack {
            Color.napzakGrayScale(.white)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    searchButton
                    NZSegmentedControl(
                        selectedIndex: $selectedTabIndex,
                        tabs: ["팔아요", "구해요"],
                        spacing: 15
                    )
                    .frame(height: 49)
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
                            selectedSortOption: $productFetchOption.sortOption
                        )
                    } else if filterModalViewIsPresented {
                        Color.napzakTransparency(.black70)
                            .onTapGesture {
                                filterModalViewIsPresented = false
                            }
                        GenreFilterModalView(
                            adaptedGenres: $adaptedGenres,
                            filterModalViewIsPresented: $filterModalViewIsPresented
                        )
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
        .onAppear() {
            if onAppearState {
                Task {
                    if searchResultText.isEmpty {
                        await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
                        await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
                    } else {
                        await productSearchModel.getSellProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                        await productSearchModel.getBuyProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                    }
                }
                onAppearState = false
            }
        }
        .onChange(of: appState.isProductRegistered) { _ in
            Task {
                await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
                await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
            }
        }
        .onChange(of: isInterestChangedInSell) { _ in
            Task {
                await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
            }
        }
        .onChange(of: isInterestChangedInBuy) { _ in
            Task {
                await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
            }
        }
        .onChange(of: adaptedGenres) { _ in
            productFetchOption.genreIDs = adaptedGenres.map { $0.id }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 60 {
                        dismiss()
                    }
                }
        )
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $searchInputViewIsPresented) {
            SearchInputView()
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
                    if adaptedGenres.isEmpty {
                        Image(.chipGenre)
                            .resizable()
                            .frame(width: 67, height: 33)
                    } else {
                        HStack(spacing: 4) {
                            Text(adaptedGenres.count == 1 ? "\(adaptedGenres[0].genreName)" : "\(adaptedGenres[0].genreName) 외 \(adaptedGenres.count - 1)")
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
                    productFetchOption.isOnSale.toggle()
                } label: {
                    Image(productFetchOption.isOnSale ? .chipSoldoutSelect : .chipSoldout)
                        .resizable()
                        .frame(width: 69, height: 33)
                }
                
                if selectedTabIndex == 0 {
                    Button {
                        print("미개봉 필터 선택")
                        productFetchOption.isUnopened.toggle()
                    } label: {
                        Image(productFetchOption.isUnopened ? .chipUnopenSelect : .chipUnopen)
                            .resizable()
                            .frame(width: 59, height: 33)
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 53)
        .background(Color.napzakGrayScale(.gray50))
    }
    
    
    private var productScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 4) {
                        Text("상품")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                        Text(selectedTabIndex == 0 ? "\(productSearchModel.sellProducts.count)개" : "\(productSearchModel.buyProducts.count)개")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakPurple(.purple30))
                        Spacer()
                        Button {
                            print("정렬 버튼 선택")
                            sortModalViewIsPresented = true
                        } label: {
                            HStack(spacing: 0) {
                                Text("\(productFetchOption.sortOption.title)")
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
                            ForEach(productSearchModel.sellProducts) { product in
                                NavigationLink(destination: ProductDetailView(isChangedInterest: $isInterestChangedInSell, productId: product.id)) {
                                    ProductItemView(
                                        product: product,
                                        width: width
                                    )
                                    .environmentObject(productSearchModel)
                                }
                            }
                        }
                        else if selectedTabIndex == 1 {
                            ForEach(productSearchModel.buyProducts) { product in
                                NavigationLink(destination: ProductDetailView(isChangedInterest: $isInterestChangedInBuy, productId: product.id)) {
                                    ProductItemView(
                                        product: product,
                                        width: width
                                    )
                                    .environmentObject(productSearchModel)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 130)
                }
            }
            .padding(.horizontal, 20)
            .onChange(of: selectedTabIndex) { _ in
                productFetchOption.sortOption = .recent
                proxy.scrollTo("header", anchor: .top)
                Task {
                    if searchResultText.isEmpty {
                        if isFiltered {
                            await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
                            await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
                        } else {
                            if selectedTabIndex == 0 {
                                await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
                            } else if selectedTabIndex == 1 {
                                await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
                            }
                        }
                    } else {
                        if isFiltered {
                            await productSearchModel.getBuyProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                            await productSearchModel.getSellProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                        } else {
                            if selectedTabIndex == 0 {
                                await productSearchModel.getBuyProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                            } else if selectedTabIndex == 1 {
                                await productSearchModel.getSellProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                            }
                        }
                    }
                    isFiltered = false
                }
            }
            .onChange(of: productFetchOption) { _ in
                proxy.scrollTo("header", anchor: .top)
                isFiltered = true
                Task {
                    if searchResultText.isEmpty {
                        if selectedTabIndex == 0 {
                            await productSearchModel.getSellProducts(productFetchOption: productFetchOption)
                        } else if selectedTabIndex == 1 {
                            await productSearchModel.getBuyProducts(productFetchOption: productFetchOption)
                        }
                    } else {
                        if selectedTabIndex == 0 {
                            await productSearchModel.getSellProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                        } else if selectedTabIndex == 1 {
                            await productSearchModel.getBuyProductsForSearch(searchWord: searchResultText, productFetchOption: productFetchOption)
                        }
                    }
                }
            }
        }
    }
}
