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
        horizontalStackView.distribution = .fillEqually
        
        _contentsView.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

extension SetMaximumView {
    
    /// TimePickerModalView를 Present
    @objc private func _showTimePickerModalView() {
        let timePicker = TimePickerModalViewController()
        timePicker.modalPresentationStyle = .overCurrentContext
        
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
