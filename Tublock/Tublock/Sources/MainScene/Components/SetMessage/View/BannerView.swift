//
//  BannerView.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/11.
//

import UIKit
import SnapKit

final class BannerView: UIView {
    
    private let _messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 26
        view.backgroundColor = UIColor(displayP3Red: 185/255,
                                       green: 185/255,
                                       blue: 185/255,
                                       alpha: 0.4)
        return view
    }()
    
    private let _tublockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tublock"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    private let _tublockLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "logo_clean")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var _messagePreviewLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setLabel(message: String) {
        _messagePreviewLabel.text = message
    }
}

extension BannerView {
    
    private func _initLayout() {
        
        _addSubViews()
        _setConstraints()
    }
    
    private func _addSubViews() {
        
        self.addSubview(_messageView)
        _messageView.addSubview(_tublockLabel)
        _messageView.addSubview(_tublockLogoImageView)
        _messageView.addSubview(_messagePreviewLabel)
    }
    
    private func _setConstraints() {
        
        _messageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        _tublockLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalTo(_tublockLogoImageView.snp.right).inset(-8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(34)
        }
        
        _tublockLogoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        _messagePreviewLabel.snp.makeConstraints { make in
            make.top.equalTo(_tublockLabel.snp.bottom).inset(4)
            make.left.right.equalTo(_tublockLabel)
            make.bottom.greaterThanOrEqualToSuperview().inset(10)
        }
    }
}
