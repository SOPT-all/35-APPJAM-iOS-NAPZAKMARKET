//
//  View+.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/9/25.
//

import SwiftUI

extension View {
    func applyNapzakTextStyle(napzakFontStyle: NapzakFontStyle) -> some View {
        let fontSpacing: CGFloat = Font.toUIFont(napzakFontStyle).lineHeight / 100 * 40 / 4
        var letterSpacing: CGFloat = 0
        
        switch napzakFontStyle {
        case .title1Bold22:
            letterSpacing = -0.44
        case .title2Bold20:
            letterSpacing = -0.4
        case .title3SemiBold20:
            letterSpacing = -0.4
        case .title4Bold18:
            letterSpacing = -0.36
        case .title5SemiBold18:
            letterSpacing = -0.36
        case .title6Medium18:
            letterSpacing = -0.36
        
        case .body1Bold16:
            letterSpacing = -0.32
        case .body2SemiBold16:
            letterSpacing = -0.32
        case .body3Medium16:
            letterSpacing = -0.32
        case .body4Bold14:
            letterSpacing = -0.28
        case .body5SemiBold14:
            letterSpacing = -0.28
        case .body6Medium14:
            letterSpacing = -0.28
        
        case .caption1Bold12:
            letterSpacing = -0.24
        case .caption2SemiBold12:
            letterSpacing = -0.24
        case .caption3Medium12:
            letterSpacing = -0.24
        }

        return self.modifier(NapzakTextStyleModifier(fontSpacing: fontSpacing, letterSpacing: letterSpacing))
    }
}
