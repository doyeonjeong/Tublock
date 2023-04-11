//
//  SetMaximumView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/07.
//

import UIKit
import SnapKit

class SetMaximumView: UIView {
    
    var viewModel: SetMaximumViewModel = DefaultSetMaximumViewModel()
    
    var hours: Int = 0
    var minutes: Int = 0
    
    private let _contentsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let _titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Maximum"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    private let _descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "We recommend\nless than 3 hours."
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    private lazy var _timeSettingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 14
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(_showTimePickerModalView), for: .touchUpInside)
        return button
    }()
    
    private lazy var _timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setupView()
    }
    
    private func _setupView() {
        addSubview(_contentsView)
        
        _contentsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(42)
            make.left.right.equalToSuperview().inset(25)
        }
        
        let verticalStackView = UIStackView(arrangedSubviews: [_titleLabel, _descriptionLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        /// top.left.equalToSuperview()를 해보았지만 height가 계속 ambiguous하다는 오류 메세지로 인한 설정
        _titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        /// bottom.left.equalToSuperview()를 해보았지만 height가 계속 ambiguous하다는 오류 메세지로 인한 설정
        _descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(34)
        }
        
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView, _timeSettingButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        
        _contentsView.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        /// 하드코딩한 것 같아서 썩 마음에 들지 않지만 현재로서는 마땅한 대안이 떠오르지 않음
        _timeSettingButton.snp.makeConstraints { make in
            make.width.equalTo(168)
            make.height.equalTo(67.4)
        }
        
        _timeSettingButton.addSubview(_timeLabel)
        _timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        _configureTimeLabel()
    }
    
    private func _configureTimeLabel() {
        _updateAttributedText()
    }
    
    private func _updateAttributedText() {
        let hoursText = NSAttributedString(string: "\(hours)",
                                           attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
        let minutesText = NSAttributedString(string: "\(minutes)",
                                             attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
        let hoursLabel = NSAttributedString(string: " hours ",
                                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        let minutesLabel = NSAttributedString(string: " min",
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(hoursText)
        attributedText.append(hoursLabel)
        attributedText.append(minutesText)
        attributedText.append(minutesLabel)
        
        _timeLabel.attributedText = attributedText
    }
    
    func update(selectedTime: BlockTime) {
        hours = selectedTime.hours
        minutes = selectedTime.minutes
        _updateAttributedText()
    }

}

extension SetMaximumView: TimePickerModalViewDelegate {
    
    func timePickerModalView(_ view: TimePickerModalView, didPickTime time: (hours: Int, minutes: Int)) {
        update(selectedTime: time)
    }
    
    @objc
    private func _showTimePickerModalView() {
        let timePicker = TimePickerModalView()
        timePicker.modalPresentationStyle = .overCurrentContext
        timePicker.delegate = self
        
        viewModel.update(selectedTime: (hours: hours, minutes: minutes))
        
        guard let viewController = _findViewController() else { return }
        viewController.present(timePicker, animated: true, completion: nil)
    }
    
    private func _findViewController() -> UIViewController? {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let rootViewController = keyWindow.rootViewController else { return nil }
        
        var viewController: UIViewController? = nil
        
        if rootViewController is UINavigationController {
            viewController = (rootViewController as? UINavigationController)?.visibleViewController
        } else if rootViewController is UITabBarController {
            let selectedTabViewController = (rootViewController as? UITabBarController)?.selectedViewController
            if selectedTabViewController != nil {
                viewController = selectedTabViewController
            } else {
                viewController = rootViewController
            }
        } else {
            viewController = rootViewController
        }
        
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        
        return viewController
    }
}
