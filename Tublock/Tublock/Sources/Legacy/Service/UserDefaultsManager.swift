//
//  UserDefaultsManager.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/18.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    private let ud = UserDefaults.standard
    var key: String
    var defaultValue: T
    var wrappedValue: T {
        get {
            return ud.value(forKey: key) as? T ?? defaultValue
        }
        set {
            ud.setValue(newValue, forKey: key)
            ud.synchronize()
        }
    }
}

struct UserDefaultsManager {
    static var time: BlockTime {
            get {
                let ud = UserDefaults.standard
                let baseKey = CommonType.MAXIMUM_TIME
                let hoursKey = baseKey + "_hours"
                let minuteKey = baseKey + "_minute"
                
                guard
                    let hours = ud.value(forKey: hoursKey) as? Int,
                    let minute = ud.value(forKey: minuteKey) as? Int
                else { return (0, 0)}
                
                return (hours, minute)
            }
            set {
                let ud = UserDefaults.standard
                let baseKey = CommonType.MAXIMUM_TIME
                let hoursKey = baseKey + "_hours"
                let minuteKey = baseKey + "_minute"
                
                ud.setValue(newValue.hours, forKey: hoursKey)
                ud.setValue(newValue.minutes, forKey: minuteKey)
            }
        }
    
    @UserDefaultsWrapper(key: CommonType.NOTIFICATION_CONTENTS, defaultValue: SetMessageView.placholderString)
    static var message: String
}
