import SwiftUI

struct GenreGridView: View {
    
    // MARK: - Properties
    
    @Binding var genres: [Genre]
    @Binding var selectedGenres: [Genre]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var gradientOffset: CGFloat = -32
    @State private var scrollOffset: CGFloat = 0
    private let threshold: CGFloat = 10

    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
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
                    .padding(2)
                }
                .padding(.bottom, 70)
                .background(
                    GeometryReader { insideProxy in
                        Color.clear
                            .onAppear {
                                scrollOffset = insideProxy.frame(in: .global).minY
                            }
                            .onChange(of: insideProxy.frame(in: .global).minY) { value in
                                let scrollMovement = value - scrollOffset

                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if scrollMovement < -threshold {
                                        gradientOffset = 0
                                    } else if scrollMovement > threshold {
                                        gradientOffset = -32  
                                    }
                                }
                            }
                    }
                )
            }
            
            VStack {
                LinearGradient(
                    colors: [Color.napzakGradient(.gradient1SecondColor),
                             Color.napzakGradient(.gradient1FirstColor)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 32)
                .offset(y: gradientOffset)
                
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
