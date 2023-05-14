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
    
    private let _store = ManagedSettingsStore()
    private let _model = BlockingApplicationModel.shared
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
    
    func block(completion: @escaping (Result<Void, Error>) -> Void) {
        // 선택한 앱 토큰 가져오기
        let selectedAppTokens = _model.selectedAppsTokens
        
        // DeviceActivityCenter를 사용하여 모든 선택한 앱 토큰에 대한 액티비티 차단
        let deviceActivityCenter = DeviceActivityCenter()
        
        // 모니터 DeviceActivitySchedule 설정
        let blockSchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        _store.shield.applications = selectedAppTokens
        do {
            try deviceActivityCenter.startMonitoring(DeviceActivityName.daily, during: blockSchedule)
        } catch {
            completion(.failure(error))
            return
        }
        completion(.success(()))
    }
    
    func unblockAllApps() {
        _store.shield.applications = []
    }
}
