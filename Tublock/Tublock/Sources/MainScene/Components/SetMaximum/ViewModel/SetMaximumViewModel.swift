//
//  SetMaximumViewModel.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

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
