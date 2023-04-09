//
//  ViewController.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {
    
    private let _settingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting_icon")
        return imageView
    }()
    
    private let _headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let _setMaximumView: SetMaximumView = {
        let view = SetMaximumView()
        //view.backgroundColor = .cyan // 범위 확인용
        return view
    }()
    
    private lazy var _setMessageView: SetMessageViewAvailable = {
        let messageView: SetMessageViewAvailable = SetMessageView()
        messageView.previewAction = { [weak self] preview in
            self?.view.addSubview(preview)
        }
        
        return messageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setup()
    }
}

extension ViewController {
    private func _setup() {
        _setDelegates()
        _addSubviews()
        _setConstraints()
    }
    
    private func _setDelegates() {
        
    }
    
    private func _addSubviews() {
        view.addSubview(_headerView)
        _headerView.addSubview(_settingIcon)
        view.addSubview(_setMaximumView)
        view.addSubview(_setMessageView)
    }
    
    private func _setConstraints() {
        _headerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(64)
        }
        
        _settingIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(_headerView).offset(-26)
        }
        
        _setMaximumView.snp.makeConstraints { make in
            make.top.equalTo(_headerView.snp.bottom)
            make.left.right.equalTo(_headerView)
            make.width.equalToSuperview()
            make.height.equalTo(171.4)
        }
        
        _setMessageView.snp.makeConstraints { make in
            make.top.equalTo(_setMaximumView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(271)
            make.width.equalToSuperview()
        }
    }
}
