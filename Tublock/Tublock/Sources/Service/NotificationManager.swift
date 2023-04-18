//
//  NotificationManager.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/16.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared: NotificationManager = NotificationManager()
    
    private init() {}
    
    private let center = UNUserNotificationCenter.current()
    private var authorizationStatus: UNAuthorizationStatus = .authorized
        
        
    func requestAuthorization() async throws -> Bool {
        let granted = try await center.requestAuthorization(options: [.alert, .badge, .sound, .provisional])
        
        return granted
    }
}
