//
//  SearchInputView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/20/25.
//

import SwiftUI

struct SearchInputView: View {
    
    //MARK: - Property Wrappers
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    @State private var inputText = ""
    @State private var isInputComplete: Bool = false
    
    @State private var selectedGenre: GenreSearchModel?
    @State private var isGenreSelected: Bool = false
    
    @FocusState private var isSearchBarFocused: Bool
    
    //MARK: - Properties
    
    private let genres = GenreSearchModel.genreDummyList
    
    //MARK: - Main Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.napzakGrayScale(.white)
                    .onTapGesture {
                        isSearchBarFocused = false
                    }
                VStack(spacing: 0) {
                    navigationSearchBar
                    genreListView
                }
            }
            .navigationBarHidden(true)
            .onAppear() {
                isSearchBarFocused = true
                tabBarState.isTabBarHidden = true
            }
            .onDisappear {
                tabBarState.isTabBarHidden = false
            }
        }
        .navigationDestination(isPresented: $isInputComplete) {
            SearchView(isBackButtonHidden: false, searchResultText: inputText)
        }
        .navigationDestination(isPresented: $isGenreSelected) {
            if let selectedGenre {
                SearchView(selectedGenres: [selectedGenre], isBackButtonHidden: false)
            }
        }
    }
}

extension SearchInputView {
    
    //MARK: - UI Properties
    
    private var navigationSearchBar: some View {
        HStack(alignment: .center, spacing: 4) {
            Button {
                dismiss()
            } label: {
                Image(.icBack)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .padding(.top, 4)
            }
            SearchBar(placeholder: "어떤 아이템을 찾고 계신가요?", text: $inputText, isInputComplete: $isInputComplete, isSearchBarFocused: _isSearchBarFocused)
        }
        .padding(.top, 18)
        .padding(.trailing, 20)
    }
    
    private var genreListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                ForEach(genres.indices, id: \.self) { i in
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            Image(.imgTagGenre)
                                .resizable()
                                .frame(width: 37, height: 21)
                            Text("\(genres[i].genreName)")
                                .font(.napzakFont(.body5SemiBold14))
                                .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                                .foregroundStyle(Color.napzakGrayScale(.gray800))
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedGenre = genres[i]
                            isGenreSelected = true
                        }
                        Spacer()
                        if i != genres.count - 1 {
                            Divider()
                                .frame(height: 1)
                                .foregroundStyle(Color.napzakGrayScale(.gray100))
                        }
                    }
                }
                .frame(height: 60)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
    }
}
