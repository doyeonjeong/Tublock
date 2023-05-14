//
//  BlockingManager.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/10.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

// MARK: - Extension
extension DeviceActivityName {
    static let daily = Self("daily")
}

// MARK: - Model
final class BlockingApplicationModel: ObservableObject {
    static let shared = BlockingApplicationModel()
    
    @Published var newSelection: FamilyActivitySelection = .init()
    
    var selectedAppsTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
}

// MARK: - Manager
final class BlockingManager {
    
    private let _center = AuthorizationCenter.shared
    
    func requestAuthorization() {
        Task {
            do {
                try await _center.requestAuthorization(for: .individual)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
