//
//  AppEntryView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct AppEntryView: View {
    
    @State private var isOnboardingComplete: Bool = false
    
    var body: some View {
        if isOnboardingComplete {
            HomeView()
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
        }
    }
    
}
