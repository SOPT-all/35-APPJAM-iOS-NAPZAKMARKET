//
//  OnboardingView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    
    @State private var isInputComplete: Bool = false
    @EnvironmentObject var appState: AppState
    @StateObject private var genreModel = GenreModel()
    @FocusState private var isSearchBarFocused: Bool
    
    @State private var chipViewHeight: CGFloat = 0
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                TitleView()
                
                SearchBar(
                    placeholder: "원하는 장르를 직접 입력해 검색해보세요.",
                    text: $genreModel.searchText,
                    isInputComplete: $isInputComplete,
                    isSearchBarFocused: _isSearchBarFocused
                )
                .onChange(of: genreModel.searchText) { newValue in
                    if newValue.isEmpty {
                        Task {
                            await genreModel.fetchGenres()
                        }
                    } else {
                        Task {
                            await genreModel.fetchGenresFiltered()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .background(Color.napzakGrayScale(.white))
            .zIndex(2)
            
            ChipsContainerView(
                selectedGenres: .init(
                    get: { genreModel.selectedGenres.map { GenreName(id: $0.id, genreName: $0.name) } },
                    set: { newGenres in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            genreModel.removeSelection(newGenres.map { $0.id })
                        }
                    }
                )
            )
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .frame(height: genreModel.selectedGenres.isEmpty ? 0 : nil, alignment: .top)
            .offset(y: genreModel.selectedGenres.isEmpty ? -60 : 0)
            .animation(.easeInOut(duration: 0.3), value: genreModel.selectedGenres)
            .zIndex(1)
            
            VStack(spacing: 0) {
                GenreGridView(
                    genres: $genreModel.genres,
                    selectedGenres: $genreModel.selectedGenres
                )
                .animation(.easeInOut(duration: 0.3), value: genreModel.selectedGenres)
                .padding(.top, 30)
                .padding(.horizontal, 20)
                
                FinalActionsView(
                    appState: appState,
                    genreModel: genreModel,
                    selectedGenres: $genreModel.selectedGenres
                )
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isSearchBarFocused {
                    isSearchBarFocused = false
                }
            }
        }
        .padding(.top, 40)
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea(.keyboard)
        .task {
            await genreModel.fetchGenres()
        }
    }
    
}

extension OnboardingView {
    
    // MARK: - UI
    
    private struct TitleView: View {
        
        // MARK: - Main Body
        
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
                    .frame(height: 20)
            }
            .padding(.bottom, 32)
        }
    }
    
    private struct FinalActionsView: View {
        
        // MARK: - Properties
        
        @ObservedObject var appState: AppState
        @ObservedObject var genreModel: GenreModel
        @Binding var selectedGenres: [PreferGenre]
        
        // MARK: - Main Body
        
        var body: some View {
            VStack(spacing: 0) {
                Button {
                    Task {
                        await genreModel.registerPreferGenres()
                        appState.moveToMain()
                    }
                } label: {
                    Text("선택완료! 시작하기")
                        .font(.napzakFont(.body1Bold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                        .foregroundStyle(Color.napzakGrayScale(.white))
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(selectedGenres.isEmpty ? Color.napzakGrayScale(.gray400) : Color.napzakPurple(.purple30) )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(selectedGenres.isEmpty)
                
                Button {
                    appState.moveToMain()
                } label: {
                    Text("나중에 설정할래요")
                        .font(.napzakFont(.body2SemiBold16))
                        .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                        .frame(maxWidth: .infinity, minHeight: 52)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 140)
        }
    }
     
}
