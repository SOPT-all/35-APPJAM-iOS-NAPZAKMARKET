//
//  RegisterSearch.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/14/25.
//

import SwiftUI

struct RegisterSearch: View {
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - text 서버로 보내서 실시간 검색 확인 api
    // 장르이름 검색 api
    
    @State var text = ""
    @State private var isInputComplete: Bool = false
    
    @Binding var genre: String
    @Binding var genreId: Int
    @State private var genreList: [GenreName] = []
    
    var body: some View {
        VStack{
            Divider()
                .padding(.bottom, 15)
            
            SearchBar(placeholder: "예) 건담, 산리오, 주술회전", text: $text, isInputComplete: $isInputComplete)
                .padding(.horizontal, 20)
                .onChange(of: text) { newValue in
                    Task {
                        await fetchGenres(searchWord: text)
                    }
                }
            
            listSection
            
        }
        .navigationTitle("장르")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .frame(width: 24, height: 48)
                }
            }
        }
        .onAppear {
            if genreList.isEmpty {
                NetworkService.shared.genreService.getAllGenreName { result in
                    switch result {
                    case .success(let response):
                        guard let response else { return }
                        genreList = response.data.genreList
                    default:
                        break
                    }
                }
            }
        }
        
    }
}

// MARK: - Subviews

extension RegisterSearch {
    
    private var listSection: some View {
        List {
            ForEach(genreList, id: \.genreId) { item in
                HStack{
                    Text(item.genreName)
                        .font(.napzakFont(.body5SemiBold14))
                        .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                        .foregroundStyle(Color.napzakGrayScale(.gray800))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                }
                .padding(.vertical, 20)
                .onTapGesture {
                    genre = item.genreName
                    genreId = item.genreId.byteSwapped
                    dismiss()
                }
            }
            .listRowInsets(.init()) // remove insets
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 0)
        .padding(.horizontal, 20)

        
    }
    
}

// MARK: - Network

extension RegisterSearch {
    private func fetchGenres(searchWord: String) async {
        NetworkService.shared.genreService.getSearchGenreName(searchWord: searchWord) { result in
            switch result {
            case .success(let response):
                guard let response else { return }
                self.genreList = response.data.genreList
            default:
                break
            }
        }
    }
    
}
