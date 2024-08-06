//
//  CoordinatedView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

struct CoordinatedView<C>: View where C: Coordinator {
    var coordinator: C
    
    init(_ coordinator: C) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        @Bindable var navigationController = coordinator.navigationController
        NavigationStack(path: $navigationController.navigationPath) {
            coordinator.rootView
        }
        .sheet(for: $navigationController.sheetPath)
        .cover(for: $navigationController.coverPath)
        .alert(for: $navigationController.alertPath)
    }
}
