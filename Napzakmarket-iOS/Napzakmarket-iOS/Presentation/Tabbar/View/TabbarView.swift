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
    @Published var visualSelectedTab: Int = 0  // 실제로 보여질 선택된 탭
    
    let tabs: [TabItem]
    
    init() {
        tabs = [
            TabItem(title: "홈", defaultIcon: "ic_home", selectedIcon: "ic_home_select", view: AnyView(MypageView())),
            TabItem(title: "탐색", defaultIcon: "ic_look", selectedIcon: "ic_look_select", view: AnyView(MypageView())),
            TabItem(title: "등록", defaultIcon: "ic_register", selectedIcon: "ic_register_select", view: AnyView(MypageView())),
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
            TabView(selection: $viewModel.selectedTab) {
                ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                    viewModel.tabs[index].view
                        .tabItem {
                            VStack {
                                Image(viewModel.selectedTab == index ? viewModel.tabs[index].selectedIcon : viewModel.tabs[index].defaultIcon)
                                Text(viewModel.tabs[index].title)
                            }
                        }
                        .tag(index)
                }
            }
            .accentColor(.black)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(UIColor.systemGray5))
                    .padding(.bottom, 90)
            }

            if isBottomSheetVisible {
                VStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .frame(maxHeight: UIScreen.main.bounds.height - 90)
                        .onTapGesture {
                            isBottomSheetVisible = false
                        }
                    Spacer()
                        .frame(height: 90)
                }
                
                VStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Button(action: {
                            print("팔아요 등록 클릭")
                            isBottomSheetVisible = false
                        }) {
                            HStack {
                                Image(systemName: "bag")
                                    .foregroundColor(.purple)
                                Text("팔아요 등록")
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Divider()
                        
                        Button(action: {
                            print("구해요 등록 클릭")
                            isBottomSheetVisible = false
                        }) {
                            HStack {
                                Image(systemName: "cart")
                                    .foregroundColor(.purple)
                                Text("구해요 등록")
                                    .foregroundColor(.black)
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
                .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: viewModel.selectedTab) {
           if viewModel.selectedTab == 2 {
               isBottomSheetVisible = true
               // 뷰는 이전 탭을 유지
               let currentTab = viewModel.selectedTab
               viewModel.selectedTab = viewModel.visualSelectedTab
               viewModel.visualSelectedTab = currentTab
           } else {
               // 다른 탭은 정상적으로 동작
               viewModel.visualSelectedTab = viewModel.selectedTab
           }
        }
    }
}

// MARK: - Preview
struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
