//
//  SetMaximumViewModel.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit

typealias BlockTime = (hours: Int, minutes: Int)

protocol SetMaximumViewModel {
    /// 선택된 시간
    var selectedTime: BlockTime { get set }
    
    /// 시간이 변경될 때 호출되는 클로저
    var onTimeChanged: (() -> Void)? { get set }
    
    /// `time` 속성을 지정된 값으로 업데이트
    func update(selectedTime: BlockTime)

    /// 지정된 시간만큼 시간을 줄입니다.
    func decreaseTime(by seconds: Int)
    
    /// 포맷된 시간을 나타내는 `NSAttributedString`을 반환합니다.
    func getFormattedTime() -> NSAttributedString
    
    /// 타이머 시작
    func startTimer()
    
    /// 타이머 중지
    func stopTimer()
}


class DefaultSetMaximumViewModel: SetMaximumViewModel {
    
    // MARK: - Properties
    var selectedTime: BlockTime {
        didSet {
            onTimeChanged?()
        }
    }
    
    var onTimeChanged: (() -> Void)?
    
    private var _timer: Timer?
    
    init(selectedTime: BlockTime = (0, 0)) {
        self.selectedTime = selectedTime
    }
    
    // MARK: - Methods
    func update(selectedTime: BlockTime) {
    }
    
    func decreaseTime(by seconds: Int) {
    }
    
    func getFormattedTime() -> NSAttributedString {
        
        let hoursText = NSAttributedString(
            string: "\(selectedTime.hours)",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23)]
        )
        
        let minutesText = NSAttributedString(
            string: "\(selectedTime.minutes)",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23)]
        )
        
        let hoursLabel = NSAttributedString(
            string: " hours ",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        )
        
        let minLabel = NSAttributedString(
            string: " min",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        )
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(hoursText)
        attributedText.append(hoursLabel)
        attributedText.append(minutesText)
        attributedText.append(minLabel)
        
        return attributedText
    }
    
    func startTimer() {
    }
    
    func stopTimer() {
    }

}
