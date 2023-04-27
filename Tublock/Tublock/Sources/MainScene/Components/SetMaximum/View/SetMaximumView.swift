//
//  SetMaximumView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/07.
//

import UIKit
import SnapKit

class SetMaximumView: UIView {
    
    var viewModel = SetMaximumViewModel()
    
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
        button.setAttributedTitle(viewModel.getFormattedTime(), for: .normal)
        button.addTarget(self, action: #selector(_showTimePickerModalView), for: .touchUpInside)
        return button
    }()
    
    private let _verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let _horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setupView()
    }
}

// MARK: - Setup
extension SetMaximumView {
    private func _setupView() {
        _addSubviews()
        _setConstraints()
    }
    
    private func _addSubviews() {
        addSubview(_contentsView)
        _verticalStackView.addArrangedSubview(_titleLabel)
        _verticalStackView.addArrangedSubview(_descriptionLabel)
        _horizontalStackView.addArrangedSubview(_verticalStackView)
        _horizontalStackView.addArrangedSubview(_timeSettingButton)
        _contentsView.addSubview(_horizontalStackView)
    }
    
    private func _setConstraints() {
        _contentsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(42)
            make.left.right.equalToSuperview().inset(25)
        }
        
        _titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        
        _horizontalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - TimePickerView
extension SetMaximumView {
    
    /// TimePickerModalView를 Present
    @objc private func _showTimePickerModalView() {
        let timePicker = TimePickerModalViewController()
        timePicker.modalPresentationStyle = .automatic
        
        /// TimePicker를 표시할 뷰 컨트롤러 찾기
        guard let viewController = _findViewController() else { return }
        viewController.present(timePicker, animated: true, completion: nil)
    }
    
    private func _findViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        guard let rootViewController = delegate.window?.rootViewController else { return nil }
        
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
