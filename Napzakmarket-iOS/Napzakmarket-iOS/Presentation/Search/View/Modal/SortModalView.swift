//
//  SortModalView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/15/25.
//

import SwiftUI

struct SortModalView: View {
    
    //MARK: - Property Wrappers
    
    @Binding var sortModalViewIsPresented: Bool
    @Binding var selectedSortOption: SortOption
    @GestureState private var translation: CGFloat = .zero
    @EnvironmentObject private var tabBarState: TabBarStateModel
    
    //MARK: - Properties
    
    private let modalHeight: CGFloat = 302
    private let sortOptions: [SortOption] = [.recent, .popular, .highPrice, .lowPrice]
    
    //MARK: - Main Body
    
    var body: some View {
        VStack(spacing: 13) {
            dragArea
            OptionList
        }
        .background(
            Rectangle()
                .fill(.white)
                .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
        )
        .frame(height: modalHeight)
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
                        self.sortModalViewIsPresented = false
                    }
                })
        )
        .onAppear {
            tabBarState.isTabBarHidden = true
        }
    }
}

extension SortModalView {
    
    //MARK: - UI Properties
    
    private var dragArea: some View {
        Image(.iconDragIndicator)
            .resizable()
            .frame(width: 36, height: 4)
            .padding(.top, 10)
    }
    
    private var OptionList: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
            ForEach(sortOptions, id: \.self) { option in
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Text("\(option.title)")
                            .font(.napzakFont(.title5SemiBold18))
                            .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                            .foregroundStyle(option == selectedSortOption ? Color.napzakPurple(.purple30) : Color.napzakGrayScale(.gray900))
                        Spacer()
                        if option == selectedSortOption {
                            Image(.iconCheck)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedSortOption = option
                        sortModalViewIsPresented = false
                    }
                    Spacer()
                    if option != sortOptions.last {
                        Divider()
                            .frame(height: 1)
                            .foregroundStyle(Color.napzakGrayScale(.gray100))
                    }
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 35)
    }
}
