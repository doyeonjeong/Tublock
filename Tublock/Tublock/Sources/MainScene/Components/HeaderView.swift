//
//  HeaderView.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/23.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapSettingsButton()
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    private lazy var _headerAppIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_text")
        return imageView
    }()
    
    private lazy var _settingIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    private func _setup() {
        addSubview(_headerAppIconImageView)
        addSubview(_settingIconButton)
        _setConstraints()
    }
    
    private func _setConstraints() {
        _headerAppIconImageView.snp.makeConstraints {
            $0.width.equalTo(102)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(30)
        }
        
        _settingIconButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-30)
        }
    }
    
    @objc private func didTapSettings() {
        delegate?.didTapSettingsButton()
    }
}
