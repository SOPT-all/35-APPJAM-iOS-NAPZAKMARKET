//
//  OnboardingView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var genreModel = GenreModel()
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleView()
            
            SearchBar(
                placeholder: "원하는 장르를 직접 입력해 검색해보세요.",
                text: $genreModel.searchText
            )
            .onChange(of: genreModel.searchText) { _ in
                Task {
                    try? await genreModel.fetchGenresFiltered()
                }
            }
            
            ChipsContainerView(
                selectedGenres: .init(
                    get: { genreModel.selectedGenres.map { $0.name } },
                    set: { newNames in
                        genreModel.removeSelection(newNames )
                    }
                )
            )
            
            GenreGridView(
                genres: $genreModel.genres,
                selectedGenres: $genreModel.selectedGenres
            )
            
            FinalActionsView(
                isOnboardingComplete: $isOnboardingComplete,
                selectedGenres: $genreModel.selectedGenres
            )
        }
        .padding(.horizontal, 20)
        .task {
            try? await genreModel.fetchGenres()
        }
        
    }
}

extension OnboardingView {
    
    private struct TitleView: View {
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("좋아하는 장르를 골라보세요!\n취향에 딱 맞는 상품을 찾아드릴게요")
                    .font(.napzakFont(.title1Bold22))
                    .applyNapzakTextStyle(napzakFontStyle: .title1Bold22)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .lineLimit(2)
                
                Text("최대 4개 선택")
                    .font(.napzakFont(.body5SemiBold14))
                    .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                    .foregroundStyle(Color.napzakGrayScale(.gray500))
            }
            .padding(.bottom, 32)
        }
    }
    
    private struct FinalActionsView: View {
        @Binding var isOnboardingComplete: Bool
        @Binding var selectedGenres: [Genre]
        
        var body: some View {
            VStack(spacing: 0) {
                Button {
                    isOnboardingComplete = true
                } label: {
                    Text("선택완료! 시작하기")
                        .font(.napzakFont(.body1Bold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                        .foregroundStyle(Color.napzakGrayScale(.white))
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(selectedGenres.isEmpty ? Color.napzakGrayScale(.gray400) : Color.napzakPurple(.purple30) )
                        .cornerRadius(12)
                }
                .disabled(selectedGenres.isEmpty)
                
                Button {
                    isOnboardingComplete = true
                } label: {
                    Text("선택완료! 시작하기")
                        .font(.napzakFont(.body2SemiBold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                        .frame(maxWidth: .infinity, minHeight: 52)
                }
                Spacer()
            }
            .frame(height: 140)
        }
    }
     
}
