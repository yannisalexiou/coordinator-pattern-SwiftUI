//
//  CoordinatedView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

struct CoordinatedView<C>: View where C: Coordinator {
    private let coordinator: C
    @StateObject
    private var navigationController: NavigationController
    
    init(_ coordinator: C) {
        self.coordinator = coordinator
        _navigationController = StateObject(wrappedValue: coordinator.navigationController)
    }
    
    var body: some View {
        NavigationStack(path: $navigationController.navigationPath) {
            coordinator.rootView
        }
        .sheet(for: $navigationController.sheetPath)
        .cover(for: $navigationController.coverPath)
        .alert(for: $navigationController.alertPath)
    }
}
