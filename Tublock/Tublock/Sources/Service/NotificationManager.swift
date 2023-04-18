//
//  NotificationManager.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/16.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared: NotificationManager = NotificationManager()
    
    private init() {}
    
    private let center = UNUserNotificationCenter.current()
    private var authorizationStatus: UNAuthorizationStatus = .authorized
        
        
    func requestAuthorization() async throws -> Bool {
        let granted = try await center.requestAuthorization(options: [.alert, .badge, .sound, .provisional])
        
        return granted
    }
    
    func isAuthorization() async -> Bool {
        let setting = await center.notificationSettings()
        
        switch setting.authorizationStatus {
            
        case .notDetermined, .denied: return false
        case .authorized, .provisional: return true
        case .ephemeral: return true
        @unknown default: return false
        }
    }
}
