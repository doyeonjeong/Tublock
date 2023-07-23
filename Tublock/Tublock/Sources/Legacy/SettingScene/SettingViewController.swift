//
//  SettingViewController.swift
//  Tublock
//
//  Created by 강동영 on 2023/05/10.
//

import UIKit

final class SettingViewController: UIViewController {

    private let _verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var _appVersionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        view.addSubview(self._appVersionLabel)
        view.addSubview(self._appVersionValue)
        return view
    }()
    
    private let _appVersionLabel: UILabel = {
        let label = UILabel()
        label.text = "App Version"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private let _appVersionValue: UILabel = {
        let label = UILabel()
        label.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var _alarmPermissionButton: UIButton = {
        let button = UIButton(type: .custom)
        
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.setTitle("alarm setting".localized, for: .normal)
        button.setImage(.init(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .fill
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(_moveAlertSetting), for: .touchUpInside)
        
        return button
    }()
    
    private let _screentimePermissionButton: UIButton = {
        let button = UIButton(type: .custom)
        
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.setTitle("screenAPI setting".localized, for: .normal)
        button.setImage(.init(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .fill
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .clear
        // TODO: ScreenTime api 권한 붙은 후에 추후 작업 예정
        return button
    }()
    
    private var isAlertAuthorization: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _getAlertAuthorization()
        _setup()
    }
}

extension SettingViewController {
    
    private func _setup() {
        
        _setViewProperty()
        _addSubViews()
        _setConstraints()
    }
    
    private func _setViewProperty() {
        
        view.backgroundColor = UIColor(red: 0.13,
                                       green: 0.13,
                                       blue: 0.13,
                                       alpha: 1.00)
    }
    
    private func _addSubViews() {
        
        view.addSubview(_verticalStackView)
        _verticalStackView.addArrangedSubview(_appVersionView)
        _verticalStackView.addArrangedSubview(_alarmPermissionButton)
        _verticalStackView.addArrangedSubview(_screentimePermissionButton)
    }
    
    private func _setConstraints() {
        _verticalStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view).inset(16)
        }
        
        _appVersionView.snp.makeConstraints { make in
            make.height.equalTo(47)
        }
        _appVersionLabel.snp.makeConstraints { make in
            make.left.equalTo(_appVersionView).inset(12)
            make.centerY.equalTo(_appVersionView)
        }
        
        _appVersionValue.snp.makeConstraints { make in
            make.right.equalTo(_appVersionView).inset(12)
            make.centerY.equalTo(_appVersionView)
        }
    }
    
    private func _getAlertAuthorization() {
        Task {
            isAlertAuthorization = await NotificationManager.shared.isAuthorization()
        }
    }
    
    @objc
    private func _moveAlertSetting() {
        Task {
            await _openSystemSetting()
        }
    }
    
    private func _openSystemSetting() async {
        guard
            isAlertAuthorization == true,
              let nsUrl = UIApplication.openNotificationSettingsURLString.toURL()
        else { return }
        let url = nsUrl as URL
        if UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        }
    }
}
