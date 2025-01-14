//
//  GenreChip.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct GenreChip: View {
    
    let name: String
    @Binding var selectedGenres: [String]
    
    var body: some View {
        HStack(spacing: 4) {
            Text(name)
                .font(.napzakFont(.body4Bold14))
                .applyNapzakTextStyle(napzakFontStyle: .body4Bold14)
                .foregroundStyle(Color.napzakPurple(.purple30))
            
            Button {
                withAnimation {
                    selectedGenres.removeAll { $0 == name }
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundStyle(Color.napzakGrayScale(.gray500))
                    .frame(width: 13, height: 13)
            }
            .frame(width: 18, height: 18)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
        )
    }
    
}
