//
//  ProfileViewStore.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import Combine

final class ProfileViewStore: Store, ObservableObject {
    // MARK: Public properties
    @MainActor var state: ProfileViewState = .initial
    
    // MARK: private properties
    private let coordinator: ProfileCoordinator
    
    // MARK: Lifecycle
    @MainActor
    init(coordinator: ProfileCoordinator, screenNumber: Int) {
        self.coordinator = coordinator
        self.state.screenNumber = screenNumber
    }
}

// MARK: - Action sender
extension ProfileViewStore {
    @MainActor func send(_ action: ProfileViewAction) {
        switch action {
        case .nextButtonTapped:
            state.screenNumber += 1
            coordinator.navigate(to: .detail(state.screenNumber))
            
        case .pushMultipleScreen:
            let screenNumber = state.screenNumber
            for number in 1...3 {
                coordinator.navigate(to: .detail(screenNumber + number))
            }
            
        case .dismissButtonTapped:
            coordinator.dismissScreen()
            
        case .popToRootButtonTapped:
            let screenCount = coordinator.navigationController.screenCount
            coordinator.dismissScreen(screenCount)
            
        case .logoutButtonTapped:
            coordinator.logout()
            
        case .goToOnboarding:
            coordinator.pushOnboarding()
            
        case .sheetOnboarding:
            coordinator.presentSheet {
                self.coordinator.didFinish()
            }
            
        case .coverOnboarding:
            coordinator.presentCover()
            
        case .alertButtonTapped:
            coordinator.presentAlert(
                CustomAlert(title: "This is the title.", message: "This is the message.", buttons: [
                    .actionButton(title: "First action", action: {
                        
                    }),
                    .actionButton(title: "Second action", action: {
                        
                    }),
                    .destructiveButton(title: "Destruction", action: {
                        
                    }),
                    .cancelButton(title: "Cancel", action: {
                        
                    })
                ])
            )
            
        }
    }
}
