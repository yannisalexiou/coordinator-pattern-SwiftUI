//
//  View+Alert.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

extension View {
    func alert(for alertPath: Binding<AlertPath>) -> some View {
        self.modifier(AlertModifier(alertPath: alertPath))
    }
}
