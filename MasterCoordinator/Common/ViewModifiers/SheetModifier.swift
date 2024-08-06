//
//  SheetModifier.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct SheetModifier: ViewModifier {
    @Binding var sheetPath: SheetPath
    @State private var factories: [String: NavigationViewFactory] = [:]

    init(sheetPath: Binding<SheetPath>) {
        self._sheetPath = sheetPath
    }

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(SheetFactoryKey.self) { factories = $0 }
            .sheet(item: _sheetPath.sheet, onDismiss: sheetPath.sheet?.onDismiss, content: { factories[sheetPath.id]?.factory($0.sheet) })
    }
}
