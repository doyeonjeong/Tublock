//
//  SetMaximumViewModel.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit

typealias BlockTime = (hours: Int, minutes: Int)

final class SetMaximumViewModel {
    
    // MARK: - Properties
    var selectedTime: BlockTime {
        didSet {
            onTimeChanged?()
        }
    }
    
    /// 시간이 변경될 때 호출되는 클로저
    var onTimeChanged: (() -> Void)?

    init(selectedTime: BlockTime = (0, 0)) {
        self.selectedTime = selectedTime
    }
}

// MARK: - Time Formatting
extension SetMaximumViewModel {
    
    /// 포맷된 시간을 나타내는 `NSAttributedString` 반환
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
            string: " hours ".localized,
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        )
        
        let minLabel = NSAttributedString(
            string: " min".localized,
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        )
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(hoursText)
        attributedText.append(hoursLabel)
        attributedText.append(minutesText)
        attributedText.append(minLabel)
        
        return attributedText
    }
}
