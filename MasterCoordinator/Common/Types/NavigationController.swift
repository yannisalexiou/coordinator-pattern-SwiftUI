//
//  NavigationController.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 23.07.2024.
//

import Foundation
import SwiftUI

final class NavigationController: ObservableObject {
    @Published
    var navigationPath: NavigationPath = .init()
    @Published
    var alertPath = AlertPath()
    @Published
    var sheetPath: SheetPath = .init()
    @Published
    var coverPath: CoverPath = .init()
    
    var screenCount: Int {
        navigationPath.count
    }
    
    func push<T>(_ route: T) where T: Codable & Hashable {
        navigationPath.append(route)
    }
    
    func dismiss(_ pages: Int? = nil) {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast(pages ?? 1)
    }
    
    func presentAlert<T>(_ alert: T) where T: AlertDisplayable {
        alertPath.setAlert(alert)
    }
    
    func presentSheet<T>(_ route: T, onDismiss: (() -> Void)? = nil)  where T: Codable & Identifiable & Hashable  {
        sheetPath.setSheet(route, onDismiss: onDismiss)
    }
    
    func presentCover<T>(_ route: T, onDismiss: (() -> Void)? = nil)  where T: Codable & Identifiable & Hashable  {
        coverPath.setCover(route, onDismiss: onDismiss)
    }
}
