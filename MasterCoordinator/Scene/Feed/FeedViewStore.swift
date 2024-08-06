//
//  FeedViewStore.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 24.07.2024.
//

import Combine
import Observation

enum FeedViewAction {
    case nextButtonTapped
    case dismissButtonTapped
    case popToRootButtonTapped
    case logoutButtonTapped
}

@Observable
final class FeedViewStore {
    
    private let coordinator: FeedCoordinator
    
    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor func send(_ action: FeedViewAction) {
        switch action {
        case .nextButtonTapped:
            coordinator.navigate(to: .detail)
        case .dismissButtonTapped:
            coordinator.pop()
        case .popToRootButtonTapped:
            coordinator.popToRoot()
        case .logoutButtonTapped:
            break
        }
    }
}