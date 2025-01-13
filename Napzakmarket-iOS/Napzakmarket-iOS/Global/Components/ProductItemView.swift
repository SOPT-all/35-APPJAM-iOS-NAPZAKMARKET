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
    
    //MARK: - Properties
    
    let product: ProductDummyModel
    
    //MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading) {
            productMain
            productInfo
        }
        .frame(height: 254)
    }
}

extension ProductItemView {
    
    //MARK: - Properties
    
    private var productMain: some View {
        ZStack(alignment: .top) {
            //추후 Image() 요소로 변경 예정
            Rectangle()
                .fill(Color.napzakGrayScale(.gray300))
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
                if product.isLikeButtonExist {
                    likeButton
                }
            }
        }
    }
    
    private var likeButton: some View {
        Button {
            print("Like Button tapped")
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
    }
}
