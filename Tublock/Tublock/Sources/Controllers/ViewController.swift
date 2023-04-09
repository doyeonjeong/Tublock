//
//  ViewController.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {
    
    private let settingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting_icon")
        return imageView
    }()
    
    private let headerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .yellow // 범위 확인용
        return view
    }()
    
    private let setMaximumView: UIView = {
        let view = UIView()
//        view.backgroundColor = .cyan // 범위 확인용
        return view
    }()
    
    private let setMessageView: SetMessageView = {
        let view = SetMessageView()
        view.backgroundColor = .blue // 범위 확인용
        view.backgroundColor = UIColor(displayP3Red: 30/255,
                                       green: 30/255,
                                       blue: 30/255,
                                       alpha: 1.0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ViewController {
    private func setup() {
        setDelegates()
        addSubviews()
        setConstraints()
    }
    
    private func setDelegates() {
        
    }
    
    private func addSubviews() {
        headerView.addSubview(settingIcon)
        view.addSubview(headerView)
        view.addSubview(setMaximumView)
        view.addSubview(setMessageView)
    }
    
    private func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).offset(24)
            make.trailing.equalTo(headerView.snp.trailing).offset(-24)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        setMaximumView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(180)
        }
        
        setMessageView.snp.makeConstraints { make in
            make.top.equalTo(setMaximumView.snp.bottom)
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
    }
}
