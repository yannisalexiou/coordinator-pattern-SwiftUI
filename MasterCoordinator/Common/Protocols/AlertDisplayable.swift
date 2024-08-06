//
//  AlertDisplayable.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

protocol AlertDisplayable {
    var title: String { get }
    var message: String? { get }
    var buttons: [AlertButton] { get }
}
