//
//  AppEntryView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct AppEntryView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appState: AppState
    
    // MARK: - Main Body
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .splash:
                SplashView()
                    .transition(.opacity)
            case .onboarding:
                OnboardingView()
                    .transition(.opacity)
            case .main:
                TabBarView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: appState.currentScreen)
    }
    
}
