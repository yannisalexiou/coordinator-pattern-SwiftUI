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
    private var isPushed: Bool = false
    
    @ViewBuilder @MainActor var rootView: some View {
        OnboardingView(store: OnboardingViewStore(coordinator: self, screenNumber: 1, isPushed: isPushed))
            .navigationDestination(for: OnboardingCoordinatorRoute.self, destination: coordinate(_:))
    }
    
    // MARK: LifeCycle
    init(navigationController: NavigationController? = nil) {
        if let navigationController {
            self.navigationController = navigationController
            self.isPushed = true
        } else {
            self.navigationController = NavigationController()
        }
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
            OnboardingView(store: OnboardingViewStore(coordinator: self, screenNumber: screenNumber, isPushed: isPushed))
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
    
    func dismissSheet(dismiss: DismissAction) {
        dismiss()
        dismiss()
        parent?.didFinish()
    }
}
