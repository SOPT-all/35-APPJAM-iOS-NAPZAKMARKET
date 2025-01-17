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
                
                HStack{
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(Color.napzakGrayScale(.gray200))

            }
        }
        .padding(20)
        
        
    }
}

