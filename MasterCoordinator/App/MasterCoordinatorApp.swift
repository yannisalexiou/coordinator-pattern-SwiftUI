//
//  MasterCoordinatorApp.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

@main
struct MasterCoordinatorApp: App {
    
    let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView
                .id(coordinator.isOnboarding)
        }
    }
}
