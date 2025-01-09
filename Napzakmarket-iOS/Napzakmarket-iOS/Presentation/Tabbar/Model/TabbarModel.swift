//
//  TabbarModel.swift
//  Napzakmarket-iOS
//
//  Created by 어진 on 1/10/25.
//

import Foundation
import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let defaultIcon: String
    let selectedIcon: String
    let view: AnyView?
}
