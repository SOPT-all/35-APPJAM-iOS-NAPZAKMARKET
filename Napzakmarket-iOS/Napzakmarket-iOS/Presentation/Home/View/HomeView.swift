//
//  HomeView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

import Kingfisher

struct HomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var homeModel = HomeModel()
    
    @State private var currentPage: Int = 1
    @State var isInterestChanged: Bool? = false
    @State var isInterestChangedInPopularSection: Bool? = false
    
    private let width = (UIScreen.main.bounds.width - 55) / 2
    
    // MARK: - Main Body
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    LogoView()
                    NoticeCarouselView(currentPage: $currentPage, banneres: $homeModel.banners)
                    
                    // 첫번째 섹션
                    VStack(spacing: 16) {
                        RecommendedItemsTitleView()
                        ProductScrollView(width: width - 10, products: $homeModel.personalProducts, isInterestChanged: $isInterestChanged)
                    }
                    .padding(.leading, 20)
                    
                    // 두번째 섹션
                    VStack(spacing: 16) {
                        ZStack(alignment: .bottom) {
                            HStack {
                                Image(.imgHome2)
                                Spacer()
                            }
                            
                            CommonTitleView(
                                title: "지금 가장 많이 찜한 납작템",
                                subTitle: "놓치면 아쉬운 인기아이템들을 구경해볼까요?",
                                alignment: .right
                            )
                            .padding(.trailing, 20)
                        }
                        
                        MostLikedProductsView(width: width, products: $homeModel.popularSellProducts, isInterestChangedInPopularSection: $isInterestChangedInPopularSection)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    .background(Color.napzakGrayScale(.gray50))
                    .padding(.top, 30)
                    
                    // 세번째 섹션
                    VStack(spacing: 16) {
                        ZStack(alignment: .bottom) {
                            HStack {
                                Spacer()
                                Image(.imgHome3)
                            }
                            .padding(.trailing, 20)
                            
                            CommonTitleView(
                                title: "다른 유저들은 뭘 찾고 있을까요?",
                                subTitle: "덕심 가득한 리스트에서 취향을 나눠보세요.",
                                alignment: .left
                            )
                            .padding(.leading, 20)
                        }
                        
                        ProductScrollView(width: width - 10, products: $homeModel.recommendedBuyProducts, isInterestChanged: $isInterestChanged)
                            .padding(.leading, 20)
                    }
                    .padding(.top, 26)
                    .padding(.bottom, 75)
                }
            }
        }
        .onAppear {
            Task {
                await homeModel.fetchBanners()
                await homeModel.fetchPersonalProducts()
                await homeModel.fetchPopularSellProducts()
                await homeModel.fetchRecommendedBuyProducts()
            }
        }
        .onChange(of: isInterestChanged) { _ in
            Task {
                await homeModel.fetchPersonalProducts()
                await homeModel.fetchRecommendedBuyProducts()
            }
        }
        .onChange(of: isInterestChangedInPopularSection) { _ in
            Task {
                await homeModel.fetchPopularSellProducts()
            }
        }
    }
    
}



extension HomeView {
    
    private struct LogoView: View {
        
        // MARK: - Main Body
        
