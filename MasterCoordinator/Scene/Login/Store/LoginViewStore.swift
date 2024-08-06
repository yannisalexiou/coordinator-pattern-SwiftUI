//
//  ProfileViewStore.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import Combine
import Observation

@Observable
final class LoginViewStore: Store {
    // MARK: Public properties
    @MainActor var state: LoginViewState = .initial
    
    // MARK: private properties
    private let coordinator: LoginCoordinator
    
    // MARK: Lifecycle
    @MainActor
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Action sender
extension LoginViewStore {
    @MainActor func send(_ action: LoginViewAction) {
        switch action {
        case .loginButtonTapped:
            coordinator.login()
        }
    }
}
