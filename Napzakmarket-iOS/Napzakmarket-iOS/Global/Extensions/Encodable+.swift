//
//  Encodable+.swift
//  Napzakmarket-iOS
//
//  Created by 조호근 on 1/22/25.
//

import Foundation

extension Encodable {
    
    var jsonString: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let json = String(data: data, encoding: .utf8) else { return "{}" }
        return json
    }
    
}
