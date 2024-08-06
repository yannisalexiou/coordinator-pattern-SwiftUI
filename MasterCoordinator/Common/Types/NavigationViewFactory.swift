//
//  NavigationViewFactory.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct NavigationViewFactory: Equatable {
    let id: String
    let factory: (Any) -> AnyView
    
    init<D,C>(_ type: D.Type, @ViewBuilder _ factory: @escaping (D) -> C) where D: Identifiable, C: View {
        self.id = String(describing: type)
        self.factory = { value in
            if let value = value as? D {
                AnyView(factory(value))
            } else {
                AnyView(Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow))
            }
        }
    }
    
    static func == (lhs: NavigationViewFactory, rhs: NavigationViewFactory) -> Bool { lhs.id == rhs.id }
}
