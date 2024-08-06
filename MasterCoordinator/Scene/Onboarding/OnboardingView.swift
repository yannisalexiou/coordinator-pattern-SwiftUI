//
//  FirstView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    var store: OnboardingViewStore
    
    init(store: OnboardingViewStore) {
        self.store = store
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Button("Next") {
                store.send(.nextButtonTapped)
            }
            
            Button("Dismiss") {
                store.send(.dismissButtonTapped)
            }
            
            Button("PopToRoot") {
                store.send(.popToRootButtonTapped)
            }
        }
        .navigationTitle("Onboarding View #\(store.state.screenNumber)")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.send(.dismissSheet)
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }

            }
        }
    }
}

