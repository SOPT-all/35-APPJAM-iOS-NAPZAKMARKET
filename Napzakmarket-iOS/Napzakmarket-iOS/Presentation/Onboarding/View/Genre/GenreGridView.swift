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
        ZStack {
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
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, 70)
            }
            
            VStack {
                LinearGradient(
                    colors: [Color.napzakGradient(.gradient1SecondColor),
                             Color.napzakGradient(.gradient1FirstColor)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 32)
                .padding(.top, -30)
                
                Spacer()
                
                LinearGradient(
                    colors: [Color.napzakGradient(.gradient1FirstColor),
                             Color.napzakGradient(.gradient1SecondColor)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 32)
            }
            .padding(.top, 30)
            .allowsHitTesting(false)
        }
    }
    
}
