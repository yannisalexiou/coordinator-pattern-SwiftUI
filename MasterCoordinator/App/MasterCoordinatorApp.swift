//
//  MasterCoordinatorApp.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

@main
struct MasterCoordinatorApp: App {
    @StateObject
    var coordinator = AppCoordinator()
    
    init() {
        let appCoordinator = AppCoordinator()
        _coordinator = StateObject(wrappedValue: appCoordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView
                .id(coordinator.isOnboarding)
        }
    }
}
