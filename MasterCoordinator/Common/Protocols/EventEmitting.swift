//
//  EventEmitting.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Combine

protocol EventEmitting {
    associatedtype Event
    
    var eventPublisher: AnyPublisher<Event, Never> { get }
}
