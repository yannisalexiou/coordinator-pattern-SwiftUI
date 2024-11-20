//
//  FirstCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI
import Combine

final class ProfileCoordinator: Coordinator {
    // MARK: Private properties
    private let eventSubject = PassthroughSubject<ProfileCoordinatorEvent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Public properties
    weak var parent: ProfileCoordinatorParent?
    
    var onboardingCoordinator: OnboardingCoordinator?
    var navigationController: NavigationController
    
    @ViewBuilder @MainActor var rootView: some View {
        ProfileView(store: ProfileViewStore(coordinator: self, screenNumber: 1))
            .navigationDestination(for: ProfileCoordinatorRoute.self, destination: coordinate(_:))
            .sheetDestination(for: ProfileCoordinatorRoute.self, sheet: coordinate(_:))
            .coverDestination(for: ProfileCoordinatorRoute.self, cover: coordinate(_:))
            .onAppear { [weak self] in
                self?.didFinish()
            }
    }
    
    
    // MARK: Lifecycle
    init(navigationController: NavigationController = NavigationController()) {
        self.navigationController = navigationController
        print("Init profile")
    }
    
    deinit {
        print("Deinit Profile")
    }
}

// MARK: - event emitter
extension ProfileCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Coordinating
extension ProfileCoordinator {
    @ViewBuilder @MainActor func coordinate(_ route: ProfileCoordinatorRoute) -> some View {
        switch route {
        case let .detail(screenNumber):
            ProfileView(store: ProfileViewStore(coordinator: self, screenNumber: screenNumber))
        case .pushOnboarding:
            onboardingCoordinator?.rootView
        case .sheetOnboarding:
            if let onboardingCoordinator {
                CoordinatedView(onboardingCoordinator)
                    .presentationDetents([.large, .medium])
            }
        case .coverOnboarding:
            if let onboardingCoordinator {
                CoordinatedView(onboardingCoordinator)
            }
        }
    }
}

// MARK: - Factory
extension ProfileCoordinator {
    func navigate(to route: ProfileCoordinatorRoute) {
        navigationController.push(route)
    }
    
    func dismissScreen(_ count: Int = 1) {
        navigationController.dismiss(count)
    }
    
    func logout() {
        eventSubject.send(.logout)
    }
    
    func presentAlert<T>(_ alert: T) where T: AlertDisplayable {
        navigationController.presentAlert(alert)
    }
    
    func pushOnboarding() {
        makeOnboardingFlow(navigationController: navigationController)
        navigate(to: .pushOnboarding)
    }
    
    func makeOnboardingFlow(navigationController: NavigationController? = nil) {
        if let navigationController {
            onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        } else {
            onboardingCoordinator = OnboardingCoordinator()
        }
        onboardingCoordinator?.parent = self
    }
    
    func presentSheet(onDismiss: (() -> Void)? = nil) {
        makeOnboardingFlow()
        navigationController.presentSheet(ProfileCoordinatorRoute.sheetOnboarding, onDismiss: onDismiss)
    }
    
    func presentCover(onDismiss: (() -> Void)? = nil) {
        makeOnboardingFlow()
        navigationController.presentCover(ProfileCoordinatorRoute.coverOnboarding, onDismiss: onDismiss)
    }
}

// MARK: - Handle child
extension ProfileCoordinator: OnboardingCoordinatorParent {
    func didFinish() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.onboardingCoordinator = nil
        }
    }
}
