//
//  TabBarView.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject
    private var coordinator: TabBarCoordinator
    
    public init(
        coordinator: TabBarCoordinator
    ) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(self.coordinator.tabs, id: \.self) { tab in
                switch tab {
                case .home:
                    firstTabView(tab)
                case .profile:
                    secondTabView(tab)
                }
            }
        }
    }
}

extension TabBarView {
    @ViewBuilder func firstTabView(_ tabItem: TabBarItem) -> some View {
        CoordinatedView(coordinator.homeCoordinator)
            .tabItem {
                VStack {
                    Image(systemName: tabItem.image)
                    Text(tabItem.title)
                }
            }
            .tag(tabItem)
    }
    
    @ViewBuilder func secondTabView(_ tabItem: TabBarItem) -> some View {
        CoordinatedView(coordinator.profileCoordinator)
            .tabItem {
                VStack {
                    Image(systemName: tabItem.image)
                    Text(tabItem.title)
                }
            }
            .tag(tabItem)
    }
}
