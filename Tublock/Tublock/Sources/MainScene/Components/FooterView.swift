//
//  FooterView.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/23.
//

import UIKit
import SnapKit

class FooterView: UIView {
    
    private lazy var _blockingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("차단하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        return button
    }()
    
    var buttonStatus: ButtonStatus = .disabled {
        didSet {
            _blockingButton.setTitle(buttonStatus.rawValue, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    private func _setup() {
        addSubview(_blockingButton)
        _setConstraints()
    }
    
    private func _setConstraints() {
        _blockingButton.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func _changeStatus(_ status: ButtonStatus = .block) {
        buttonStatus = status
    }
}

enum ButtonStatus: String {
    case disabled = "차단불가"
    case block = "차단하기"
    case release = "차단됨"
}
