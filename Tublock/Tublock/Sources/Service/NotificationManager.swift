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
    
    // 스케줄링에 대한 로직인 스크린 API가 개발이 된 이후에 리팩토링 해야해요
    func addScehdule(identifier: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = "Tublock"
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request)
    }
    
    func getPendingSchedule() async -> [UNNotificationRequest] {
        let requests = await center.pendingNotificationRequests()
        
        return requests
    }
    
    func removePendingSchedule() {
        center.removeAllPendingNotificationRequests()
    }
}
