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
    
    private let setMessageView: UIView = {
        let view = UIView()
        //        view.backgroundColor = .blue // 범위 확인용
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
        view.addSubview(headerView)
        headerView.addSubview(settingIcon)
        view.addSubview(setMaximumView)
        view.addSubview(setMessageView)
    }
    
    private func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalToSuperview()
            make.height.equalTo(64)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(headerView.snp.top).offset(20)
            make.bottom.equalTo(headerView.snp.bottom).offset(-20)
            make.trailing.equalTo(headerView.snp.trailing).offset(-26)
        }
        
        setMaximumView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalToSuperview()
            make.height.equalTo(170)
        }
        
        setMessageView.snp.makeConstraints { make in
            make.top.equalTo(setMaximumView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
    }
}
