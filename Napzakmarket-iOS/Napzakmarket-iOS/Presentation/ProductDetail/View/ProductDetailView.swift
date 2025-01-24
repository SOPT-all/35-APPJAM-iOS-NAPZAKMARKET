//
//  ProductDetailView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

import Kingfisher

struct ProductDetailView: View {
    
    //MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel

    @StateObject var product = ProductDetailModel()

    @State private var currentPage = 0
    @State var showToast = false
    
    @Binding var isChangedInterest: Bool?
    
    //MARK: - Properties
    
    let productId: Int
    let screenWidth = UIScreen.main.bounds.width

    //MARK: - Main Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                navigationBar
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        productImagePageView
                        productInfo
                        divider
                        productDescription
                        if product.productDetail?.tradeType == .sell {
                            productConditions
                            divider
                            productDeliveryFee
                        }
                        Divider()
                            .frame(height: 8)
                            .overlay(Color.napzakGrayScale(.gray50))
                        marketInfo
                    }
                }
                if showToast {
                    toastView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1)
                        .animation(.spring(), value: showToast)
                }
            }
            if !(product.productDetail?.isOwnedByCurrentUser ?? false) {
                bottomView
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: [.bottom])
        .onAppear {
            tabBarState.isTabBarHidden = true
            Task {
                await product.getProductDetail(productId: productId)
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 100 {
                        dismiss()
                        dismiss()
                        tabBarState.isTabBarHidden = false
                    }
                }
        )
    }
}

extension ProductDetailView {
    
