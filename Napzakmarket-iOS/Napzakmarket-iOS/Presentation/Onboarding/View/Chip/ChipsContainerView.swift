//
//  ChipsContainerView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct ChipsContainerView: View {
    
    // MARK: - Properties
    
    @Binding var selectedGenres: [String]
    
    // MARK: - Main Body
    
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
        .frame(height: 35)
    }
    
}

extension ChipsContainerView {
    
    // MARK: - UI
    
    private struct ChipListView: View {
        
        // MARK: - Properties
        
        @Binding var selectedGenres: [String]
        
        // MARK: - Main Body
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 6) {
                    ForEach(selectedGenres, id: \.self) { genre in
                        GenreChip(name: genre, selectedGenres: $selectedGenres)
                    }
                }
                .padding(.trailing, 20)
            }
        } 
    }
    
}
