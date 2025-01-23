//
//  ChatModel.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/24/25.
//

import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var chatInfo: ChatInfoData?
    
    private let productService: ProductServiceProtocol
    private let productId: Int
    
    init(productId: Int, productService: ProductServiceProtocol = ProductService()) {
        self.productId = productId
        self.productService = productService
    }
}
