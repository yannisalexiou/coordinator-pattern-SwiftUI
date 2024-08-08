//
//  FirstViewStore.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import Combine
import Observation

@Observable
final class OnboardingViewStore: Store {
    @MainActor var state: OnboardingViewState = .initial
    
    private let coordinator: OnboardingCoordinator
    
    @MainActor
    init(coordinator: OnboardingCoordinator, screenNumber: Int, isPushed: Bool) {
        self.coordinator = coordinator
        self.state.screenNumber = screenNumber
        self.state.isPushed = isPushed
    }
}

// MARK: - Action sender
extension OnboardingViewStore {
    @MainActor func send(_ action: OnboardingViewAction) {
        switch action {
        case .nextButtonTapped:
            state.screenNumber += 1
            coordinator.navigate(to: .detail(state.screenNumber))
            
        case .dismissButtonTapped:
            coordinator.dismissScreen(1)
            
        case .popToRootButtonTapped:
            coordinator.dismissScreen(coordinator.navigationController.screenCount)
            
        case let .dismissSheet(dismiss):
            coordinator.dismissSheet(dismiss: dismiss)
        }
    }
}
