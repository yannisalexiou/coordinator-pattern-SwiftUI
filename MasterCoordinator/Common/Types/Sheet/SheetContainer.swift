//
//  SheetContainer.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct SheetContainer: Identifiable {
    let id: String
    let sheet: Any
    let onDismiss: (() -> Void)?

    init<T>(_ sheet: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
        self.id = String(describing: T.self)
        self.sheet = sheet
        self.onDismiss = onDismiss
    }
}
