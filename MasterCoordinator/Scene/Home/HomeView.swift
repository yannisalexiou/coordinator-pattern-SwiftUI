//
//  HomeView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    var store: HomeViewStore
    
    init(store: HomeViewStore) {
        self.store = store
    }
    
    var body: some View {
        List {
            Button("Next") {
                store.send(.nextButtonTapped)
            }
            
            Button("Push 3 screen") {
                store.send(.pushMultipleScreen)
            }
            
            Button("Dismiss") {
                store.send(.dismissButtonTapped)
            }
            
            Button("Pop to root") {
                store.send(.popToRootButtonTapped)
            }
            
            Button("Alert") {
                store.send(.alertButtonTapped)
            }
            
            Button("Push onboarding") {
                store.send(.goToOnboarding)
            }
            
            Button("Sheet onboarding") {
                store.send(.sheetOnboarding)
            }
            
            Button("Cover onboarding") {
                store.send(.coverOnboarding)
            }
            
            Button("Logout") {
                store.send(.logoutButtonTapped)
            }
            .foregroundStyle(.red)
        }
        .navigationTitle("Home View #\(store.state.screenNumber)")
    }
}
