//
//  KKSplashScreenViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 27/04/2021.
//

import UIKit

class KKSplashScreenViewController: KKBaseViewController {

    @IBOutlet weak var loadingBar: UIView!
    @IBOutlet weak var imgBgloadingBar: UIImageView!
    @IBOutlet weak var lblLoading: UILabel!
    
    @IBOutlet weak var imgLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var loadingBarHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblLoadingMarginBottom: NSLayoutConstraint!
    
    var imgProgress: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        drawLoadingProgress()
        self.proceedToOnboardingPage()
    }

    func initialLayout(){
        imgLogoWidth.constant = KKUtil.ConvertSizeByDensity(size: 480)
        loadingBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        loadingBarMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 130)
        loadingBarMarginRight.constant = loadingBarMarginLeft.constant
        lblLoadingMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
    }

    func drawLoadingProgress(){
        imgProgress = UIImageView.init()
        imgProgress.image = UIImage(named: "bg_loading_bar")
        imgProgress.contentMode = .scaleToFill
        imgProgress.frame = imgBgloadingBar.bounds
        imgProgress.frame.size.width = 0
        loadingBar.addSubview(imgProgress)
        
        //TODO: KEITH, NEED TO ADD ANIMATION AND THE WIDTH IS NOT CORRECT
        //MAKE THE lblLoading % ANIMATION TOO
        
    }
    
    @objc func proceedToOnboardingPage() {
        
        let viewController = KKOnBoardingViewController.init()
        let navigationController = UINavigationController.init(rootViewController: viewController)
        
        if #available(iOS 13.0, *) {
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                let scene = UIApplication.shared.connectedScenes.first
                if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                
                    sceneDelegate.changeRootViewController(viewController: navigationController)
                }
            })
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
