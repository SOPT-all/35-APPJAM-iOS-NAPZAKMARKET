//
//  String+.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/14/25.
//

import SwiftUI

extension String {
    
    /// 줄바꿈이 포함되어있을 때 줄바꿈이 되는 기준이 char 단위가 되도록 해줌
    var forceCharWrapping: Self {
        self.map({ String($0) }).joined(separator: "\u{200B}")
    }
    
    // MARK: - 문자열을 금액 형태로 바꿔주는 함수

    func convertPrice(maxPrice: Int) -> String {
        // 숫자만 남기기
        let filteredPrice = self.filter { $0.isNumber }
        guard let price = Int(filteredPrice) else { return "" }
        
        // 최대 금액 제한
        let limitedPrice = min(price, maxPrice)
        
        // 숫자를 3자리마다 쉼표로 구분
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: limitedPrice as NSNumber) ?? ""
    }
}
