//
//  ColorLiteral.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/10/25.
//

import SwiftUI

enum Purple: String {
    case purple10 = "F1E8FF"
    case purple20 = "C0A1FF"
    case purple30 = "7534FF"
}

enum Pink: String {
    case pink = "FF195E"
}

enum GrayScale: String {
    case white = "FFFFFF"
    case gray50 = "FAFAFA"
    case gray100 = "F4F4F4"
    case gray200 = "E9E9E9"
    case gray300 = "D9D9D9"
    case gray400 = "C4C4C4"
    case gray500 = "9D9D9D"
    case gray600 = "7B7B7B"
    case gray700 = "555555"
    case gray800 = "434343"
    case gray900 = "262626"
    case black = "010101"
}

enum Transparency: String {
    case black70 = "000000"
    case white20 = "FFFFFF"
}

enum Gradient {
    case gradient1FirstColor
    case gradient1SecondColor
}

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let hexCode: Int = Int(hex, radix: 16)!
        let red = Double((hexCode >> 16) & 0xff) / 255
        let green = Double((hexCode >> 8) & 0xff) / 255
        let blue = Double((hexCode >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static func napzakPurple(_ color: Purple) -> Color {
        return Color(hex: color.rawValue)
    }
    
    static func napzakPink(_ color: Pink) -> Color {
        return Color(hex: color.rawValue)
    }
    
    static func napzakGrayScale(_ color: GrayScale) -> Color {
        return Color(hex: color.rawValue)
    }
    
    static func napzakTransparency(_ color: Transparency) -> Color {
        let opacity: Double
        switch color {
        case .black70:
            opacity = 0.7
        case .white20:
            opacity = 0.2
        }
        return Color(hex: color.rawValue, opacity: opacity)
    }
    
    static func napzakGradient(_ color: Gradient) -> Color {
        switch color {
        case .gradient1FirstColor:
            let opacity = 0.0
            return Color(hex: "FFFFFF", opacity: opacity)
        case .gradient1SecondColor:
            let opacity = 100.0
            return Color(hex: "FFFFFF", opacity: opacity)
        }
    }
}
