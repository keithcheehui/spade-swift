//
//  KKBaseViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import Kingfisher

class KKBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var activityIndicator:      UIActivityIndicatorView!
    var tableContentView:       UIView!
    var displayViewController:  KKBaseViewController!
    var selectedGameType: Int = 0
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        activityIndicator = UIActivityIndicatorView.init(style: .white)
        activityIndicator.alpha = CGFloat(0)
        activityIndicator.color = .spade_white_FFFFFF
        activityIndicator.backgroundColor = UIColor.spade_black_000000.withAlphaComponent(0.75)
        
        if tableContentView != nil {
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: tableContentView.frame.size.width, height: tableContentView.frame.size.height)
        }
        else {
         
            activityIndicator.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        }
        
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
    
    //MARK:- Alert View Setup
    
    func showAlertView(alertMessage: String) {
        
        if alertMessage.contains("connection") && alertMessage.contains("offline") {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_internet_connection"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_internet_connection_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else if alertMessage.contains("internal server error") {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_internal_server_error"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_internal_server_error_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else if (alertMessage.contains("invalid_grant") || alertMessage.contains("Invalid password")) {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_invalid_credential"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_invalid_credential_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else
        {
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_error_encountered"),
                                           body: alertMessage,
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
    }
    
    func showPopUpWithSingleButton(title: String, body: String, buttonTitle: String) {
        
        let alertView = KKCustomAlertViewController.init(title: title, body: body, buttonTitle: buttonTitle)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK:- General Method

    @objc func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIDevice {
    
    var hasNotch: Bool {
        
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

extension String {
    
    var isBackspace: Bool {
        
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    func addCurrencyFormat() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = ","
        
        let number = NumberFormatter().number(from: self)!
        return formatter.string(from: number)!
    }
}

extension UIImageView {
    
    func setUpImage(with url: String?, placeholder: UIImage? = nil) {
        
        if let urlString = url , let URL = URL(string: urlString) {
                            
            self.kf.setImage(with: URL, placeholder: placeholder)
        }
        else if let image = placeholder
        {
            self.image = image
        }
    }
}

extension UIView {
    
    func startRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = false
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func removeRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = false
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.layer.removeAllAnimations()
        }
    }
}
