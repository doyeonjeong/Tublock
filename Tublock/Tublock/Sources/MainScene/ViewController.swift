//
//  ViewController.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import SnapKit
import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    private let _settingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Setting_icon")
        return imageView
    }()
    
    private let _headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let _setMaximumView: SetMaximumView = {
        let view = SetMaximumView()
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
    
    private let _blockingManager = BlockingManager()
    
    // MARK: - for Blocking Properties
    var hostingController: UIHostingController<BlockingSwiftUIView>?
    
    private lazy var _blockingView: UIHostingController<some View> = {
        let model = BlockingApplicationModel.shared
        let hostingController = UIHostingController(
            rootView: BlockingSwiftUIView()
                .environmentObject(model)
        )
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    private let _blockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("차단하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let _releaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("해제하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let _buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _setup()
        _blockingManager.requestAuthorization()
    }
}

extension ViewController {
    private func _setup() {
        _setDelegates()
        _addSubviews()
        _setConstraints()
        _addTargets()
    }
    
    private func _setDelegates() {
        
    }
    
    private func _addSubviews() {
        view.addSubview(_headerView)
        _headerView.addSubview(_settingIconImageView)
        view.addSubview(_setMaximumView)
        view.addSubview(_setMessageView)
        
        // MARK: - for Blocking Subviews
        _buttonStackView.addArrangedSubview(_blockButton)
        _buttonStackView.addArrangedSubview(_releaseButton)
        view.addSubview(_buttonStackView)
        addChild(_blockingView)
        view.addSubview(_blockingView.view)
    }
    
    private func _setConstraints() {
        
        _headerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(64)
        }
        
        _settingIconImageView.snp.makeConstraints { make in
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
        
        // MARK: - for Blocking Constraints
        _blockingView.view.snp.makeConstraints { make in
            make.top.equalTo(_setMessageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(32)
        }
        
        _buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(_blockingView.view.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
    }
    
    // MARK: - for Blocking Targets
    private func _addTargets() {
        _blockButton.addTarget(self, action: #selector(_tappedBlockButton), for: .touchUpInside)
        _releaseButton.addTarget(self, action: #selector(_tappedReleaseButton), for: .touchUpInside)
    }
}

// MARK: SetMessageView Metod
extension ViewController {
    private func _setUp(preview: BannerView) {
        
        preview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preview)
        
        topConstraint = preview.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: -(preview.frame.height + preview.frame.origin.y + 100)
        )

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
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self._endAnimation(preview)
            })
        }
    }
    
    private func _endAnimation(_ preview: BannerView) {
        
        topConstraint.constant = -(preview.frame.height + preview.frame.origin.y + 100)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            preview.removeFromSuperview()
            self.isPreviewing = false
        }
    }
    
    // MARK: - for Blocking Actions
    @objc private func _tappedBlockButton() {
        _blockingManager.block { result in
            switch result {
            case .success():
                print("차단 성공")
                self._showAlert(with: "차단 성공", message: "선택된 앱을 제한했습니다.")
            case .failure(let error):
                print("차단 실패: \(error.localizedDescription)")
                self._showAlert(with: "차단 실패", message: "선택된 앱을 제한하는데에 실패했습니다.")
            }
        }
    }
    
    @objc private func _tappedReleaseButton() {
        print("차단 해제")
        _blockingManager.unblockAllApps()
        self._showAlert(with: "차단 해제", message: "차단을 해제했습니다.")
    }
    
    private func _showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}