        var body: some View {
            HStack() {
                Image(.imgLogo)
                    .padding(.vertical, 15)
                    .padding(.leading, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
        }
    }
    
    private struct NoticeCarouselView: View {
        
        // MARK: - Properties
        @Binding var currentPage: Int
        @Binding var banneres: [Banner]
        
        @State private var timerPaused = false
        private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        
        private var displayBanners: [Banner] {
            guard !banneres.isEmpty else { return [] }
            return [banneres.last!] + banneres + [banneres.first!]
        }
        
        // MARK: - Main Body
        
        var body: some View {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<displayBanners.count, id: \.self) { index in
                        if let url = URL(string: displayBanners[index].bannerPhoto) {
                            KFImage(url)
                                .resizable()
                                .placeholder {
                                    Image(.imgOnboardingEmpty)
                                }
                                .retry(maxCount: 3, interval: .seconds(5))
                                .onFailure { error  in
                                    print("failure: \(error.localizedDescription)")
                                }
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .tag(index)
                            
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 230)
                .onChange(of: currentPage) { newValue in
                    Task {
                        try? await Task.sleep(nanoseconds: 300_000_000)
                        
                        withTransaction(Transaction(animation: .none)) {
                            if newValue == displayBanners.count - 1 {
                                currentPage = 1
                                
                            } else if newValue == 0 {
                                currentPage = displayBanners.count - 2
                            }
                        }
                    }
                }
                .onReceive(timer) { _ in
                    guard !timerPaused else { return }
                    if !timerPaused {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if currentPage == displayBanners.count - 1 {
                                currentPage = 1
                            } else {
                                currentPage += 1
                            }
                        }
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(0..<banneres.count, id: \.self) { index in
                        Circle()
                            .fill(
                                (index == (currentPage - 1) % banneres.count) ? Color.napzakPurple(.purple30) : Color.napzakGrayScale(.gray400)
                            )
                            .frame(width: 7, height: 7)
//                            .onTapGesture {
//                                withAnimation(.easeInOut) {
//                                    currentPage = index
//                                }
//                            }
                    }
                }
                
            }
            .onAppear {
                if banneres.count > 1 && currentPage == 0 {
                    currentPage = 1
                }
            }
        }
        
    }
    
    private struct RecommendedItemsTitleView: View {
        
        // MARK: - Main Body
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(alignment: .top , spacing: 0) {
                    Text("납자기님을 위한 맞춤")
                        .font(.napzakFont(.title5SemiBold18))
                        .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                    
                    Text("PICK!")
                        .font(.napzakFont(.title5SemiBold18))
                        .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                        .foregroundStyle(Color.napzakPurple(.purple30))
                        .padding(.leading, 4)
                    
                    Image(.imgHome1)
                        .padding(.leading, 6)
                        .offset(y: -2)
                    Spacer()
                }
                
                HStack {
                    Text("납자기님의 취향에 딱 맞는 아이템들을 모아봤어요.")
                        .font(.napzakFont(.body5SemiBold14))
                        .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                    
                    Spacer()
                }
            }
            .padding(.top, 43)
        }
        
    }
    
    private struct ProductScrollView: View {
        
        // MARK: - Properties
        
        let width: CGFloat
        
        @Binding var products: [ProductModel]
        @Binding var isInterestChanged: Bool?

        private let column = [
            GridItem(.flexible())
        ]
        
        //MARK: - Main Body
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: column, spacing: 16) {
                    ForEach(products) {
                        product in
                        NavigationLink(destination: ProductDetailView(isChangedInterest: $isInterestChanged, productId: product.id)) {
                            ProductItemView(
                                product: product,
                                width: width - 10
                            )
                        }
                    }
                }
                .padding(.trailing, 20)
            }
        }
    }
    
    private struct CommonTitleView: View {
        
        enum CustomAlignment {
            case left
            case right
        }
        
        let title: String
        let subTitle: String
        let alignment: CustomAlignment
        
        //MARK: - Main Body
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(alignment: .top , spacing: 0) {
                    if alignment == .right {
                        Spacer()
                    }
                    Text(title)
                        .font(.napzakFont(.title5SemiBold18))
                        .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                    if alignment == .left {
                        Spacer()
                    }
                }
                
                HStack {
                    if alignment == .right {
                        Spacer()
                    }
                    Text(subTitle)
                        .font(.napzakFont(.body5SemiBold14))
                        .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                    if alignment == .left {
                        Spacer()
                    }
                }
            }
        }
    }
    
    struct MostLikedProductsView: View {
        
        // MARK: - Properties
        
        let width: CGFloat
        
        @Binding var products: [ProductModel]
        @Binding var isInterestChangedInPopularSection: Bool?

        private let columns = [
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible())
        ]
        
        //MARK: - Main Body
        
        var body: some View {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products.prefix(4)) { product in
                    NavigationLink(destination: ProductDetailView(isChangedInterest: $isInterestChangedInPopularSection, productId: product.id)) {
                        ProductItemView(
                            product: product,
                            width: width
                        )
                    }
                }
            }
        }
    }
    
}
