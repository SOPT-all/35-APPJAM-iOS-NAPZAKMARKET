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
            Text("장르 뷰")
        } label: {
            HStack {
                Text("장르")
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                Spacer()
                Text(genre)
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.napzakGrayScale(.gray400))
            }
            .font(.napzakFont(.body2SemiBold16))
            .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
        }
        .padding(20)
        
        Divider()
            .frame(height: 1)
            .background(Color.napzakGrayScale(.gray200))
            .padding(.horizontal, 20)
    }
}

#Preview {
    RegisterView()
}
