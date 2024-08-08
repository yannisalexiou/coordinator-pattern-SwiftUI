//
//  OnboardingViewAction.swift
//  MasterCoordinator
//
//  Created by Tomáš Duchoslav on 22.07.2024.
//

import SwiftUI

enum OnboardingViewAction {
    case nextButtonTapped
    case dismissButtonTapped
    case popToRootButtonTapped
    case dismissSheet(DismissAction)
}
