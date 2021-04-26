//
//  KKSplashScreenViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 27/04/2021.
//

import UIKit

class KKSplashScreenViewController: KKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.proceedToOnboardingPage()
    }

    @objc func proceedToOnboardingPage() {
        
        let viewController = KKOnBoardingViewController.init()
        let navigationController = UINavigationController.init(rootViewController: viewController)
        
        if #available(iOS 13.0, *) {
        
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            
                sceneDelegate.changeRootViewController(viewController: navigationController)
            }
        }
        else
        {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
                        
            UIView.transition(with: window, duration: Double(0.25), options: .transitionCrossDissolve, animations: {
                
                let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                appDelegate!.window?.rootViewController = navigationController
                
            }, completion: nil)
        }
    }
    

}
