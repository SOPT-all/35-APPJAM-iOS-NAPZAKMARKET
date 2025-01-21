//
//  GenreFilterModalView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/16/25.
//

import SwiftUI

struct GenreFilterModalView: View {
    
    //MARK: - Property Wrappers
    
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    @State var inputText: String = ""
    @State private var isInputComplete: Bool = false
    
    @Binding var selectedGenres: [GenreName]
    @Binding var selectedGenreStrings: [String]
    @Binding var filterModalViewIsPresented: Bool
    
    @GestureState private var translation: CGFloat = .zero
    
    @FocusState private var isSearchBarFocused: Bool
    
    //MARK: - Data from server
    
    @State var genreList: [GenreName] = []

    //MARK: - Properties
    
    private let modalHeight: CGFloat = 572
    
    //MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                dragArea
                header
                searchBar
            }
            .onTapGesture {
                isSearchBarFocused = false
            }
            genreScrollView
            if !selectedGenreStrings.isEmpty {
                selectedGenreView
            }
            applyButton
        }
        .frame(height: modalHeight)
        .padding(.bottom, 35)
        .background(
            Rectangle()
                .fill(.white)
                .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .offset(y: translation)
        .gesture(
            DragGesture()
                .updating($translation) { value, state, _ in
                    if value.translation.height > 0 && value.startLocation.y >= 0 && value.startLocation.y <= 27 {
                        let translation = min(modalHeight, max(-modalHeight, value.translation.height))
                        state = translation
                    }
                }
                .onEnded({ value in
                    if value.translation.height >= modalHeight / 3 {
                        self.filterModalViewIsPresented = false
                    }
                })
        )
        .onAppear {
            selectedGenreStrings = selectedGenres.map { $0.genreName }
            tabBarState.isTabBarHidden = true
            
            Task {
                await getAllGenreList()
            }
        }
    }
}

extension GenreFilterModalView {
    
    //MARK: - UI Properties
    
    private var dragArea: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(.iconDragIndicator)
                .resizable()
                .frame(width: 36, height: 4)
                .padding(.top, 10)
                .padding(.bottom, 31)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("원하는 장르를 선택해주세요.")
                .font(.napzakFont(.title4Bold18))
                .applyNapzakTextStyle(napzakFontStyle: .title4Bold18)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            Text("최대 4개 선택")
                .font(.napzakFont(.caption2SemiBold12))
                .applyNapzakTextStyle(napzakFontStyle: .caption2SemiBold12)
                .foregroundStyle(Color.napzakGrayScale(.gray500))
        }
        .padding(.bottom, 18)
        .padding(.horizontal, 20)
    }
    
    private var searchBar: some View {
        SearchBar(
            placeholder: "예) 건담, 산리오, 주술회전",
            text: $inputText,
            isInputComplete: $isInputComplete,
            isSearchBarFocused: _isSearchBarFocused
        )
        .padding(.bottom, 10)
        .padding(.horizontal, 20)
        .onChange(of: inputText) { newValue in
            Task {
                if newValue.isEmpty {
                    await getAllGenreList()
                } else {
                    await getSearchGenreList(searchWord: newValue)
                }
            }
        }
    }
    
    private var genreScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(genreList.indices, id: \.self) { i in
                    HStack {
                        Text("\(genreList[i].genreName)")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray800))
                        Spacer()
                    }
                    .frame(height: 60)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isSearchBarFocused = false
                        if !selectedGenreStrings.contains(genreList[i].genreName) && selectedGenreStrings.count < 4 {
                            selectedGenreStrings.append(genreList[i].genreName)
                        }
                    }
                    
                    if i != genreList.count - 1 {
                        Divider()
                            .frame(height: 1)
                            .foregroundStyle(Color.napzakGrayScale(.gray100))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var selectedGenreView: some View {
        VStack() {
            Spacer()
            ChipsContainerView(selectedGenres: $selectedGenreStrings)
                .padding(.leading, 20)
            Spacer()
        }
        .background(Color.napzakGrayScale(.gray50))
        .frame(height: 58)
    }
    
    private var applyButton: some View {
        Button {
            
            //TODO: - Genre 구조체로 바꿔서 배열 핸들링하기
            
            print("적용하기 버튼 선택")
            selectedGenres = []
            for selectedGenreString in self.selectedGenreStrings {
                if let i = genreList.firstIndex(where: { $0.genreName == selectedGenreString }) {
                    selectedGenres.append(genreList[i])
                }
            }
            filterModalViewIsPresented = false
            
        } label: {
            HStack {
                Spacer()
                Text(selectedGenreStrings.isEmpty ? "적용하기" : "\(selectedGenreStrings.count)개 적용하기 ")
                    .font(.napzakFont(.body1Bold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                    .foregroundStyle(Color.napzakGrayScale(.white))
                Spacer()
            }
        }
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.napzakPurple(.purple30)))
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom, 35)
    }
    
    //MARK: - Private Func
    
    private func getAllGenreList() async {
        NetworkService.shared.genreService.getAllGenreName { result in
            switch result {
            case .success(let reponse):
                guard let reponse else { return }
                DispatchQueue.main.async {
                    genreList = reponse.data.genreList
                }
            default:
                break
            }
        }
    }
    
    private func getSearchGenreList(searchWord: String) async {
        NetworkService.shared.genreService.getSearchGenreName(searchWord: searchWord) { result in
            switch result {
            case .success(let reponse):
                guard let reponse else { return }
                DispatchQueue.main.async {
                    genreList = reponse.data.genreList
                    print(reponse.data.genreList)
                }
            default:
                break
            }
        }
    }
}
