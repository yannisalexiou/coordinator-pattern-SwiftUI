//
//  AlertButton.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct AlertButton: Identifiable {
    var id: String = UUID().uuidString
    
    let title: String
    let role: ButtonRole?
    let action: () -> Void

    private init(title: String, role: ButtonRole?, action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.action = action
    }
    
    static func actionButton(title: String, action: @escaping () -> Void) -> Self {
        AlertButton(title: title, role: nil, action: action)
    }

    static func cancelButton(title: String, action: @escaping () -> Void) -> Self {
        AlertButton(title: title, role: .cancel, action: action)
    }

    static func destructiveButton(title: String, action: @escaping () -> Void) -> Self {
        AlertButton(title: title, role: .destructive, action: action)
    }
}
