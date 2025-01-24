//
//  RegisterGenre.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterGenre: View {
    @Binding var genre: String
    @Binding var genreId: Int
    @State var genreList: [GenreName] = []
    
    var body: some View {
        NavigationLink {
            RegisterSearch(genre: $genre, genreId: $genreId)
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
    
    private var dividerSection: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color.napzakGrayScale(.gray200))
    }
}
