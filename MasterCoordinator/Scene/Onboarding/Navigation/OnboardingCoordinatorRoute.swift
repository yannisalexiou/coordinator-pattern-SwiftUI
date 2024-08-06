//
//  OnboardingCoordinatorRoute.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

enum OnboardingCoordinatorRoute: Codable, Hashable {
    var id: String { String(describing: self) }
    
    case detail(Int)
}
