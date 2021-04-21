//
//  SKBaseViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import Kingfisher

class SKBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var activityIndicator:       UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        activityIndicator = UIActivityIndicatorView.init(style: .white)
        activityIndicator.alpha = CGFloat(0)
        activityIndicator.color = .cinemoi_white_FFFFFF
        activityIndicator.backgroundColor = UIColor.cinemoi_black_000000.withAlphaComponent(0.75)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Show/Hide Animation Loader
    func showAnimatedLoader() {
        
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: Double(0.25), delay: Double(0), options: .beginFromCurrentState, animations: {
            
            self.activityIndicator.alpha = CGFloat(1)
            
        }, completion: nil)
    }

    func hideAnimatedLoader() {
        
        self.view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: Double(0.25), delay: Double(0), options: .beginFromCurrentState, animations: {
            
            self.activityIndicator.alpha = CGFloat(0)
            
        }, completion: { completed in
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        })
    }
    
    //MARK:- General Method

    @objc func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
