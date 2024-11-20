//
//  FirstCoordinator.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI
import Combine

protocol FeedCoordinatorParent: AnyObject {
    func selectTab(_ tab: TabBarItem)
}

enum FeedCoordinatorRoute: Int, Codable, Hashable {
    var id: String { String(describing: self) }
    
    case detail = 0
    case secondDetail
}

final class FeedCoordinator: Coordinator {
    
    private var cancellables = Set<AnyCancellable>()
    
    let navigationController = NavigationController()
    @ViewBuilder @MainActor var rootView: some View {
        FeedView(store: FeedViewStore(coordinator: self))
            .navigationDestination(for: FeedCoordinatorRoute.self, destination: coordinate(_:))
    }
    
    init() {
        print("Init feed")
    }
    
    deinit {
        print("Deinit feed")
    }
}

// MARK: - Coordinating
extension FeedCoordinator {
    func navigate(to route: FeedCoordinatorRoute) {
        navigationController.push(route)
    }
    
    func popToRoot() {
        guard !navigationController.navigationPath.isEmpty else { return }
        navigationController.dismiss(navigationController.navigationPath.count)
    }
    
    func pop() {
        guard !navigationController.navigationPath.isEmpty else { return }
        navigationController.dismiss()
    }
    
    @ViewBuilder @MainActor func coordinate(_ route: FeedCoordinatorRoute) -> some View {
        switch route {
        case .detail:
            FeedView(store: FeedViewStore(coordinator: self))
        case .secondDetail:
            FeedView(store: FeedViewStore(coordinator: self))
        }
    }
}
