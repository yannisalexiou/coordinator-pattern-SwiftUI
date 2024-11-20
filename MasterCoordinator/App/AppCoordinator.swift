//
//  AppCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    // MARK: private properties
    private var cancellables = Set<AnyCancellable>()
    private var tabBarCoordinator: TabBarCoordinator?
    private var loginCoordinator: LoginCoordinator?
    
    // MARK: Public properties
    @Published
    var isOnboarding: Bool = true
    
    @MainActor
    @ViewBuilder
    var rootView: some View {
        if isOnboarding {
            if let loginCoordinator {
                loginCoordinator.rootView
                    .onAppear { [weak self] in
                        self?.didFinish()
                    }
            }
        } else {
            if let tabBarCoordinator {
                TabBarView(coordinator: tabBarCoordinator)
                    .onAppear { [weak self] in
                        self?.didFinish()
                    }
            }
        }
    }
    
    // MARK: Lifecycle
    init() {
        if isOnboarding {
            makeLoginFlow()
        } else {
            makeTabBarFlow()
        }
    }
}

// MARK: - Factory
private extension AppCoordinator {
    private func makeLoginFlow() {
        loginCoordinator = LoginCoordinator()
        loginCoordinator?.parent = self
        loginCoordinator?.eventPublisher.sink { [weak self] event in
            switch event {
            case .login:
                self?.isOnboarding = false
                self?.makeTabBarFlow()
            }
        }
        .store(in: &cancellables)
    }
    
    private func makeTabBarFlow() {
        tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator?.parent = self
        tabBarCoordinator?.eventPublisher.sink { [weak self] event in
            switch event {
            case .logout:
                self?.isOnboarding = true
                self?.makeLoginFlow()
            }
        }
        .store(in: &cancellables)
    }
}

// MARK: - Child handler
extension AppCoordinator: LoginCoordinatorParent, TabBarCoordinatorParent {
    func didFinish() {
        if isOnboarding {
            tabBarCoordinator = nil
        } else {
            loginCoordinator = nil
        }
    }
}
