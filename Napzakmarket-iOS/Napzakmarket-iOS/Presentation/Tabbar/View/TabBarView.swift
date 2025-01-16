//
//  TabbarView.swift
//  Napzakmarket-iOS
//
//  Created by 박어진 on 1/6/25.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: Int = 0
    @State private var isRegisterTabActive: Bool = false
    @State private var lastSelectedTab: Int = 0
    @State private var isBottomSheetVisible = false
    @State private var isTabBarHidden: Bool = false
    @State private var modalRegister = false
    @State var registerType = false
    
    private let tabs: [TabItem] = TabItem.getDefaultTabs()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            mainContent
            if !isTabBarHidden {
                tabBarStack
            }
            if isBottomSheetVisible {
                bottomSheetOverlay
                bottomSheetContent
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $modalRegister) {
            RegisterView(registerType: $registerType)
        }
    }
    
    private var mainContent: some View {
        tabs[selectedTab].view
            .safeAreaInset(edge: .bottom) {
                if !isTabBarHidden {
                    Color.clear.frame(height: 90)
                }
            }
            .environmentObject(TabBarStateModel(isTabBarHidden: $isTabBarHidden))
    }
    
    private var tabBarStack: some View {
        VStack(spacing: 0) {
            Spacer()
            tabBar
        }
    }
    
    private var tabBar: some View {
        VStack(spacing: 0) {
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color.napzakGrayScale(.gray200))
            Spacer(minLength:8)
            tabBarButtons
        }
        .frame(height: 90)
        .background(Color.white)
    }
    
    private var tabBarButtons: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Spacer()
                tabButton(for: index)
                Spacer()
            }
        }
        .frame(height: 82.0)
    }
    
    private func tabButton(for index: Int) -> some View {
        VStack(spacing: 3) {
            Image(getIconName(for: index))
            Text(tabs[index].title)
                .font(.napzakFont(getTabTextStyle(for: index)))
                .applyNapzakTextStyle(napzakFontStyle: getTabTextStyle(for: index))
        }
        .foregroundColor(getTabColor(for: index))
        .onTapGesture {
            handleTabTap(index)
        }
        .padding(.bottom, 30)
    }
    
    private var bottomSheetOverlay: some View {
        Color.napzakTransparency(.black70)
            .ignoresSafeArea()
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, 89)
            .onTapGesture {
                hideBottomSheet()
            }
    }
    
    private var bottomSheetContent: some View {
        VStack {
            Spacer()
            VStack(spacing: 12) {
                registerButton(type: "팔아요", icon: "ic_sell")
                Divider()
                registerButton(type: "구해요", icon: "ic_buy")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 15)
            .frame(width: 160)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.bottom, 104)
        }
    }
    
    private func registerButton(type: String, icon: String) -> some View {
        Button(action: {
            print("\(type) 등록 클릭")
            
            if type == "팔아요" {
                registerType = true
            } else {
                registerType = false
            }
            modalRegister.toggle()
            hideBottomSheet()
        }) {
            HStack {
                Image(icon)
                Text("\(type) 등록")
                    .font(.napzakFont(.body2SemiBold16))
                    .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
            }
        }
    }
    
    private func handleTabTap(_ index: Int) {
        if index == 2 {
            handleRegisterTab()
        } else {
            handleNormalTab(index)
        }
    }
    
    private func handleRegisterTab() {
        if isBottomSheetVisible {
            hideBottomSheet()
        } else {
            showBottomSheet()
        }
    }
    
    private func handleNormalTab(_ index: Int) {
        if isBottomSheetVisible {
            hideBottomSheet()
        }
        selectedTab = index
        isRegisterTabActive = false
    }
    
    private func showBottomSheet() {
        lastSelectedTab = selectedTab
        isRegisterTabActive = true
        isBottomSheetVisible = true
    }
    
    private func hideBottomSheet() {
        isBottomSheetVisible = false
        isRegisterTabActive = false
        selectedTab = lastSelectedTab
    }
    
    private func getIconName(for index: Int) -> String {
        if index == 2 {
            return isRegisterTabActive ? tabs[index].selectedIcon : tabs[index].defaultIcon
        }
        return isRegisterTabActive ? tabs[index].defaultIcon :
        (selectedTab == index ? tabs[index].selectedIcon : tabs[index].defaultIcon)
    }
    
    private func getTabColor(for index: Int) -> Color {
        if index == 2 {
            return isRegisterTabActive ? .napzakGrayScale(.gray900) : .napzakGrayScale(.gray500)
        }
        return isRegisterTabActive ? .gray :
        (selectedTab == index ? .napzakGrayScale(.gray900) : .napzakGrayScale(.gray500))
    }
    
    private func getTabTextStyle(for index: Int) -> NapzakFontStyle {
        if index == 2 {
            return isRegisterTabActive ? .caption1Bold12 : .caption3Medium12
        }
        return isRegisterTabActive ? .caption3Medium12 :
        (selectedTab == index ? .caption1Bold12 : .caption3Medium12)
    }
}

#Preview {
    TabBarView()
}
