//
//  SheetPath.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct SheetPath: Identifiable {
    var id: String { sheet?.id ?? UUID().uuidString }
    var sheet: SheetContainer?

    mutating func setSheet<T>(_ sheet: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
        self.sheet = SheetContainer(sheet, onDismiss: onDismiss)
    }
}
