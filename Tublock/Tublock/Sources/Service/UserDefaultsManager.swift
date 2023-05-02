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
    @UserDefaultsWrapper(key: CommonType.MAXIMUM_TIME, defaultValue: (0,0))
    static var time: BlockTime
    
    @UserDefaultsWrapper(key: CommonType.NOTIFICATION_CONTENTS, defaultValue: SetMessageView.placholderString)
    static var message: String
}
