//
//  LoginCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI
import Combine

protocol LoginCoordinatorParent: AnyObject {
    func didFinish()
}

final class LoginCoordinator {
    // MARK: Private properties
    private let eventSubject = PassthroughSubject<LoginCoordinatorEvent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Public properties
    weak var parent: LoginCoordinatorParent?
    
    @ViewBuilder @MainActor var rootView: some View {
        LoginView(store: LoginViewStore(coordinator: self))
    }
    
    // MARK: Lifecycle
    init() {
        print("Init Login")
    }
    
    deinit {
        print("Deinit Login")
    }
}

// MARK: - Event Emitter
extension LoginCoordinator {
    var eventPublisher: AnyPublisher<LoginCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Methods
extension LoginCoordinator {
    func login() {
        eventSubject.send(.login)
    }
}
