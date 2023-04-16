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
        
        func getAuthorizationStatus() -> (UNAuthorizationStatus) {
            center.getNotificationSettings { settings in
                self.authorizationStatus = settings.authorizationStatus
                guard settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional else { return }
    
            }
            
            return (self.authorizationStatus)
        }
        
        func addScehdule() {
            let content = UNMutableNotificationContent()
            content.title = "Weekly Staff Meeting"
            content.body = "Every Tuesday at 2pm"
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.weekday = 3  // Tuesday
            dateComponents.hour = 14    // 14:00 hours
               
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
            center.add(request)
        }
    
}
