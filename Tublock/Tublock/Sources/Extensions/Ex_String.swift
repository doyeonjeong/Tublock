//
//  Ex_String.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/07.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func toURL() -> NSURL? {
        return NSURL(string: self)
    }
}
