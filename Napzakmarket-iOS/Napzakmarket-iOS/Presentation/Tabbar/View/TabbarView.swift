//
//  TabbarView.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/6/25.
//

import SwiftUI

// MARK: - TabViewModel
class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var isRegisterTabActive: Bool = false
    @Published var lastSelectedTab: Int = 0
    
    let tabs: [TabItem]
    
    init() {
        tabs = [
            TabItem(title: "홈", defaultIcon: "ic_home", selectedIcon: "ic_home_select", view: AnyView(PreView())),
            TabItem(title: "탐색", defaultIcon: "ic_look", selectedIcon: "ic_look_select", view: AnyView(MypageView())),
            TabItem(title: "등록", defaultIcon: "ic_register", selectedIcon: "ic_register_select", view: AnyView(EmptyView())),
            TabItem(title: "채팅", defaultIcon: "ic_chat", selectedIcon: "ic_chat_select", view: AnyView(MypageView())),
            TabItem(title: "마이", defaultIcon: "ic_my", selectedIcon: "ic_my_select", view: AnyView(MypageView()))
        ]
    }
}

// MARK: - TabbarView
struct TabbarView: View {
    @StateObject private var viewModel = TabViewModel()
    @State private var isBottomSheetVisible = false
    
    var body: some View {
        ZStack {
            viewModel.tabs[viewModel.selectedTab].view
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 90)
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.napzakGrayScale(.gray200))
                    
                    HStack {
                        ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                            Spacer()
                            VStack(spacing: 4) {
                                Image(getIconName(for: index))
                                Text(viewModel.tabs[index].title)
                                    .font(.caption)
                            }
                            .foregroundColor(getTabColor(for: index))
                            .onTapGesture {
                                handleTabTap(index)
                            }
                            .padding(.bottom, 8)
                            Spacer()
                        }
                    }
                    .frame(height: 82)
                }
                .frame(height: 90)
                .background(Color.white)
            }

            if isBottomSheetVisible {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        hideBottomSheet()
                    }
                
                VStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Button(action: {
                            print("팔아요 등록 클릭")
                            hideBottomSheet()
                        }) {
                            HStack {
                                Image("ic_sell")
                                Text("팔아요 등록")
                                    .font(.napzakFont(.body2SemiBold16))
                                       .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                            }
                        }
                        
                        Divider()
                        
                        Button(action: {
                            print("구해요 등록 클릭")
                            hideBottomSheet()
                        }) {
                            HStack {
                                Image("ic_buy")
                                Text("구해요 등록")
                                    .font(.napzakFont(.body2SemiBold16))
                                       .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 15)
                    .frame(width: 160)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.bottom, 104)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // 탭 터치 핸들러
    private func handleTabTap(_ index: Int) {
        if index == 2 {
            if isBottomSheetVisible {
                hideBottomSheet()
            } else {
                viewModel.lastSelectedTab = viewModel.selectedTab
                viewModel.isRegisterTabActive = true
                isBottomSheetVisible = true
            }
        } else {
            if isBottomSheetVisible {
                hideBottomSheet()
            }
            viewModel.selectedTab = index
            viewModel.isRegisterTabActive = false
        }
    }
    
    // 아이콘 이름 결정
    private func getIconName(for index: Int) -> String {
        if index == 2 {
            return viewModel.isRegisterTabActive ? viewModel.tabs[index].selectedIcon : viewModel.tabs[index].defaultIcon
        } else {
            if viewModel.isRegisterTabActive {
                return viewModel.tabs[index].defaultIcon
            }
            return viewModel.selectedTab == index ? viewModel.tabs[index].selectedIcon : viewModel.tabs[index].defaultIcon
        }
    }
    
    // 탭 색상 결정
    private func getTabColor(for index: Int) -> Color {
        if index == 2 {  // 등록 탭
            return viewModel.isRegisterTabActive ? .black : .gray
        } else {  // 다른 탭들
            if viewModel.isRegisterTabActive {
                return .gray
            }
            return viewModel.selectedTab == index ? .black : .gray
        }
    }
    
    private func hideBottomSheet() {
        isBottomSheetVisible = false
        viewModel.isRegisterTabActive = false
        viewModel.selectedTab = viewModel.lastSelectedTab
    }
}

// MARK: - Preview
struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
