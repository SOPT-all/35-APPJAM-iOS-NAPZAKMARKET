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
    @Binding var isInputComplete: Bool
    @FocusState var isSearchBarFocused: Bool
    
    // MARK: - Main Body
    
    var body: some View {
        HStack(spacing: 12) {
            TextField(placeholder, text: $text)
                .font(.napzakFont(.body5SemiBold14))
                .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                .focused($isSearchBarFocused)
            
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
                        isSearchBarFocused = true
                    } else {
                        print("돋보기 Tapped: \(text)")
                        isInputComplete = true
                    }
                } label: {
                    Icon(systemName: "magnifyingglass")
                }
            }
        }
        .frame(height: 44)
        .padding(.horizontal, 12)
        .background(Color.napzakGrayScale(.gray100))
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
