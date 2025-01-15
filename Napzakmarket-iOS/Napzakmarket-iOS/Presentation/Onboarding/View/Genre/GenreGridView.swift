//
//  GenreGridView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct GenreGridView: View {
    
    // MARK: - Properties
    
    @Binding var genres: [Genre]
    @Binding var selectedGenres: [Genre]
    
    private let colums = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Properties
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 20) {
                ForEach(genres) { genre in
                    GenreCell(
                        genre: genre,
                        isSelected: Binding(
                            get: { selectedGenres.contains(genre) },
                            set: { isSelected in
                                if isSelected {
                                    if selectedGenres.count < 4 {
                                        selectedGenres.append(genre)
                                    }
                                } else {
                                    selectedGenres.removeAll(where: { $0.id == genre.id })
                                }
                            }
                        )
                    )
                }
            }
        }
    }
    
}
