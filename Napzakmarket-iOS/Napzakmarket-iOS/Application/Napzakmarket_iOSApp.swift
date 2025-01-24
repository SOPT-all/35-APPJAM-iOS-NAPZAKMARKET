//
//  Napzakmarket_iOSApp.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/5/25.
//

import SwiftUI

@main
struct Napzakmarket_iOSApp: App {
    
    // MARK: - Properties
    
    @StateObject private var appState = AppState()
    @StateObject private var tabBarState = TabBarStateModel()
    
    // MARK: - Main Body
    
    var body: some Scene {
        WindowGroup {
            AppEntryView()
                .environmentObject(appState)
                .environmentObject(tabBarState)
        }
    }
    
}
