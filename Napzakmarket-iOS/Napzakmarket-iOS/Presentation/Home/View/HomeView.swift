//
//  HomeView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    
    @State private var currentPage: Int = 0
    private let bannerImages = ["img_banner_1", "img_banner_2"]
    
    @State var recomendedProducts = ProductModel.recommendedDummyList()
    @State var sellProducts = ProductModel.sellDummyList()
    @State var buyProducts = ProductModel.buyDummyList()
    
    let width = (UIScreen.main.bounds.width - 55) / 2
    
    // MARK: - Main Body
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LogoView()
                NoticeCarouselView(currentPage: $currentPage, bannerImages: bannerImages)
                
                // 첫번째 섹션
                VStack(spacing: 16) {
                    RecommendedItemsTitleView()
                    ProductScrollView(width: width - 10, products: $recomendedProducts)
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
                    
                    MostLikedProductsView(width: width, products: $sellProducts)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 50)
                
                
                // 세번째 섹션
                VStack(spacing: 16) {
                    ZStack(alignment: .bottom) {
                        HStack {
                            Spacer()
                            Image(.imgHome3)
                        }
                        .padding(.trailing, 20)
                        
                        CommonTitleView(
                            title: "다른 유저들은 뭐 찾고 있을까요?",
                            subTitle: "덕심 가득한 리스트에서 취향을 나눠보세요.",
                            alignment: .left
                        )
                        .padding(.leading, 20)
                    }
                    
                    ProductScrollView(width: width - 10, products: $buyProducts)
                        .padding(.leading, 20)
                }
                .padding(.top, 60)
                .padding(.bottom, 75)
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
        let bannerImages: [String]
        
        // MARK: - Main Body
        
        var body: some View {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<bannerImages.count, id: \.self) { index in
                        Image(bannerImages[index])
                            .resizable()
                            .scaledToFill()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 230)
                
                HStack(spacing: 8) {
                    ForEach(0..<bannerImages.count, id: \.self) { index in
                        Circle()
                            .fill(
                                index == currentPage ? Color.napzakPurple(.purple30) : Color.napzakGrayScale(.gray400)
                            )
                            .frame(width: 7, height: 7)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    currentPage = index
                                }
                            }
                    }
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
        
        private let column = [
            GridItem(.flexible())
        ]
        
        //MARK: - Main Body
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: column, spacing: 16) {
                    ForEach(products) {
                        product in
                        ProductItemView(
                            product: product,
                            width: width - 10
                        )
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
        
        private let columns = [
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible())
        ]
        
        //MARK: - Main Body
        
        var body: some View {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products.prefix(4)) { product in
                    ProductItemView(
                        product: product,
                        width: width
                    )
                }
            }
        }
    }
    
}
