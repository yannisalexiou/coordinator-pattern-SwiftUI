//
//  AlertPath.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import Foundation

struct AlertPath {

    var alert: AlertDisplayable?

    mutating func setAlert<T>(_ alert: T) where T: AlertDisplayable {
        self.alert = alert
    }
}
