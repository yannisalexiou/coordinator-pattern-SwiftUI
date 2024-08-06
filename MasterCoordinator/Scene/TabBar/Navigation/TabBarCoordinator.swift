//
//  TabBarCoordinator.swift
//  CoordinatorIOS17
//
//  Created by Tomáš Duchoslav on 21.07.2024.
//

import SwiftUI
import Combine

@Observable
final class TabBarCoordinator: ObservableObject {
    
    // MARK: private properties
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<TabBarCoordinatorEvent, Never>()
    
    // MARK: public properties
    let homeCoordinator = HomeCoordinator()
    let profileCoordinator = ProfileCoordinator()
    let tabs: [TabBarItem] = [.home, .profile]
    var selectedTab: TabBarItem = .home
    
    weak var parent: TabBarCoordinatorParent?
    
    init() {
        print("Init tabBarContr")
        profileReceiver()
        homeReceiver()
    }
    
    deinit {
        print("Deinit tabBarContr")
    }
}

// MARK: - Event emitter
extension TabBarCoordinator {
    var eventPublisher: AnyPublisher<TabBarCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Methods
private extension TabBarCoordinator {
    func profileReceiver() {
        profileCoordinator.eventPublisher.sink { [weak self] event in
            switch event {
            case .logout:
                self?.eventSubject.send(.logout)
            }
        }
        .store(in: &cancellables)
    }
    
    func homeReceiver() {
        homeCoordinator.eventPublisher.sink { [weak self] event in
            switch event {
            case .logout:
                self?.eventSubject.send(.logout)
            }
        }
        .store(in: &cancellables)
    }
}
