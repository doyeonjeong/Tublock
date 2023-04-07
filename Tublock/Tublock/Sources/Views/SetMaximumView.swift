//
//  SetMaximumView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/07.
//

import UIKit
import SnapKit

class SetMaximumView: UIView {
    
    var hours: Int = 0
    var minutes: Int = 0
    
    private let contentsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Maximum"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "We recommend\nless than 3 hours."
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        label.sizeToFit()
        return label
    }()
    
    private let timeSettingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(contentsView)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentsView.widthAnchor.constraint(equalToConstant: 344),
            contentsView.heightAnchor.constraint(equalToConstant: 87.4),
            contentsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            contentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            contentsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42)
        ])
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView, timeSettingView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        
        contentsView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 0),
            horizontalStackView.topAnchor.constraint(equalTo: contentsView.topAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: 0),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            timeSettingView.widthAnchor.constraint(equalToConstant: 168),
            timeSettingView.heightAnchor.constraint(equalToConstant: 67.4)
        ])
        
        timeSettingView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: timeSettingView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: timeSettingView.centerYAnchor)
        ])
        
        configureTimeLabel()
    }
    
    private func configureTimeLabel() {
        updateAttributedText()
    }
    
    private func updateAttributedText() {
        let hoursText = NSAttributedString(string: "\(hours)",
                                           attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
        let minutesText = NSAttributedString(string: "\(minutes)",
                                             attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
        let hoursLabel = NSAttributedString(string: " hours ",
                                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        let minutesLabel = NSAttributedString(string: " min",
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(hoursText)
        attributedText.append(hoursLabel)
        attributedText.append(minutesText)
        attributedText.append(minutesLabel)
        
        timeLabel.attributedText = attributedText
    }

}
