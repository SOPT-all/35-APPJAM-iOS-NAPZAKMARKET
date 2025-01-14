//
//  TabbarModel.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/10/25.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let defaultIcon: String
    let selectedIcon: String
    let view: AnyView?
}

extension TabItem {
    static func getDefaultTabs() -> [TabItem] {
        return [
            TabItem(title: "홈", defaultIcon: "ic_home", selectedIcon: "ic_home_select", view: AnyView(PreView())),
            TabItem(title: "탐색", defaultIcon: "ic_look", selectedIcon: "ic_look_select", view: AnyView(PreView())),
            TabItem(title: "등록", defaultIcon: "ic_register", selectedIcon: "ic_register_select", view: AnyView(EmptyView())),
            TabItem(title: "채팅", defaultIcon: "ic_chat", selectedIcon: "ic_chat_select", view: AnyView(PreView())),
            TabItem(title: "마이", defaultIcon: "ic_my", selectedIcon: "ic_my_select", view: AnyView(PreView()))
        ]
    }
}
