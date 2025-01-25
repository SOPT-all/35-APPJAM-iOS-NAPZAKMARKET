//
//  ChatView.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/16/25.
//

import SwiftUI
import Kingfisher

struct ChatView: View {
    @EnvironmentObject private var tabBarState: TabBarStateModel
    @Environment(\.dismiss) private var dismiss
    @State private var messageText: String = ""
    
    @State private var chatInfo: ChatInfoData?
    
    let productId: Int
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            productInfoHeader
            chatContent
            messageInputView
        }
        .navigationBarHidden(true)
        .onAppear {
            tabBarState.isTabBarHidden = true
            fetchChatInfo()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 60 {
                        dismiss()
                    }
                }
        )
    }
    
    private func fetchChatInfo() {
        NetworkService.shared.productService.getChatInfo(productId: productId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    chatInfo = response?.data
                }
            default:
                break
            }
        }
    }
}

// MARK: - Navigation Bar
private extension ChatView {
    var navigationBar: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(.icBack)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.top, 4)
                }
                
                Text(chatInfo?.nickname ?? "")
                    .font(.napzakFont(.title5SemiBold18))
                    .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                    .foregroundColor(Color.napzakGrayScale(.gray900))
                    .frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(width: 54)
            }
            
            Divider()
                .foregroundColor(Color.napzakGrayScale(.gray100))
        }
    }
}

// MARK: - Product Info
private extension ChatView {
    var productInfoHeader: some View {
        VStack(spacing: 0) {
            HStack {
                if let url = URL(string: chatInfo?.firstPhoto ?? "") {
                    KFImage(url)
                        .placeholder {
                            ProgressView()
                                .frame(width: 54, height: 54)
                        }
                        .retry(maxCount: 3, interval: .seconds(1))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                } else {
                    Image(.imgProfileMd)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        switch chatInfo?.tradeType {
                        case .buy:
                            Text("구해요")
                                .font(.napzakFont(.body4Bold14))
                                .applyNapzakTextStyle(napzakFontStyle: .body4Bold14)
                                .foregroundColor(Color.napzakGrayScale(.gray900))
                            
                        default:
                            Text("팔아요")
                                .font(.napzakFont(.body4Bold14))
                                .applyNapzakTextStyle(napzakFontStyle: .body4Bold14)
                                .foregroundColor(Color.napzakPurple(.purple30))
                        }
                        
                        Text(chatInfo?.title ?? "")
                            .font(.napzakFont(.body6Medium14))
                            .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                            .foregroundColor(Color.napzakGrayScale(.gray900))
                            .lineLimit(1)
                    }
                    
                    HStack(spacing: 4) {
                        switch chatInfo?.tradeType {
                        case .buy:
                            Image("img_tag_price_sm")
                                .frame(width: 51, height: 23)
                            Text("\(chatInfo?.price ?? 0)원대")
                                .font(.napzakFont(.body1Bold16))
                                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                                .foregroundColor(Color.napzakGrayScale(.gray900))
                        default:
                            Text("\(chatInfo?.price ?? 0)원")
                                .font(.napzakFont(.body1Bold16))
                                .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                                .foregroundColor(Color.napzakGrayScale(.gray900))
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            .background(.white)
            
            Divider()
        }
    }
}

// MARK: - Chat Content
private extension ChatView {
    var chatContent: some View {
        ZStack {
            Color.napzakGrayScale(.gray50)
                .ignoresSafeArea()
                .padding(.bottom, -30)
            
            VStack {
                HStack(spacing: 12) {
                    Image("img_chat")
                        .resizable()
                        .frame(width: 225, height: 221)
                }
            }
        }
    }
}

// MARK: - Message Input
private extension ChatView {
    var messageInputView: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.top, 16)
            
            HStack(spacing: 14) {
                Button(action: {
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.napzakGrayScale(.gray600))
                        .frame(width: 13, height: 13)
                }
                .frame(width: 40, height: 40)
                .background(Color.napzakGrayScale(.gray100))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                TextField("메시지를 입력하세요", text: .constant(""))
                    .font(.napzakFont(.body6Medium14))
                    .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                    .foregroundColor(Color.napzakGrayScale(.gray400))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 42)
                    .background(Color.napzakGrayScale(.gray100))
                    .frame(width: 287, height: 42)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            }
            .padding(.vertical, 16)
            .background(Color.white)
        }
    }
}
