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
    var viewModel = SetMaximumViewModel()
    
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
    
    private lazy var _checkBox: CheckBoxButton = {
        let button = CheckBoxButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(_checkBoxCliked), for: .touchUpInside)
        return button
    }()
    
    private lazy var _confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.268, green: 0.455, blue: 0.933, alpha: 0.2)
        button.setTitle("Confirm".localized, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.addTarget(self, action: #selector(_showAlert), for: .touchUpInside)
        return button
    }()
    
    private lazy var _cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.817, green: 0.333, blue: 0.333, alpha: 0.3)
        button.setTitle("Cancel".localized, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(_dismissView), for: .touchUpInside)
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
            make.centerY.equalTo(_timePickerView)
            make.height.equalTo(20)
        }
        
        _minutesLabel.snp.makeConstraints { make in
            make.right.equalTo(_timePickerView).inset(20)
            make.centerY.equalTo(_timePickerView)
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
    
    @objc private func _checkBoxCliked(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected == true ? (_confirmButton.isHidden = false) : (_confirmButton.isHidden = true)
    }
    
    @objc private func _showAlert() {
        let title = "⚠️ Check carefully".localized
        let message = "You can't change the maximum watch time in a single day".localized
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Wait".localized, style: .default)
        let okAction = UIAlertAction(title: "Confirm".localized, style: .destructive) { [weak self] _ in
            self?.viewModel.saveTime()
            self?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
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
            viewModel.selectedTime.hours = row
        case 1:
            viewModel.selectedTime.minutes = row
        default:
            break
        }
    }
}

// MARK: - Custom Button: CheckBox
fileprivate class CheckBoxButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "uncheck"), for: .normal)
        self.setImage(UIImage(named: "check"), for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
