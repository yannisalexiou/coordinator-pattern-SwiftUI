//
//  CoverModifier.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct CoverModifier: ViewModifier {
    @Binding var data: CoverPath
    @State private var factories: [String: NavigationViewFactory] = [:]

    init(data: Binding<CoverPath>) {
        self._data = data
    }

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(CoverFactoryKey.self) { factories = $0 }
            .fullScreenCover(item: _data.cover, onDismiss: data.cover?.onDismiss, content: { factories[data.id]?.factory($0.cover) })
    }
}
