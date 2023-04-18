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
    
    private var topConstraint: NSLayoutConstraint!
    private var isPreviewing: Bool = false
    private lazy var _setMessageView: SetMessageViewAvailable = {
        let messageView: SetMessageViewAvailable = SetMessageView()
        messageView.previewAction = { [weak self] preview in
            guard let self = self,
                  self.isPreviewing == false
            else { return }
            self.isPreviewing = true
            self._setUp(preview: preview)
            self._startAnimation(preview)
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

// MARK: SetMessageView Metod
extension ViewController {
    
    
    private func _setUp(preview: BannerView) {
        preview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preview)
        
        topConstraint = preview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(preview.frame.height + preview.frame.origin.y + 100))

        NSLayoutConstraint.activate([
            topConstraint,
            preview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            preview.widthAnchor.constraint(equalToConstant: preview.bounds.width),
            preview.heightAnchor.constraint(equalToConstant: preview.bounds.height),
        ])
        view.layoutIfNeeded()
    }
    
    private func _startAnimation(_ preview: BannerView) {
        
        self.topConstraint.constant = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self._endAnimation(preview)
            })
        }
    }
    
    private func _endAnimation(_ preview: BannerView) {
        
        topConstraint.constant = -(preview.frame.height + preview.frame.origin.y + 100)
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            preview.removeFromSuperview()
            self.isPreviewing = false
        }
    }
}
