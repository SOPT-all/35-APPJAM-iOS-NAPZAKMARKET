//
//  ProductItemView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

enum ProductType {
    case buy
    case sell
}

struct ProductItemView: View {
    
    @ObservedObject var product: ProductModel
    
    //MARK: - Properties
    
    let width: CGFloat
    
    //MARK: - Main Body
    
    var body: some View {
        VStack() {
            productMain
            productInfo
        }
    }
}

extension ProductItemView {
    
    //MARK: - Properties
    
    private var productMain: some View {
        ZStack(alignment: .top) {
            //추후 Image() 요소로 변경 예정
            Rectangle()
                .fill(Color.napzakGrayScale(.gray300))
                .frame(width: width, height: width)
            HStack(alignment: .bottom) {
                switch product.productType {
                case .buy:
                    Image(.imgTagBuy)
                        .resizable()
                        .frame(width: 47, height: 27)
                case .sell:
                    Image(.imgTagSell)
                        .resizable()
                        .frame(width: 47, height: 27)
                }
                Spacer()
                if product.isOwnedByCurrentUser {
                    likeButton
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: width, height: width)
    }
    
    private var likeButton: some View {
        Button {
            print("Like Button tapped")
            product.toggleLike()
        } label: {
            product.isLiked ? Image(.icnHeartListSelect) : Image(.icnHeartList)
        }
        .padding(.trailing, 6)
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.genreName)
                .font(.napzakFont(.caption1Bold12))
                .applyNapzakTextStyle(napzakFontStyle: .caption1Bold12)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            Text(product.productName)
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray800))
                .lineLimit(1)
            HStack {
                if let isPriceNegotiable = product.isPriceNegotiable {
                    if isPriceNegotiable {
                        Image(.imgTagPriceSm)
                    }
                }
                Text(product.price)
                    .font(.napzakFont(.body1Bold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
            }
            Text(product.uploadTime)
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .foregroundStyle(Color.napzakGrayScale(.gray400))
        }
        .frame(width: width)
    }
}

#Preview {
    let mock = ProductModel(
        id: 1,
        isLiked: true,
        genreName: "산리오",
        productName: "딸기 마이멜로디 마스코트 인형",
        price: "35,000원",
        uploadTime: "3시간 전",
        productType: .sell,
        isPriceNegotiable: false,
        isOwnedByCurrentUser: true
    )
    
    ProductItemView(
        product: mock,
        width: 160
    )
    .frame(height: 254)
}
