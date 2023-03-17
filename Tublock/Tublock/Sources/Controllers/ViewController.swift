//
//  ViewController.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import UIKit

final class ViewController: UIViewController {

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
        setCheckButton()
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
    
    private func setCheckButton() {
        let checkButton = UIButton(type: .system)
        checkButton.frame = .zero
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setTitle("Tap to check your message", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.backgroundColor = .black
        checkButton.layer.cornerRadius = 10
        checkButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            checkButton.widthAnchor.constraint(equalToConstant: 345),
            checkButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        print("ButtonPressed")
    }
}
