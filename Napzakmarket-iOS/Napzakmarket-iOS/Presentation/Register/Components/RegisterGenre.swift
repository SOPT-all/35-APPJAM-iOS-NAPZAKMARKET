//
//  RegisterGenre.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterGenre: View {
    @Binding var genre: String
    
    var body: some View {
        NavigationLink {
            RegisterSearch(genre: $genre)
                
        } label: {
            VStack(spacing: 0){
                titleSection
                dividerSection
            }
        }

    }
}

// MARK: - Subviews

extension RegisterGenre {
    
    private var titleSection: some View {
        HStack(alignment: .center) {
            Text("장르")
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            Spacer()
            Text(genre)
                .foregroundStyle(Color.napzakPurple(.purple30))
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.napzakGrayScale(.gray400))
        }
        .font(.napzakFont(.body2SemiBold16))
        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
        .padding(.bottom, 20)
    }
    
    // divider로 구현하니까 피그마랑 색상이 달라서 뷰로 구현을 했는데,
    // hstack이 아니라 더 좋은 무언가가 있지 않았을까 하는 고민이 있습니다
    private var dividerSection: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color.napzakGrayScale(.gray200))
    }
}
