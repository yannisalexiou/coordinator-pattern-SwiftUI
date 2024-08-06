//
//  SheetFactoryKey.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct SheetFactoryKey: PreferenceKey {
    static var defaultValue: [String: NavigationViewFactory] = [:]
    static func reduce(value: inout [String: NavigationViewFactory], nextValue: () -> [String: NavigationViewFactory]) { value.merge(nextValue()) { $1 } }
}
