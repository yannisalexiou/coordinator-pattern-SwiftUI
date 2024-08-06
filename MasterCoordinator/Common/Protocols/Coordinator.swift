//
//  Router.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Route: Codable, Hashable
    associatedtype Destination: View
    associatedtype Root: View
    
    var navigationController: NavigationController { get }
    
    @ViewBuilder @MainActor var rootView: Root { get }
    @ViewBuilder @MainActor func coordinate(_ route: Route) -> Destination
}
