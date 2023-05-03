//
//  BlockingManager.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/10.
//

import FamilyControls
import DeviceActivity
import ManagedSettings

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
