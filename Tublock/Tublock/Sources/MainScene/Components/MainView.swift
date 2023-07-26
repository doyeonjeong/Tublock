//
//  MainView.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/23.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func didSelectAddButton()
}

class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
    private lazy var _contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var _emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 앱을 선택하지 않았습니다.\n앱을 선택하고 차단해보세요."
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 5
        return label
    }()
    
    var isEmpty: Bool = true
    
    private lazy var _addButton: UIButton = {
        let button = UIButton()
        button.setTitle("앱 선택하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(red: 0.33, green: 0.13, blue: 0.04, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(_didTapAddButton), for: .touchUpInside)
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
    
}

extension MainView {
    
    private func _setup() {
        addSubview(_contentView)
        addSubview(_emptyLabel)
        addSubview(_addButton)
        _setConstraints()
    }
    
    private func _setConstraints() {
        _contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(8)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }

        _emptyLabel.snp.makeConstraints {
            $0.top.left.right.equalTo(_contentView).inset(30)
            $0.bottom.equalTo(_addButton.snp.top)
        }
        
        _addButton.snp.makeConstraints {
            $0.left.right.equalTo(_contentView).inset(20)
            $0.bottom.equalTo(_contentView).inset(20)
        }
    }
}

extension MainView {
    
    @objc
    func _didTapAddButton() {
        delegate?.didSelectAddButton()
    }
}
