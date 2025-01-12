//
//  TextEditor+.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/8/25.
//

import SwiftUI

extension TextEditor {
    
    // MARK: - 글자 수 제한
    
    func maxLength(_ length: Int, text: Binding<String>) -> some View {
        self
            .onChange(of: text.wrappedValue, { oldValue, newValue in
                if newValue.count > length {
                    text.wrappedValue = String(newValue.prefix(length))
                }
            })
    }
}
