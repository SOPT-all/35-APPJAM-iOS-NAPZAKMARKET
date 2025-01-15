//
//  SortModalView.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/15/25.
//

import SwiftUI

enum SortOption: String {
    case latest = "최신순"
    case popular = "인기순"
    case highPrice = "고가순"
    case lowPrice = "저가순"
}

struct SortModalView: View {
    
    //MARK: - Property Wrappers
    
    @Binding var sortModalViewIsPresented: Bool
    @Binding var selectedSortOption: SortOption
    @GestureState private var translation: CGFloat = .zero
    
    //MARK: - Properties
    
    private let modalHeight: CGFloat = 302
    private let sortOptions: [SortOption] = [.latest, .popular, .highPrice, .lowPrice]
    
    //MARK: - Main Body
    
    var body: some View {
        VStack {
            dragArea
            OptionList
        }
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
                        self.sortModalViewIsPresented = false
                    }
                })
        )
    }
}

extension SortModalView {
    
    //MARK: - UI Properties
    
    private var dragArea: some View {
        HStack(alignment: .center) {
            Spacer()
            Image(.iconDragIndicator)
                .resizable()
                .frame(width: 36, height: 4)
            Spacer()
        }
        .frame(height: 27)
    }
    
    private var OptionList: some View {
        ForEach(sortOptions, id: \.self) { option in
            HStack {
                Text("\(option.rawValue)")
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
            .frame(height: 60)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedSortOption = option
                sortModalViewIsPresented = false
            }
            
            if option != sortOptions.last {
                Divider()
                    .frame(height: 1)
                    .foregroundStyle(Color.napzakGrayScale(.gray100))
            }
        }
        .padding(.horizontal, 20)
    }
}
