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
        label.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private let _alarmPermissionButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("alarm setting".localized, for: .normal)
        button.setImage(.init(systemName: "chevron.right"), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let _screentimePermissionButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("screenAPI setting".localized, for: .normal)
        button.setImage(.init(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            make.left.centerY.equalTo(_appVersionView)
        }
        
        _appVersionValue.snp.makeConstraints { make in
            make.right.centerY.equalTo(_appVersionView)
        }
    }
}