    //MARK: - UIProperties
    
    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
                dismiss()
                tabBarState.isTabBarHidden = false
            } label: {
                Image(.icBack)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .padding(.top, 4)
            }
            Spacer()
        }
        .background(Color.napzakGrayScale(.white))
        .frame(height: 54)
    }
    
    
    private var productImagePageView: some View {
        TabView(selection: $currentPage) {
            ForEach(product.productPhotoList) { photo in
                ZStack(alignment: .bottom) {
                    if let url = URL(string: photo.photoUrl) {
                        KFImage(url)
                            .placeholder {
                                Rectangle()
                                    .fill(Color.napzakGrayScale(.gray300))
                                    .frame(width: screenWidth, height: screenWidth)
                            }
                            .retry(maxCount: 3, interval: .seconds(5))
                            .onFailure { error  in
                                print("failure: \(error.localizedDescription)")
                            }
                            .resizable()
                            .frame(width: screenWidth, height: screenWidth)
                    } else {
                        Rectangle()
                            .fill(Color.napzakGrayScale(.gray300))
                            .frame(width: screenWidth, height: screenWidth)
                    }
                    
                    LinearGradient(colors: [
                        Color.napzakGradient(.gradient2FirstColor),
                        Color.napzakGradient(.gradient2SecondColor)
                    ], startPoint: .top, endPoint: .bottom)
                    .frame(height: 175)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            product.productDetail?.tradeType == .buy ? Image(.imgTagBuy) : Image(.imgTagSell)
            Spacer()
            Text("\(product.productDetail?.uploadTime ?? "")")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
            Capsule()
                .fill(Color.napzakGrayScale(.gray200))
                .frame(width: 1, height: 10)
                .padding(.horizontal, 7)
            Image(.icView)
                .padding(.trailing, 2)
            Text("\(product.productDetail?.viewCount ?? Int())")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
                .padding(.trailing, 4)
            Image(.icHeartSm)
                .padding(.trailing, 2)
            Text("\(product.productDetail?.interestCount ?? Int())")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
        }
        .padding(.bottom, 16)
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 0){
            header
            Text("\(product.productDetail?.genreName ?? "")")
                .font(.napzakFont(.body1Bold16))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 4)
            Text("\(product.productDetail?.productName ?? "")")
                .font(.napzakFont(.title6Medium18))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
                .padding(.bottom, 16)
            HStack(spacing: 8){
                if product.productDetail?.isPriceNegotiable == true {
                    Image(.imgTagPriceLg)
                }
                Text(product.productDetail?.tradeType == .sell ?  "\(String(product.productDetail?.price ?? 0).convertPrice(maxPrice: 1_000_000))원" : "\(String(product.productDetail?.price ?? 0).convertPrice(maxPrice: 1_000_000))원대")
                    .font(.napzakFont(.title2Bold20))
                    .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
    
    private var divider: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color.napzakGrayScale(.gray100))
            .padding(20)
    }
    
    private var productDescription: some View {
        Text("\(product.productDetail?.description ?? "")".forceCharWrapping)
            .font(.napzakFont(.body3Medium16))
            .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 31)
    }
    
    private var productConditions: some View {
        HStack(alignment: .center) {
            Text("상품 상태")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
            Spacer()
            switch product.productDetail?.productCondition {
            case .new:
                Image(.imgDetailConditionUnopen)
            case .likeNew:
                Image(.imgDetailConditionGood)
            case .slightlyUsed:
                Image(.imgDetailConditionLightuse)
            default:
                Image(.imgDetailConditionHeavyuse)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var productDeliveryFee: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("배송비")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
            Spacer()
            if ((product?.productDetail.isDeliveryIncluded) == true) {
                Text("포함")
                    .font(.napzakFont(.body2SemiBold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
            } else {
                if product.productDetail?.standardDeliveryFee != 0 {
                    Text("일반")
                        .font(.napzakFont(.body6Medium14))
                        .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                        .foregroundStyle(Color.napzakGrayScale(.gray700))
                        .padding(.trailing, 6)
                    Text("\(String(product.productDetail?.standardDeliveryFee ?? 0).convertPrice(maxPrice: 1_000_000))원")
                        .font(.napzakFont(.body2SemiBold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                }
                if product.productDetail?.standardDeliveryFee != 0 && product.productDetail?.halfDeliveryFee != 0{
                    Rectangle()
                        .fill(Color.napzakGrayScale(.gray200))
                        .frame(width: 1, height: 14)
                        .padding(.horizontal, 13)
                }
                if product.productDetail?.halfDeliveryFee != 0 {
                    Text("반값/알뜰")
                        .font(.napzakFont(.body6Medium14))
                        .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                        .foregroundStyle(Color.napzakGrayScale(.gray700))
                        .padding(.trailing, 6)
                    Text("\(String(product.productDetail?.halfDeliveryFee ?? 0).convertPrice(maxPrice: 1_000_000))원")
                        .font(.napzakFont(.body2SemiBold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 31)
    }
    
    private var marketInfo: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("마켓 정보")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
            NavigationLink(destination: MarketView(storeId: product.storeInfo?.userId ?? Int())){
                HStack(alignment: .center) {
                    Image(.imgProfileSm)
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("\(product.storeInfo?.nickname ?? "")")
                            .font(.napzakFont(.body1Bold16))
                            .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                        HStack(alignment: .center, spacing: 0) {
                            Text("상품")
                                .font(.napzakFont(.caption3Medium12))
                                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                                .foregroundStyle(Color.napzakGrayScale(.gray700))
                                .padding(.trailing, 2)
                            Text("\(product.storeInfo?.totalProducts ?? Int())개")
                                .font(.napzakFont(.caption3Medium12))
                                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                                .foregroundStyle(Color.napzakPurple(.purple30))
                            Circle()
                                .fill(Color.napzakGrayScale(.gray700))
                                .frame(width: 2, height: 2)
                                .padding(.horizontal, 4)
                            Text("거래내역")
                                .font(.napzakFont(.caption3Medium12))
                                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                                .foregroundStyle(Color.napzakGrayScale(.gray700))
                                .padding(.trailing, 2)
                            Text("\(product.storeInfo?.totalTransactions ?? Int())건")
                                .font(.napzakFont(.caption3Medium12))
                                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                                .foregroundStyle(Color.napzakPurple(.purple30))
                        }
                    }
                }
            }
        }
        .padding(.top, 31)
        .padding(.horizontal, 20)
        .padding(.bottom, product.productDetail?.isOwnedByCurrentUser ?? Bool() ? 85 : 192)
    }
    
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .frame(height: 1)
                .overlay(Color.napzakGrayScale(.gray200))
            HStack(spacing: 16) {
                Button {
                    print("좋아요 버튼 선택")
                    isChangedInterest?.toggle()
                    Task {
                        await product.postInterestToggle(productId: productId)
                    }
                    if product.isInterested == false {
                        showToastMessage()
                    }
                } label: {
                    product.isInterested ? Image(.btnDetailLikeSelect) : Image(.btnDetailLike)
                }
                NavigationLink(destination: ChatView(productId: productId)) {
                   HStack {
                       Spacer()
                       Text("채팅하기")
                           .font(.napzakFont(.body1Bold16))
                           .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                           .foregroundStyle(Color.napzakGrayScale(.white))
                       Spacer()
                   }
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color.napzakGrayScale(.gray900))
                           .frame(height: 52)
                   )
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 35)
        }
        .background(Color.napzakGrayScale(.white))
    }
    
    private var toastView: some View {
        ZStack {
            HStack(alignment: .center, spacing: 8) {
                Image(.icHeartToast)
                Text("상품을 찜했어요!")
                    .font(.napzakFont(.body6Medium14))
                    .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                    .foregroundStyle(Color.napzakGrayScale(.white))
                Spacer()
            }
            .frame(height: 44)
            .padding(.leading, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.napzakTransparency(.black70))
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 113)
    }
    
    //MARK: - Private Func
    
    private func showToastMessage() {
        Task {
            withAnimation {
                showToast = true
            }
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            withAnimation {
                showToast = false
            }
        }
    }
}
