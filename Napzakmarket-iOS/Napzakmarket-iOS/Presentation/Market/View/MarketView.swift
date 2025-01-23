//
//  MarketView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/13/25.
//

import SwiftUI

import Kingfisher

struct MarketView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    let storeId: Int
    
    @State private var storeInfo: StoreInfoData?
    @State private var selectedIndex = 0
    
    //상품 모델
    @StateObject private var productModel = MarketModel()
    
    //필터
    @State var adaptedGenres: [GenreName] = []
    @State var selectedGenreStrings: [String] = []
    
    //상품 분류
    @State var productFetchOption = ProductFetchOption(sortOption: .recent, genreIDs: [], isOnSale: false, isUnopened: false)
    @State var isFiltered = false
    
    //화면 전환
    @State var sortModalViewIsPresented = false
    @State var filterModalViewIsPresented = false
    
    private let width = (UIScreen.main.bounds.width - 55) / 2
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    init(storeId: Int) {
        self.storeId = storeId
    }
    
    // MARK: - Views
    
    var body: some View {
        NavigationStack {
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
                        productScrollView
                    }
                }
                .background(Color(.white))
                .navigationBarHidden(true)
                .onAppear {
                    getStoreInfo()
                    tabBarState.isTabBarHidden = true
                    
                    Task {
                        await productModel.getStoreOwnerBuyProducts(storeId: storeId, productFetchOption: productFetchOption)
                        await productModel.getStoreOwnerSellProducts(storeId: storeId, productFetchOption: productFetchOption)
                    }
                }
                .onDisappear {
                    tabBarState.isTabBarHidden = false
                }
                .onChange(of: adaptedGenres) { _ in
                    productFetchOption.genreIDs = adaptedGenres.map { $0.id }
                }
                
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
            .background(Color(.white))
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Private Views
    
    private var navigationSection: some View {
        ZStack(alignment: .top) {
            Color.napzakGrayScale(.gray200)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 130)
            
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image("img_market_bg_character")
                    .resizable()
                    .frame(width: 138, height: 111, alignment: .trailing)
                    .padding(.top, 19)
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
            if let storeInfo = storeInfo {
                KFImage(URL(string: storeInfo.storePhoto))
                    .placeholder {
                        Image("img_profile_md")
                            .resizable()
                            .scaledToFit()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88, height: 88)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(.top, -55)
                
                Text(storeInfo.storeNickName)
                    .font(.napzakFont(.title2Bold20))
                    .applyNapzakTextStyle(napzakFontStyle: .title2Bold20)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .padding(.top, 6)
                
                HStack(spacing: 6) {
                    ForEach(storeInfo.genrePreferences, id: \.id) { genre in
                        Text(genre.genreName)
                            .font(.system(size: 12))
                            .foregroundColor(Color.napzakGrayScale(.gray800))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.napzakGrayScale(.gray100))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Text(storeInfo.storeDescription)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .font(.napzakFont(.caption3Medium12))
                    .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                    .foregroundStyle(Color.napzakGrayScale(.gray700))
            } else {
                ProgressView()
                    .padding()
            }
        }
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
                
                if selectedIndex == 0 {
                    Button {
                        print("미개봉 필터 선택")
                        productFetchOption.isUnopened.toggle()
                    } label: {
                        Image(productFetchOption.isUnopened ? .chipUnopenSelect : .chipUnopen)
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
                VStack(spacing: 0) {
                    HStack(spacing: 4) {
                        Text("상품")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                        Text(selectedIndex == 0 ? "\(productModel.sellProducts.count)개" : "\(productModel.buyProducts.count)개")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakPurple(.purple30))
                        Spacer()
                        Button {
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
                        if selectedIndex == 0 {
                            ForEach(productModel.sellProducts) { product in
                                NavigationLink(destination: ProductDetailView(productId: product.id)) {
                                    ProductItemView(
                                        product: product,
                                        width: width
                                    )
                                    .environmentObject(productModel)
                                }
                            }
                        }
                        else if selectedIndex == 1 {
                            ForEach(productModel.buyProducts) { product in
                                NavigationLink(destination: ProductDetailView(productId: product.id)) {
                                    ProductItemView(
                                        product: product,
                                        width: width
                                    )
                                    .environmentObject(productModel)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 130)
                }
            }
            .padding(.horizontal, 20)
            .onChange(of: selectedIndex) { _ in
                productFetchOption.sortOption = .recent
                proxy.scrollTo("header", anchor: .top)
                Task {
                    if selectedIndex == 0 {
                        await productModel.getStoreOwnerSellProducts(storeId: storeId, productFetchOption: productFetchOption)
                    } else if selectedIndex == 1 {
                        await productModel.getStoreOwnerBuyProducts(storeId: storeId, productFetchOption: productFetchOption)
                    }
                }
            }
            .onChange(of: productFetchOption) { _ in
                proxy.scrollTo("header", anchor: .top)
                Task {
                    if selectedIndex == 0 {
                        await productModel.getStoreOwnerSellProducts(storeId: storeId, productFetchOption: productFetchOption)
                    } else if selectedIndex == 1 {
                        await productModel.getStoreOwnerBuyProducts(storeId: storeId, productFetchOption: productFetchOption)
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getStoreInfo() {
        NetworkService.shared.storeService.getStoreInfo(storeId: storeId) { result in
            switch result {
            case .success(let response):
                if let responseData = response?.data {
                    DispatchQueue.main.async {
                        self.storeInfo = responseData
                    }
                }
            default:
                break
            }
        }
    }
}
