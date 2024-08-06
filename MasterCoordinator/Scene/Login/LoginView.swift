//
//  LoginView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 06.08.2024.
//

import SwiftUI

struct LoginView: View {
    
    var store: LoginViewStore
    
    init(store: LoginViewStore) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack { // <- just for navigation Title
            List {
                Button("Login") {
                    store.send(.loginButtonTapped)
                }
            }
            .navigationTitle("Login View")
        }
    }
}
