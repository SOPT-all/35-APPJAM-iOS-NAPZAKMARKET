//
//  RegisterGenre.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterGenre: View {
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink {
                Text("장르 뷰")
            } label: {
                HStack{
                    Text("장르")
                        .foregroundStyle(.black)
                        .font(.system(size: 16))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    SellRegisterView()
}
