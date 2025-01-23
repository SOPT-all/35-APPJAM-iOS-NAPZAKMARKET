//
//  ProductItemView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

import Kingfisher

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
            if let url = URL(string: product.photo) {
                KFImage(url)
                    .placeholder {
                        Rectangle()
                            .fill(Color.napzakGrayScale(.gray300))
                            .frame(width: width, height: width)
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onFailure { error  in
                        print("failure: \(error.localizedDescription)")
                    }
                    .resizable()
                    .frame(width: width, height: width)
            } else {
                Rectangle()
                    .fill(Color.napzakGrayScale(.gray300))
                    .frame(width: width, height: width)
            }
            
            HStack(alignment: .bottom) {
                switch product.tradeType {
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
                if !product.isOwnedByCurrentUser {
                    likeButton
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: width, height: width)
    }
    
    private var likeButton: some View {
        Button {
            // TODO: - 좋아요 API 연결
            print("Like Button tapped")
            
        } label: {
            product.isInterested ? Image(.icnHeartListSelect) : Image(.icnHeartList)
        }
        .padding(.trailing, 6)
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(product.genreName)
                    .font(.napzakFont(.caption1Bold12))
                    .applyNapzakTextStyle(napzakFontStyle: .caption1Bold12)
                Spacer()
            }
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
                Text(product.tradeType == .sell ? "\(String(product.price).convertPrice(maxPrice: 1_000_000))원" : "\(String(product.price).convertPrice(maxPrice: 1_000_000))원대")
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
