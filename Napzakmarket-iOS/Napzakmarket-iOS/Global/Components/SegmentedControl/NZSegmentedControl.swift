//
//  NZSegmentedControl.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/13/25.
//

import SwiftUI

struct NZSegmentedControl: View {
    
    //MARK: - Property Wrappers
    
    @Binding var selectedIndex: Int
    
    //MARK: - Properties
    
    let tabs: [String]
    let spacing: CGFloat

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: tabs.count)
    }
    
    //MARK: - Main Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            divider
            segmentedButtons
        }
        .frame(height: 49)
    }
}

extension NZSegmentedControl {
    
    //MARK: - UI Properties
    
    private var divider: some View {
        VStack {
            Spacer()
            Divider()
                .frame(height: 2)
                .overlay(Color.napzakGrayScale(.gray300))
        }
    }
    
    private var segmentedButtons: some View {
        LazyVGrid(columns: columns) {
            ForEach(tabs.indices, id: \.self) { i in
                Button {
                    print("\(tabs[i]) tab 터치")
                    selectedIndex = i
                } label: {
                    VStack {
                        Text(tabs[i])
                            .font(selectedIndex == i ? .napzakFont(.title5SemiBold18) : .napzakFont(.title6Medium18))
                            .applyNapzakTextStyle(napzakFontStyle: .title5SemiBold18)
                            .foregroundStyle(selectedIndex == i ? Color.napzakPurple(.purple30): Color.napzakGrayScale(.gray600))
                        Divider()
                            .frame(height: 2)
                            .overlay(selectedIndex == i ? Color.napzakPurple(.purple30): Color.napzakGrayScale(.gray300))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
