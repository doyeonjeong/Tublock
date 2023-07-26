//
//  MainViewController.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/23.
//

import UIKit
import SnapKit
import SwiftUI
import FamilyControls

class MainViewController: UIViewController {
    
    private lazy var _headerView = HeaderView()
    private lazy var _mainView = MainView()
    private lazy var _footerView = FooterView()
    
    private lazy var _selectingView: UIHostingController<some View> = {
        let viewModel = BlockingManager()
        let selectingView = AnyView(SelectingView().environmentObject(viewModel))
        return UIHostingController(rootView: selectingView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _requestAuthorization()
    }
}

extension MainViewController {
    private func _setup() {
        _addSubviews()
        _setConstraints()
        _setDelegate()
    }
    
    private func _addSubviews() {
        view.addSubview(_headerView)
        view.addSubview(_mainView)
        view.addSubview(_footerView)
    }
    
    private func _setDelegate() {
        _mainView.delegate = self
        _headerView.delegate = self
    }
    
    private func _setConstraints() {
        _headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        
        _mainView.snp.makeConstraints {
            $0.top.equalTo(_headerView.snp.bottom)
            $0.bottom.equalTo(_footerView.snp.top).offset(-40)
            $0.left.right.equalToSuperview().inset(30)
        }
        
        _footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(70)
            $0.left.right.equalToSuperview().inset(30)
        }
    }
}

extension MainViewController {
    
    private func _requestAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            } catch {
                print("권한 요청 에러: \(error.localizedDescription)")
            }
        }
    }
}

extension MainViewController: MainViewDelegate {
    
    func didSelectAddButton() {
        _selectingView.modalPresentationStyle = .pageSheet
        present(_selectingView, animated: true)
        
    }
    
}

extension MainViewController: HeaderViewDelegate {
    
    func didTapSettingsButton() {
        let modalViewController = SettingViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        self.present(modalViewController, animated: true)
    }
    
}
