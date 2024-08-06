//
//  TabBarItem.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

enum TabBarItem {
    case home
    case profile
    
    var title: String {
        switch self {
        case .home:    return "Home"
        case .profile:   return "Profile"
        }
    }
    
    var image: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        }
    }
}
