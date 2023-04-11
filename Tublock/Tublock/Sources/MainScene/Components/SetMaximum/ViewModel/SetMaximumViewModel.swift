//
//  SetMaximumViewModel.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit

protocol SetMaximumViewModelProtocol {
    var hours: Int { get set }
    var minutes: Int { get set }
    
    /// 시간이 변경될 때 호출되는 클로저
    var onTimeChanged: (() -> Void)? { get set }
    
    /// `hours` 속성을 지정된 값으로 업데이트
    func updateHours(newHours: Int)
    
    /// `minutes`속성을 지정된 값으로 업데이트
    func updateMinutes(newMinutes: Int)
    
    /// 지정된 시간만큼 시간을 줄입니다.
    func decreaseTime(by seconds: Int)
    
    /// 포맷된 시간을 나타내는 `NSAttributedString`을 반환합니다.
    func getFormattedTime() -> NSAttributedString
}


class SetMaximumViewModel: SetMaximumViewModelProtocol {
    
    // MARK: - Properties
    var hours: Int
    var minutes: Int
    var onTimeChanged: (() -> Void)?
    
    init(hours: Int = 0, minutes: Int = 0) {
        self.hours = hours
        self.minutes = minutes
    }
    
    // MARK: - Methods
    func updateHours(newHours: Int) {
        <#code#>
    }
    
    func updateMinutes(newMinutes: Int) {
        <#code#>
    }
    
    func decreaseTime(by seconds: Int) {
        <#code#>
    }
    
    func getFormattedTime() -> NSAttributedString {
        <#code#>
    }
    
}
