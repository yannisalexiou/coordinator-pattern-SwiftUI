//
//  View+Sheet.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

extension View {
    public func sheetDestination<D,C>(for data: D.Type, @ViewBuilder sheet: @escaping (D) -> C) -> some View where D: Identifiable & Hashable, C : View  {
        preference(key: SheetFactoryKey.self, value: [String(describing: data): NavigationViewFactory(data, sheet)])
    }

    public func coverDestination<D,C>(for data: D.Type, @ViewBuilder cover: @escaping (D) -> C) -> some View where D: Identifiable & Hashable, C : View  {
        preference(key: CoverFactoryKey.self, value: [String(describing: data): NavigationViewFactory(data, cover)])
    }
}

extension View {
    func sheet(for sheetPath: Binding<SheetPath>) -> some View {
        modifier(SheetModifier(sheetPath: sheetPath))
    }

    func cover(for data: Binding<CoverPath>, onDismiss: (() -> Void)? = nil) -> some View {
        modifier(CoverModifier(data: data))
    }
}
