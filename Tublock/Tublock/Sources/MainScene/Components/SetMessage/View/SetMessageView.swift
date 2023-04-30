//
//  SetMessageView.swift
//  Tublock
//
//  Created by 강동영 on 2023/04/07.
//

import UIKit
import SnapKit

protocol MessageTextViewAction: AnyObject {
    func didEndEditing(text: String)
    func limitCount()
}

protocol SetMessageViewAvailable: UIView {
    var previewAction: ((BannerView)->())? { get set }
    var delegate: MessageTextViewAction? { get set }
}

final class SetMessageView: UIView, SetMessageViewAvailable {

    static let placholderString: String = "Leave a message for your self here ...".localized
    
    private let _contentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    public var previewAction: ((BannerView)->())?
    public weak var delegate: MessageTextViewAction?
    
    private let _setMesaageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Set Message".localized
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
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "logo_clean")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var _messageTextView: UITextView = {
        let textView = UITextView()
        
        textView.delegate = self
        textView.text = UserDefaultsManager.message
        textView.font = UIFont.systemFont(ofSize: 14)
        let textColor: UIColor = textView.text == SetMessageView.placholderString ? .gray : .white
        textView.textColor = textColor
        textView.backgroundColor = .clear
        
        return textView
    }()
    
    private lazy var _previewButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 8
        button.setTitle("Preview".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 104/255,
                                         green: 104/255,
                                         blue: 104/255,
                                         alpha: 0.2)
        button.addTarget(self, action: #selector(previewBanner), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func previewBanner() {
        
        let preview: BannerView = BannerView(frame: _messageView.frame)
        preview.setLabel(message: _messageTextView.text)
        previewAction?(preview)
    }
}

extension SetMessageView {
    private func _initLayout() {
        _addSubViews()
        _setConstraints()
        _addToolBarWith(textView: _messageTextView)
    }
    
    private func _addSubViews() {
        self.addSubview(_contentsView)
        _contentsView.addSubview(_setMesaageLabel)
        _contentsView.addSubview(_messageView)
        _messageView.addSubview(_tublockLabel)
        _messageView.addSubview(_tublockLogoImageView)
        _messageView.addSubview(_messageTextView)
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
        
        _messageTextView.snp.makeConstraints { make in
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

// MARK: UITextViewDelegate Method
extension SetMessageView: UITextViewDelegate {
    
    private func _addToolBarWith(textView: UITextView) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(
            title: "Confirm".localized,
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(self.donePressed)
        )
        let cancelButton = UIBarButtonItem(
            title: "Cancel".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.cancelPressed)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolBar.setItems(
            [cancelButton, spaceButton, doneButton],
            animated: false
        )
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == UserDefaultsManager.message {
            textView.textColor = .white
        }
        
        if textView.text == SetMessageView.placholderString {
            textView.text = ""
            textView.textColor = .white
        }
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        let limit = 85
        
        let newText = textView.text.trimmingCharacters(in: .whitespaces)
        guard newText.count < limit else {
            // 입력시 1 지울시 0
            if text.count == 0 {
                return true
            } else {
                delegate?.limitCount()
                return false
            }
        }

        let newLength = newText.count + text.count - range.length
        
        return newLength <= limit
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 && textView.text != SetMessageView.placholderString {
            textView.text = SetMessageView.placholderString
            textView.textColor = .gray
        } else {
            let newText = textView.text.trimmingCharacters(in: .whitespaces)
            delegate?.didEndEditing(text: newText)
        }
    }
    
    @objc
    func donePressed(){
        self.endEditing(true)
    }
    @objc
    func cancelPressed(){
        self.endEditing(true)
    }
}
