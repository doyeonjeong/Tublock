//
//  SetMessageView.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/07.
//

import UIKit
import SnapKit

class SetMessageView: UIView {

    private let _contentsView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(displayP3Red: 30/255,
                                       green: 30/255,
                                       blue: 30/255,
                                       alpha: 1.0)
        return view
    }()
    
    private let _setMesaageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Set Message"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(displayP3Red: 217/255,
                                  green: 217/255,
                                  blue: 217/255,
                                  alpha: 1.0)
        return label
    }()
    
    private let _messageView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 26
        view.backgroundColor = UIColor(displayP3Red: 185/255,
                                       green: 185/255,
                                       blue: 185/255,
                                       alpha: 0.4)
        return view
    }()
    
    private let _tublockLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Tublock"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    private let _tublockLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "logo_clean")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let _messageTextfield: UILabel = {
        let label = UILabel()
        
        label.text = "Set Message"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(displayP3Red: 217/255,
                                  green: 217/255,
                                  blue: 217/255,
                                  alpha: 1.0)
        return label
    }()
    
    private let _previewButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 8
        button.setTitle("Preview", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 104/255,
                                         green: 104/255,
                                         blue: 104/255,
                                         alpha: 0.2)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SetMessageView {
    private func _initLayout() {
        _addSubViews()
        _setConstraints()
    }
    
    private func _addSubViews() {
        self.addSubview(_contentsView)
        _contentsView.addSubview(_setMesaageLabel)
        _contentsView.addSubview(_messageView)
        _messageView.addSubview(_tublockLabel)
        _messageView.addSubview(_tublockLogoImageView)
        _messageView.addSubview(_messageTextfield)
        _contentsView.addSubview(_previewButton)
    }
    
    private func _setConstraints() {
        
        _contentsView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(42)
            make.left.right.equalTo(self).inset(26)
        }

        _setMesaageLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        _messageView.snp.makeConstraints { make in
            make.top.equalTo(_setMesaageLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
        }
        
        _tublockLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalTo(_tublockLogoImageView.snp.right).inset(-8)
            make.right.equalToSuperview().inset(8)
        }
        
        _tublockLogoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        _messageTextfield.snp.makeConstraints { make in
            make.top.equalTo(_tublockLabel.snp.bottom).inset(4)
            make.left.right.equalTo(_tublockLabel)
            make.bottom.equalToSuperview().inset(10)
        }

        _previewButton.snp.makeConstraints { make in
            make.top.equalTo(_messageView.snp.bottom).inset(-21)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
    }
}
