//
//  AppState.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/16/25.
//

import Foundation

enum AppScreen {
    case splash
    case onboarding
    case main
}

class AppState: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var currentScreen: AppScreen = .splash
    
    // TODO: - 추후에 앱 전역으로 사용되는 로그인 정보 (장르선택했는가?)에 따라 온보딩일지, 탭바뷰일지 나타낸다.
    
    func moveToSplash() {
        currentScreen = .splash
    }
    
    func moveToOnboarding() {
        currentScreen = .onboarding
    }
    
    func moveToMain() {
        currentScreen = .main
    }
    
}
