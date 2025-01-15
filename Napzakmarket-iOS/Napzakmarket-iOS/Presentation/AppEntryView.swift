//
//  AppEntryView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/14/25.
//

import SwiftUI

struct AppEntryView: View {
    
    // MARK: - Properties
    
    @State private var isOnboardingComplete: Bool = false
    
    // MARK: - Main Body
    
    var body: some View {
        if isOnboardingComplete {
            TabBarView()
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
        }
    }
    
}
