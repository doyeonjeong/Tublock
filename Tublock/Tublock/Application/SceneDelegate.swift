//
//  SceneDelegate.swift
//  Tublock
//
//  Created by Doyeon on 2023/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainViewController()
        
        let gradientView = UIView(frame: windowScene.coordinateSpace.bounds)
        gradientView.applyGradient(colos: [
            UIColor(red: 0.99, green: 0.65, blue: 0.04, alpha: 1.00).cgColor,
            UIColor(red: 0.85, green: 0.11, blue: 0.07, alpha: 1.00).cgColor
        ])
        window?.insertSubview(gradientView, at: 0)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

extension UIView {
    func applyGradient(colos: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colos
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
