//
//  TimePickerModalView.swift
//  Tublock
//
//  Created by Doyeon on 2023/04/11.
//

import UIKit
import SnapKit

final class TimePickerModalViewController: UIViewController {
    
    private let _helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Modal"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(_helloLabel)
        _helloLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
