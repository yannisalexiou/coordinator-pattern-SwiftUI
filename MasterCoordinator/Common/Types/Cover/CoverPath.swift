//
//  CoverPath.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct CoverPath: Identifiable {
    var id: String { cover?.id ?? UUID().uuidString }
    var cover: CoverContainer?

    mutating func setCover<T>(_ cover: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
        self.cover = CoverContainer(cover, onDismiss: onDismiss)
    }
}
