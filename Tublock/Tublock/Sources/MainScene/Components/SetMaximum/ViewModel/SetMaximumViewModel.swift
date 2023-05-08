//
//  SetMaximumViewModel.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

typealias BlockTime = (hours: Int, minutes: Int)

final class SetMaximumViewModel {
    
    // MARK: - Properties
    var selectedTime: BlockTime

    init(selectedTime: BlockTime = (0, 0)) {
        self.selectedTime = selectedTime
    }
    
    func loadTime() {
        selectedTime = UserDefaultsManager.time
    }
    
    func saveTime() {
        UserDefaultsManager.time = selectedTime
    }
}
