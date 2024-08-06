//
//  CoverContainer.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct CoverContainer: Identifiable {
    let id: String
    let cover: Any
    let onDismiss: (() -> Void)?

    init<T>(_ cover: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
        self.id = String(describing: T.self)
        self.cover = cover
        self.onDismiss = onDismiss
    }
}
