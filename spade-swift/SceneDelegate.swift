//
//  SceneDelegate.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)
            let viewController = KKSplashScreenViewController.init()
            window.rootViewController = viewController

            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeRootViewController(viewController: UIViewController) {
        
        if (!((self.window?.rootViewController) != nil)) {
            
            self.window?.rootViewController = viewController
            return
        }
        
        let snapshot: UIView! = self.window?.snapshotView(afterScreenUpdates: true)
        viewController.view.addSubview(snapshot!)
        self.window?.rootViewController = viewController
        
        UIView.transition(with: snapshot,
                          duration: Double(0.25),
                          options: .transitionCrossDissolve,
                          animations: {
            snapshot.layer.opacity = 0
            snapshot.layer.transform = CATransform3DMakeScale(CGFloat(1.5), CGFloat(1.5), CGFloat(1.5))
        },
        completion: { status in
            snapshot.removeFromSuperview()
        })
    }
}

