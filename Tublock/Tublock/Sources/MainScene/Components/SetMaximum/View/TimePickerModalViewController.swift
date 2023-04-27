//
//  TimePickerModalView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit
import SnapKit

class CheckBox: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "uncheck"), for: .normal)
        self.setImage(UIImage(named: "check"), for: .selected)
        self.addTarget(self, action: #selector(buttonCliked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonCliked(_ sender: UIButton) {
        self.isSelected.toggle()
    }
}

final class TimePickerModalViewController: UIViewController {
    
    // MARK: - Properties
    var selectedTime: BlockTime = (0, 0)
    
    private let _timePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let _hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "hours".localized
        label.textColor = .white
        return label
    }()
    
    private let _minutesLabel: UILabel = {
        let label = UILabel()
        label.text = "min".localized
        label.textColor = .white
        return label
    }()
    
    private let _cautionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let _discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Set a maximum daily watch time for YouTube".localized
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let _cautionLabel: UILabel = {
        let label = UILabel()
        label.text = "If you confirm, you won't be able to change it until the next day\nCheck if you agree".localized
        label.textColor = .red
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let _checkBox: CheckBox = {
        let button = CheckBox()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let _confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.268, green: 0.455, blue: 0.933, alpha: 0.2)
        button.setTitle("Confirm".localized, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let _cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.817, green: 0.333, blue: 0.333, alpha: 0.3)
        button.setTitle("Cancel".localized, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
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
        view.addSubview(_cautionsView)
        _cautionsView.addSubview(_discriptionLabel)
        _cautionsView.addSubview(_cautionLabel)
        _cautionsView.addSubview(_checkBox)
        view.addSubview(_confirmButton)
        view.addSubview(_cancelButton)
    }
    
    private func _setConstraints() {
        
        _timePickerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
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
        
        _cautionsView.snp.makeConstraints { make in
            make.top.equalTo(_timePickerView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        _discriptionLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        _checkBox.snp.makeConstraints { make in
            make.top.equalTo(_discriptionLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(28)
        }
        
        _cautionLabel.snp.makeConstraints { make in
            make.top.equalTo(_discriptionLabel.snp.bottom).offset(20)
            make.left.equalTo(_checkBox.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        _cancelButton.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview().inset(32)
            make.height.equalTo(36)
        }
        
        _confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(_cancelButton.snp.top).offset(-20)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(36)
        }
        
    }
    
    private func _addSwipeDownGesture() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(_dismissView))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    private func _setBackground() {
        view.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
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
