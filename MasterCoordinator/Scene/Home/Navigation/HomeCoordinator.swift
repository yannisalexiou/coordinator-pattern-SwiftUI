//
//  FirstCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI
import Combine
import Observation
import os

@Observable
final class HomeCoordinator: Coordinator {
    let navigationController = NavigationController()
    
    private let eventSubject = PassthroughSubject<HomeCoordinatorEvent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var onboardingCoordinator: OnboardingCoordinator?
    var presentationDetents: Set<PresentationDetent> = [.fraction(0.999), .medium]
    
    @ViewBuilder @MainActor var rootView: some View {
        HomeView(store: HomeViewStore(coordinator: self, screenNumber: 1))
            .navigationDestination(for: HomeCoordinatorRoute.self, destination: coordinate(_:))
            .sheetDestination(for: HomeCoordinatorRoute.self, sheet: coordinate(_:))
            .coverDestination(for: HomeCoordinatorRoute.self, cover: coordinate(_:))
            .onAppear { [weak self] in
                self?.didFinish()
            }
    }
    
    init() {
        print("Init Home")
    }
    
    deinit {
        print("Deinit HomeCoordinator")
    }
}

// MARK: - Event Emitter
extension HomeCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<HomeCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Coordinating
extension HomeCoordinator {
    @ViewBuilder @MainActor func coordinate(_ route: HomeCoordinatorRoute) -> some View {
        switch route {
        case let .detail(screenNumber):
            HomeView(store: HomeViewStore(coordinator: self, screenNumber: screenNumber))
        case .pushOnboarding:
            onboardingCoordinator?.rootView
        case .sheetOnboarding:
            if let onboardingCoordinator {
                CoordinatedView(onboardingCoordinator)
//                    .interactiveDismissDisabled()
                    .presentationDetents(presentationDetents)
            }
        case .coverOnboarding:
            if let onboardingCoordinator {
                CoordinatedView(onboardingCoordinator)
            }
        }
    }
}

// MARK: - Methods
extension HomeCoordinator {
    func navigate(to route: HomeCoordinatorRoute) {
        navigationController.push(route)
    }
    
    func dismissScreen(_ count: Int = 1) {
        navigationController.dismiss(count)
    }
    
    func logout() {
        eventSubject.send(.logout)
    }
    
    func makeOnboardingFlow(navigationController: NavigationController? = nil) {
        if let navigationController {
            onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        } else {
            onboardingCoordinator = OnboardingCoordinator()
        }
        onboardingCoordinator?.parent = self
        onboardingCoordinator?.eventPublisher.sink { [weak self] event in
            switch event {
            case let .dismiss(dismiss):
                break
                
            }
        }
        .store(in: &cancellables)
    }
    
    func presentAlert<T>(_ alert: T) where T: AlertDisplayable {
        navigationController.presentAlert(alert)
    }
    
    func pushOnboarding() {
        makeOnboardingFlow(navigationController: navigationController)
        navigate(to: .pushOnboarding)
    }
    
    func presentSheet(onDismiss: (() -> Void)? = nil) {
        makeOnboardingFlow()
        navigationController.presentSheet(HomeCoordinatorRoute.sheetOnboarding, onDismiss: onDismiss)
    }
    
    func presentCover(onDismiss: (() -> Void)? = nil) {
        makeOnboardingFlow()
        navigationController.presentCover(HomeCoordinatorRoute.coverOnboarding, onDismiss: onDismiss)
    }
    
    
}

extension HomeCoordinator: OnboardingCoordinatorParent {
    func didFinish() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.onboardingCoordinator = nil
        }
    }
}
