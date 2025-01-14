//
//  RegisterSearch.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/14/25.
//

import SwiftUI

struct RegisterSearch: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var genre: String
    
    var body: some View {
        Divider()
        ScrollView {
            VStack {
            }
        }
        .navigationTitle("장르")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                    }
                }
                
            }
        }
    }
}

#Preview {
    @State var registerType = false
    RegisterView(registerType: $registerType)
}
