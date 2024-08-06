//
//  Store.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

protocol Store {
    associatedtype State
    associatedtype Action
    
    @MainActor var state: State { get }
    
    @MainActor func send(_ action: Action)
}
