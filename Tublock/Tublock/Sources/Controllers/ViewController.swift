//
//  ViewController.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import UIKit

final class ViewController: UIViewController {
    
    let onboardingMessages: [String] = [ // how to use? 버튼을 만들어서 모달로 보여주기
        "Hi there, 👋🏻",
        """
        We'll send you a reminder every 5 minutes
        whenever you turn on YouTube and keep it on.
        """,
        """
        Write a message you want to say
        to yourself at that time.
        """,
        """
        We hope this app can help you improve
        your dopamine addiction.
        """
    ]
    
    // MARK: - Properties
    lazy var checkButton: UIButton = {
        let button = makeButton("Tap to check your message")
        button.addTarget(self, action: #selector(pressedCheckButton), for: .touchUpInside)
        return button
    }()
    
    lazy var sampleButton: UIButton = {
        let button = makeButton("Tap to check sample message")
        button.addTarget(self, action: #selector(pressedSampleButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension ViewController {
    // MARK: - Methods of set up view
    private func setup() {
        setBackground()
        addViews()
        setAutoLayout()
    }
    
    private func setBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.588, green: 0.39, blue: 0.592, alpha: 0.71).cgColor,
            UIColor(red: 0.569, green: 0.632, blue: 0.962, alpha: 0.71).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x:0.0, y:0.0)
        gradientLayer.endPoint = CGPoint(x:1.0, y:1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addViews() {
        view.addSubview(checkButton)
        view.addSubview(sampleButton)
    }

    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            checkButton.widthAnchor.constraint(equalToConstant: 345),
            checkButton.heightAnchor.constraint(equalToConstant: 42),
            
            sampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleButton.bottomAnchor.constraint(equalTo: checkButton.topAnchor, constant: -20),
            sampleButton.widthAnchor.constraint(equalToConstant: 345),
            sampleButton.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    
    // MARK: - Action Mehtods
    @objc func pressedCheckButton(_ sender: UIButton) {
        print("pressedCheckButton")
    }
    
    @objc func pressedSampleButton(_ sender: UIButton) {
        print("pressedSampleButton")
    }
    
    // MARK: - Methods for Custom UI
    private func makeButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressedCheckButton), for: .touchUpInside)
        return button
    }
}
