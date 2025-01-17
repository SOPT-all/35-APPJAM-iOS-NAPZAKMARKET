//
//  SplashView.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/16/25.
//

import SwiftUI

import Lottie

struct SplashView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appState: AppState
    @State private var showButton: Bool = false
    
    // MARK: - Main Body
    
    var body: some View {
        ZStack {
            LottieView(animation: .named("splash(ios)"))
                .configure({ lottieAnimationView in
                    lottieAnimationView.contentMode = .scaleAspectFill
                    lottieAnimationView.shouldRasterizeWhenIdle = true
                })
                .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
                .animationDidFinish { _ in
                    withAnimation(.easeIn(duration: 0.3)) {
                        showButton = true
                    }
                }
                .ignoresSafeArea(.all)
         
            if showButton {
                VStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            appState.moveToOnboarding()
                        }
                    } label: {
                        Text("선택완료! 시작하기")
                            .font(.napzakFont(.body1Bold16))
                            .applyNapzakTextStyle(napzakFontStyle: .body1Bold16)
                            .foregroundStyle(Color.napzakGrayScale(.white))
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .background(Color.napzakGrayScale(.black))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 45)
            }
        }
    }
    
}
