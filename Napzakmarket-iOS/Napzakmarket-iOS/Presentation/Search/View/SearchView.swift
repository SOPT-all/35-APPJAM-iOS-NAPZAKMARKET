//
//  SearchView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - Property Wrappers
    
    @State var selectedIndex = 0
    @State var sellProducts = ProductDummyModel.sellDummy
    @State var buyProducts = ProductDummyModel.buyDummy
    
    //MARK: - Properties
    
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    //MARK: - Main Body
    
    var body: some View {
        VStack {
            searchButton
            NZSegmentedControl(
                selectedIndex: $selectedIndex,
                tabs: ["팔아요", "구해요"],
                spacing: 15
            )
            productScrollView
        }
    }
}

extension SearchView {
    
    //MARK: - UI Properties
    
    private var searchButton: some View {
        Button {
            print("searchButtonTapped")
        } label: {
            HStack {
                Text("어떤 아이템을 찾고 계신가요?")
                    .font(.napzakFont(.body5SemiBold14))
                    .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                    .foregroundStyle(Color.napzakGrayScale(.gray400))
                Spacer()
                Image(.iconSearch)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 44)
        .background(Color.napzakGrayScale(.gray100))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
    
    private var productScrollView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                let products = selectedIndex == 0 ? sellProducts : buyProducts
                ForEach(products.indices, id: \.self) { i in
                    ProductItemView(
                        toggleLike: {
                            products == sellProducts ?
                            sellProducts[i].isLiked.toggle() :
                            buyProducts[i].isLiked.toggle()
                        },
                        product: products[i]
                    )
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
