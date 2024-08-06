//
//  FeedView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 24.07.2024.
//

import SwiftUI

struct FeedView: View {
    
    var store: FeedViewStore
    
    init(store: FeedViewStore) {
        self.store = store
    }
    
    var body: some View {
        Text("Feed View")
        Button("Next") {
            store.send(.nextButtonTapped)
        }
        
        Button("Dismiss") {
            store.send(.dismissButtonTapped)
        }
        
        Button("PopToRoot") {
            store.send(.popToRootButtonTapped)
        }
        Button("LogOut") {
            store.send(.logoutButtonTapped)
        }
    }
}
