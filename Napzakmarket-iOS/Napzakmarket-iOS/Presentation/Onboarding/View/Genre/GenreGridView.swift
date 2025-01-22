//
//  GenreGridView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/21/25.
//

import SwiftUI

struct GenreGridView: View {
    
    // MARK: - Properties
    @ObservedObject var genreModel: GenreModel
    
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var showTopGradient: Bool = false
    private let threshold: CGFloat = 10
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(genreModel.genres) { genre in
                        GenreCell(
                            genre: genre,
                            isSelected: Binding(
                                get: { genreModel.selectedGenres.contains(genre) },
                                set: { isSelected in
                                    if isSelected {
                                        if genreModel.selectedGenres.count < 4 {
                                            genreModel.selectedGenres.append(genre)
                                        }
                                    } else {
                                        genreModel.selectedGenres.removeAll(where: { $0.id == genre.id })
                                    }
                                }
                            )
                        )
                        .onAppear {
                            if genre == genreModel.genres.last && genreModel.hasMorePages {
                                Task {
                                    if genreModel.isFiltering {
                                        await genreModel.fetchGenresFiltered()
                                    } else {
                                        await genreModel.fetchGenres()
                                    }
                                }
                            }
                        }
                    }
                    .padding(2)
                }
                .padding(.bottom, 70)
                .background(
                    GeometryReader { proxy in
                        Color.clear.onChange(of: proxy.frame(in: .named("scroll")).minY) { value in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showTopGradient = value < -threshold
                            }
                        }
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            
            VStack {
                LinearGradient(
                    colors: [Color.napzakGradient(.gradient1SecondColor),
                             Color.napzakGradient(.gradient1FirstColor)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 32)
                .offset(y: showTopGradient ? 0 : -32)
                
                Spacer()
            }
            .allowsHitTesting(false)
            
            VStack {
                Spacer()
                LinearGradient(
                    colors: [Color.napzakGradient(.gradient1FirstColor),
                             Color.napzakGradient(.gradient1SecondColor)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 32)
            }
            .allowsHitTesting(false)
        }
    }
}
