//
//  HomeCoordinatorRoute.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

enum HomeCoordinatorRoute: Codable, Hashable, Identifiable {
    var id: String { String(describing: self) }
    
    case detail(Int)
    case pushOnboarding
    case sheetOnboarding
    case coverOnboarding
}
