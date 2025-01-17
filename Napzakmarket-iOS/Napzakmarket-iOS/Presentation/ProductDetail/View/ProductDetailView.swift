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
    
    //MARK: - Properties
    
    
    
    //MARK: - Main Body
    
    var body: some View {
        VStack(spacing: 0) {
            navigarionBar
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    productImagePageView
                    productInfo
                    divider
                    productDescription
                    productConditions
                    divider
                    productDeliveryFee
                    Divider()
                        .frame(height: 8)
                        .overlay(Color.napzakGrayScale(.gray50))
                    marketInfo
                }
            }
            bottomView
        }
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
            }
            Spacer()
        }
        .background(Color.napzakGrayScale(.white))
        .frame(height: 54)
    }
    
    
    private var productImagePageView: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<5) { index in
                //Image 리소스로 변경 예정핑!!!!!ㅋ
                Rectangle()
                    .fill(index % 2 == 0 ? .red : .blue)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.imgTagSell)
            Spacer()
            Text("1시간 전")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
            Capsule()
                .fill(Color.napzakGrayScale(.gray200))
                .frame(width: 1, height: 10)
                .padding(.horizontal, 7)
            Image(.icView)
                .padding(.trailing, 2)
            Text("27")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
                .padding(.trailing, 4)
            Image(.icHeartSm)
                .padding(.trailing, 2)
            Text("444444")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
        }
        .padding(.bottom, 16)
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 0){
            header
            Text("산리오")
                .font(.napzakFont(.body1Bold16))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
                .padding(.bottom, 4)
            Text("딸기 마이멜로디 마스코트 인형")
                .font(.napzakFont(.title6Medium18))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
                .padding(.bottom, 16)
            Text("35,000원")
                .font(.napzakFont(.title2Bold20))
                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
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
        Text("딸기 마멜 인형 판매합니다!\n일본에서 출시되자마자 인기 많았던 딸기 마스코트 인형입니다. 개봉 후 장식장에만 보관해놨어요!\n편하게 둘러보시고 채팅 주세요! (남은 수량: 1개)".forceCharWrapping)
            .font(.napzakFont(.body3Medium16))
            .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 35)
    }
    
    private var productConditions: some View {
        HStack(alignment: .center) {
            Text("상품 상태")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
            Spacer()
            Image(.imgDetailConditionUnopen)
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
            Text("일반")
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray700))
                .padding(.trailing, 6)
            Text("3,800원")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            Rectangle()
                .fill(Color.napzakGrayScale(.gray200))
                .frame(width: 1, height: 14)
                .padding(.horizontal, 13)
            Text("반값/알뜰")
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray700))
                .padding(.trailing, 6)
            Text("1,800원")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
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
                VStack {
                    Text("납작한 박어진")
                        .font(.napzakFont(.body1Bold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray900))
                    HStack(alignment: .center, spacing: 0) {
                        Text("상품")
                            .font(.napzakFont(.caption3Medium12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                            .foregroundStyle(Color.napzakGrayScale(.gray700))
                            .padding(.trailing, 2)
                        Text("5개")
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
                        Text("3건")
                            .font(.napzakFont(.caption3Medium12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                            .foregroundStyle(Color.napzakPurple(.purple30))
                    }
                }
            }
        }
        .padding(.top, 31)
        .padding(.horizontal, 20)
        .padding(.bottom, 85)
    }
    
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
                .frame(height: 1)
                .overlay(Color.napzakGrayScale(.gray200))
            HStack(spacing: 16) {
                Button {
                    print("좋아요 버튼 선택")
                } label: {
                    Image(.btnDetailLike)
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
    }
}

#Preview {
    ProductDetailView()
}
