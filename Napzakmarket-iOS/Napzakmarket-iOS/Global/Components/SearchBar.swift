//
//  SearchBar.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/12/25.
//

import SwiftUI

struct SearchBar: View {
    
    // MARK: - Properties
    
    let placeholder: String
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    // MARK: - Main Body
    
    var body: some View {
        HStack(spacing: 12) {
            TextField(placeholder, text: $text)
                .font(.napzakFont(.body5SemiBold14))
                .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                .focused($isFocused)
            
            HStack(spacing: 4) {
                if !text.isEmpty {
                    Button{
                        text = ""
                    } label: {
                        Icon(systemName: "xmark.circle.fill")
                    }
                    .transition(.scale.combined(with: .opacity))
                }
                
                Button {
                    if text.isEmpty {
                        isFocused = true
                    } else {
                        // TODO: 엔터 역할
                        print("돋보기 Tapped: \(text)")
                    }
                } label: {
                    Icon(systemName: "magnifyingglass")
                }
            }
        }
        .padding(12)
        .background(Color.napzakGrayScale(.gray100))
        .cornerRadius(12)
        .padding(.bottom, 16)
        .animation(.easeInOut(duration: 0.3), value: text.isEmpty)
    }
    
}

extension SearchBar {
    
    // MARK: - UI
    
    private struct Icon: View {
        
        // MARK: - Properties
        
        let systemName: String
        
        // MARK: - Main Body
        
        var body: some View {
            Image(systemName: systemName)
                .foregroundStyle(Color.napzakGrayScale(.gray600))
                .padding(4.5)
        }
        
    }
    
}
