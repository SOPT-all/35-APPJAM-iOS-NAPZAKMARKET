// //  TabbarView.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/6/25.
//

import SwiftUI

// MARK: - TabViewModel
class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0

    let tabs: [TabItem]

    init() {
        tabs = [
            TabItem(title: "홈", defaultIcon: "ic_home", selectedIcon: "ic_home_select", view: AnyView(PreView())),
            TabItem(title: "탐색", defaultIcon: "ic_look", selectedIcon: "ic_look_select", view: AnyView(PreView())),
            TabItem(title: "등록", defaultIcon: "ic_register", selectedIcon: "ic_register_select", view: AnyView(PreView())),
            TabItem(title: "채팅", defaultIcon: "ic_chat", selectedIcon: "ic_chat_select", view: AnyView(PreView())),
            TabItem(title: "마이", defaultIcon: "ic_my", selectedIcon: "ic_my_select", view: AnyView(MypageView()))
        ]
    }
}

// MARK: - TabbarView
struct TabbarView: View {
    @StateObject private var viewModel = TabViewModel()

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(0..<viewModel.tabs.count, id: \.self) { index in
                    viewModel.tabs[index].view
                        .tabItem {
                            VStack {
                                Image(viewModel.selectedTab == index ? viewModel.tabs[index].selectedIcon : viewModel.tabs[index].defaultIcon)
                                Text(viewModel.tabs[index].title)
                                    .font(.napzakFont(viewModel.selectedTab == index ? .caption1Bold12 : .caption3Medium12))
                                    .applyNapzakTextStyle(napzakFontStyle: viewModel.selectedTab == index ? .caption1Bold12 : .caption3Medium12)
                                    .foregroundStyle(viewModel.selectedTab == index ? Color.napzakGrayScale(.gray900) : Color.napzakGrayScale(.gray500))
                            }
                        }
                        .tag(index)
                }
            }
            .accentColor(.black)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Preview
struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
