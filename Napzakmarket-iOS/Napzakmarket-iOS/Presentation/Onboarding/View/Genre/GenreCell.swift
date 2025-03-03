//
//  GenreCell.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/13/25.
//

import SwiftUI
import Kingfisher

struct GenreCell: View {
    
    // MARK: - Properties
    
    let genre: PreferGenre
    @Binding var isSelected: Bool
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(spacing: 6) {
            GenreImageView(imageUrl: genre.image, isSelected: isSelected)
            GenreTextView(name: genre.name, isSelected: isSelected)
        }
        .onTapGesture {
            isSelected.toggle()
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
        .frame(width: 100, height: 128)
    }
    
}

extension GenreCell {
    
    // MARK: - UI
    
    private struct GenreImageView: View {
        
        // MARK: - Properties
        
        let imageUrl: String?
        let isSelected: Bool
        
        // MARK: - Main Body
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                if let imageURL = imageUrl,
                   let url = URL(string: imageURL) {
                    KFImage(url)
                        .placeholder {
                            Image(.imgOnboardingEmpty)
                        }.retry(maxCount: 3, interval: .seconds(5))
                        .onFailure { error  in
                            print("failure: \(error.localizedDescription)")
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Color.napzakGrayScale(.gray300)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                if isSelected {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .foregroundStyle(
                            Color.napzakGrayScale(.white),
                            Color.napzakPurple(.purple30)
                        )
                        .frame(width: 16, height: 16)
                        .transition(.scale.combined(with: .opacity))
                        .padding([.top, .trailing], 10)
                }
            }
        }
        
    }
    
    private struct GenreTextView: View {
        
        // MARK: - Properties
        
        let name: String
        let isSelected: Bool
        
        // MARK: - Main Body
        
        var body: some View {
            Text(name)
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundColor(
                    isSelected ? .napzakPurple(.purple30) : .napzakGrayScale(.gray900)
                )
                .lineLimit(1)
        }
    }
    
}
