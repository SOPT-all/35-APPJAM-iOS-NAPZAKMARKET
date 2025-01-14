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

    //MARK: - Properties
    
    private let sellProducts = ProductDummyModel.sellDummy
    private let buyProducts = ProductDummyModel.buyDummy
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
    
    private var productScrollView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                let products = selectedIndex == 0 ? sellProducts : buyProducts
                ForEach(products, id: \.self) { product in
                    ProductItemView(product: product)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
