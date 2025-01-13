//
//  SearchView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/6/25.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - Properties

    let products = ProductDummyModel.dummy

    let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]    
    
    //MARK: - Main Body
    var body: some View {
        VStack {
            productScrollView
        }
    }
}

extension SearchView {
    
    //MARK: - Properties
    
    private var productScrollView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products, id: \.self) { product in
                    ProductItemView(product: product)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
