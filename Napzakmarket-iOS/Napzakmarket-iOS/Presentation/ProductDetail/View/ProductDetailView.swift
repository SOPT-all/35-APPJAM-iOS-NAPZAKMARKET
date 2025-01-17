//
//  ProductDetailView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    //MARK: - Property Wrappers
    
    @State var currentPage: Int = 0
    @State var showToast = false
    
    //MARK: - Properties
    
    @ObservedObject var product = ProductDetailModel.dummyBuyProductDetail()
    
    //MARK: - Main Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                navigarionBar
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        productImagePageView
                        productInfo
                        divider
                        productDescription
                        if product.productDetail.productType == .sell {
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
            bottomView
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

extension ProductDetailView {
    
    //MARK: - UIProperties
    
    private var navigarionBar: some View {
        HStack {
            Button {
                print("back button tapped")
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
            ForEach(product.productPhotoList.indices, id: \.self) { i in
                //Image 리소스로 변경 예정핑!!!!!ㅋ
                Rectangle()
                    .fill(i % 2 == 0 ? .red : .blue)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            switch product.productDetail.productType {
            case .buy:
                Image(.imgTagBuy)
            case .sell:
                Image(.imgTagSell)
            }
            Spacer()
            Text("\(product.productDetail.uploadTime)")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
            Capsule()
                .fill(Color.napzakGrayScale(.gray200))
                .frame(width: 1, height: 10)
                .padding(.horizontal, 7)
            Image(.icView)
                .padding(.trailing, 2)
            Text("\(product.productDetail.viewCount)")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
                .padding(.trailing, 4)
            Image(.icHeartSm)
                .padding(.trailing, 2)
            Text("\(product.productDetail.interestCount)")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
        }
        .padding(.bottom, 16)
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 0){
            header
            Text("\(product.productDetail.genreName)")
                .font(.napzakFont(.body1Bold16))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 4)
            Text("\(product.productDetail.productName)")
                .font(.napzakFont(.title6Medium18))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
                .padding(.bottom, 16)
            HStack(spacing: 8){
                if product.productDetail.isPriceNegotiable {
                    Image(.imgTagPriceLg)
                }
                Text(product.productDetail.productType == .sell ?  "\(String(product.productDetail.price).convertPrice(maxPrice: 1_000_000))원" : "\(String(product.productDetail.price).convertPrice(maxPrice: 1_000_000))원대" )
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
        Text("\(product.productDetail.description)".forceCharWrapping)
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
            switch product.productDetail.productCondition {
            case .unopened:
                Image(.imgDetailConditionUnopen)
            case .excellent:
                Image(.imgDetailConditionGood)
            case .slightlyUsed:
                Image(.imgDetailConditionLightuse)
            case .used:
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
            if product.productDetail.isDeliveryIncluded {
                Text("포함")
                    .font(.napzakFont(.body2SemiBold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
            } else {
                if product.productDetail.standardDeliveryFee != 0 {
                    Text("일반")
                        .font(.napzakFont(.body6Medium14))
                        .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                        .foregroundStyle(Color.napzakGrayScale(.gray700))
                        .padding(.trailing, 6)
                    Text("\(String(product.productDetail.standardDeliveryFee).convertPrice(maxPrice: 1_000_000))원")
                        .font(.napzakFont(.body2SemiBold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                }
                if product.productDetail.standardDeliveryFee != 0 && product.productDetail.halfDeliveryFee != 0{
                    Rectangle()
                        .fill(Color.napzakGrayScale(.gray200))
                        .frame(width: 1, height: 14)
                        .padding(.horizontal, 13)
                }
                if product.productDetail.halfDeliveryFee != 0 {
                    Text("반값/알뜰")
                        .font(.napzakFont(.body6Medium14))
                        .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                        .foregroundStyle(Color.napzakGrayScale(.gray700))
                        .padding(.trailing, 6)
                    Text("\(String(product.productDetail.halfDeliveryFee).convertPrice(maxPrice: 1_000_000))원")
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
            HStack(alignment: .center) {
                Image(.imgProfileSm)
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(product.storeInfo.nickname)")
                        .font(.napzakFont(.body1Bold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                    HStack(alignment: .center, spacing: 0) {
                        Text("상품")
                            .font(.napzakFont(.caption3Medium12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                            .foregroundStyle(Color.napzakGrayScale(.gray700))
                            .padding(.trailing, 2)
                        Text("\(product.storeInfo.totalProducts)개")
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
                        Text("\(product.storeInfo.totalTransactions)건")
                            .font(.napzakFont(.caption3Medium12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                            .foregroundStyle(Color.napzakPurple(.purple30))
                    }
                }
            }
        }
        .padding(.top, 31)
        .padding(.horizontal, 20)
        .padding(.bottom, 192)
    }
    
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .frame(height: 1)
                .overlay(Color.napzakGrayScale(.gray200))
            HStack(spacing: 16) {
                Button {
                    print("좋아요 버튼 선택")
                    product.toggleLike()
                    if product.isInterested {
                        showToastMessage()
                    }
                } label: {
                    product.isInterested ? Image(.btnDetailLikeSelect) : Image(.btnDetailLike)
                }
                Button {
                    print("채팅하기 버튼 선택")
                } label: {
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
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    ProductDetailView()
}
