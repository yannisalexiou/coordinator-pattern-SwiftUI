//
//  CustomAlert.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct CustomAlert: AlertDisplayable {
    var title: String
    var message: String?
    var buttons: [AlertButton]
    
    init(title: String, message: String? = nil, buttons: [AlertButton]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}
