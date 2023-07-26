//
//  BlockingManager.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/25.
//

import Foundation
import FamilyControls
import ManagedSettings

final class BlockingManager: ObservableObject {
    
    @Published var newSelection: FamilyActivitySelection = .init()
    
    var selectedAppTokens: Set<ApplicationToken> {
        return newSelection.applicationTokens
    }
    
    var selectedApps: Set<Application> {
        return newSelection.applications
    }
    
}
