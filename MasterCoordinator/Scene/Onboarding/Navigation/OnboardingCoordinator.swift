//
//  FirstCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI
import Combine
import Observation

@Observable
final class OnboardingCoordinator: Coordinator {
    // MARK: Public properties
    weak var parent: OnboardingCoordinatorParent?
    var navigationController: NavigationController
    
    // MARK: private properties
    private let eventSubject = PassthroughSubject<OnboardingCoordinatorEvent, Never>()
    
    @ViewBuilder @MainActor var rootView: some View {
        OnboardingView(store: OnboardingViewStore(coordinator: self, screenNumber: 1))
            .navigationDestination(for: OnboardingCoordinatorRoute.self, destination: coordinate(_:))
    }
    
    // MARK: LifeCycle
    init(navigationController: NavigationController = NavigationController()) {
        self.navigationController = navigationController
        print("Init Onboarding")
    }
    
    deinit {
        print("Deinit Onboarding")
    }
}

// MARK: - Coordinating
extension OnboardingCoordinator {
    @ViewBuilder @MainActor func coordinate(_ route: OnboardingCoordinatorRoute) -> some View {
        switch route {
        case let .detail(screenNumber):
            OnboardingView(store: OnboardingViewStore(coordinator: self, screenNumber: screenNumber))
        }
    }
}

// MARK: - Methods
extension OnboardingCoordinator {
    func navigate(to route: OnboardingCoordinatorRoute) {
        navigationController.push(route)
    }
    
    func dismissScreen(_ count: Int) {
        navigationController.dismiss(count)
    }
    
    func dismissSheet() {
        eventSubject.send(.dismiss)
    }
}

// MARK: - Event emitter
extension OnboardingCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
