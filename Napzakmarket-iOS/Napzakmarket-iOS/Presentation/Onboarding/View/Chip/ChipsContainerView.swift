//
//  ChipsContainerView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct ChipsContainerView: View {
    
    @Binding var selectedGenres: [String]
    
    var body: some View {
        HStack(spacing: 6) {
            Button {
                withAnimation {
                    selectedGenres.removeAll()
                }
            } label: {
                Image(.btnReset)
            }
            
            ChipListView(selectedGenres: $selectedGenres)
        }
        .background(.yellow)
        .frame(height: 40)
        .padding(.bottom, 30)
    }
    
}

extension ChipsContainerView {
    
    private struct ChipListView: View {
        @Binding var selectedGenres: [String]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 6) {
                    ForEach(selectedGenres, id: \.self) { genre in
                        GenreChip(name: genre, selectedGenres: $selectedGenres)
                    }
                }
            }
        }
    }
    
}
