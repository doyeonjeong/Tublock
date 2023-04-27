//
//  TimePickerModalView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit
import SnapKit

final class TimePickerModalViewController: UIViewController {
    
    // MARK: - Properties
    private let _timePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let _hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "hours"
        label.textColor = .white
        return label
    }()
    
    private let _minutesLabel: UILabel = {
        let label = UILabel()
        label.text = "min"
        label.textColor = .white
        return label
    }()
    
    var selectedTime: BlockTime = (0, 0)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
}

// MARK: - Setup
extension TimePickerModalViewController {
    
    private func _setupView() {
        
        _setBackground()
        _setDelegates()
        _addSubviews()
        _setConstraints()
        _addSwipeDownGesture()
    }
    
    private func _setDelegates() {
        
        _timePickerView.delegate = self
        _timePickerView.dataSource = self
    }
    
    private func _addSubviews() {
        
        view.addSubview(_timePickerView)
        view.addSubview(_hoursLabel)
        view.addSubview(_minutesLabel)
    }
    
    private func _setConstraints() {
        
        _timePickerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(140)
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(70)
            make.height.equalTo(200)
        }
        
        _hoursLabel.snp.makeConstraints { make in
            make.left.equalTo(_timePickerView).inset(100)
            make.centerY.centerY.equalTo(_timePickerView)
            make.height.equalTo(20)
        }
        
        _minutesLabel.snp.makeConstraints { make in
            make.right.equalTo(_timePickerView).inset(20)
            make.centerY.centerY.equalTo(_timePickerView)
            make.height.equalTo(20)
        }
    }
    
    private func _addSwipeDownGesture() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(_dismissView))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    private func _setBackground() {
        view.backgroundColor = .black
    }

}

// MARK: - Action
extension TimePickerModalViewController {
    
    @objc private func _dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension TimePickerModalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        return NSAttributedString(string: String(row), attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedTime.hours = row
        case 1:
            selectedTime.minutes = row
        default:
            break
        }
    }
}
