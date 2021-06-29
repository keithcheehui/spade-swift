//
//  KKLoginViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKLoginViewController: KKBaseViewController {

    @IBOutlet weak var imgLogin: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var rememberView: UIView!
    @IBOutlet weak var imgRememberMe: UIImageView!
    @IBOutlet weak var lblRememberMe: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var imgConfirm: UIImageView!
    
    @IBOutlet weak var imgLoginHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!

    @IBOutlet weak var rememberMeCheckboxWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var passwordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var rememberMeContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    var homeViewController: KKHomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0)
        
        usernameView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        passwordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        rememberView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        usernameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        passwordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        rememberView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        imgLoginHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        usernameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 80)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
    
        containerWidth.constant = ConstantSize.ssoPopUpWidth
        containerHeight.constant = ConstantSize.ssoPopUpHeight
        rememberMeCheckboxWidth.constant = KKUtil.ConvertSizeByDensity(size: 20)
        usernameContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 50)
        usernameContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 60)
        usernameContainerMarginRight.constant = usernameContainerMarginLeft.constant
        passwordContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        rememberMeContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 8)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        lblUsername.text = KKUtil.languageSelectedStringForKey(key: "login_username")
        lblPassword.text = KKUtil.languageSelectedStringForKey(key: "login_password")
        lblRememberMe.text = KKUtil.languageSelectedStringForKey(key: "login_remember_me")
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "login_forgot_password"), attributes: underlineAttribute)
        lblForgotPassword.attributedText = underlineAttributedString
        
        txtUsername.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "login_username_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "login_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
                
        lblUsername.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelFont)
        txtUsername.font = lblUsername.font
        lblPassword.font = lblUsername.font
        txtPassword.font = lblUsername.font
        lblRememberMe.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelSmallFont)
        lblForgotPassword.font = lblRememberMe.font
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        
        txtUsername.returnKeyType = .next
        txtPassword.returnKeyType = .done
        
        imgRememberMe.isHidden = true
    }
    
    //MARK:- Validation
    
    @objc func runTextFieldValidation() {
        
        self.view.endEditing(true)
        
        if txtUsername.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_username_required_desc"))
            return
        }
        
        if txtPassword.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_required_desc"))
            return
        }
        
        self.showAnimatedLoader()
        self.userAccountLogin()
    }
    
    //MARK:- API Calls
    
    @objc func userAccountLogin() {
        
        KKApiClient.userAccountLogin(username: txtUsername.text!, password: txtPassword.text!).execute { userCredential in
            
            KeychainSwift().set(self.txtUsername.text!, forKey: CacheKey.username)
            KeychainSwift().set(self.txtPassword.text!, forKey: CacheKey.secret)
            
            KKTokenManager.setUserCredential(userCredential: userCredential)
            
            UserDefaults.standard.set(true, forKey: CacheKey.loginStatus)
            UserDefaults.standard.synchronize()
            self.showAlertView(type: .Success, alertMessage: userCredential.message ?? "")
            
            self.getUserLatestWallet()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getUserLatestWallet() {
        
        KKApiClient.getUserLatestWallet().execute { userWalletResponse in
            
            if let userWalletResult = userWalletResponse.results {
                
                self.getUserProfile(walletBalance: userWalletResult.walletBalance!)
            }
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismissPresentedViewWithBackgroundFaded()
            }
        }
    }
    
    @objc func getUserProfile(walletBalance: String) {
        
        KKApiClient.getUserProfile().execute { userProfileResponse in
            
            guard var userProfile = userProfileResponse.results?.user![0] else { return }
            userProfile.walletBalance = walletBalance
            
            do {
                KeychainSwift().set(try JSONEncoder().encode(userProfile), forKey: CacheKey.userProfile)
                KeychainSwift().set(try JSONEncoder().encode(KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == userProfile.locale})!), forKey: CacheKey.selectedLanguage)
            }
            catch {
                self.hideAnimatedLoader()
                self.showAlertView(type: .Error, alertMessage: error.localizedDescription)
            }
            
            self.hideAnimatedLoader()

            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismissPresentedViewWithBackgroundFaded()
            }
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)

            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismissPresentedViewWithBackgroundFaded()
            }
        }
    }

    //MARK:- Button Actions
    
    @IBAction func btnCloseDidPressed(){
        self.dismissPresentedViewWithBackgroundFaded()
    }
    
    @IBAction func btnRememberMeDidPressed(){
        if (imgRememberMe.isHidden){
            imgRememberMe.isHidden = false
        } else {
            imgRememberMe.isHidden = true
        }
    }
    
    @IBAction func btnForgotPasswordDidPressed(){
        closeOTPAndOpenForgotPassword()
    }
    
    //MARK:- OTP and Registration
    
    @objc func closeOTPAndOpenForgotPassword() {

        weak var pvc = self.presentingViewController

        UIView.animate(withDuration: 0.25) {
            
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            
        } completion: { complete in
            
            self.dismiss(animated: true, completion: {
                let viewController = KKOTPViewController.init()
                viewController.isFromForgotPassword = true
                viewController.homeViewController = self.homeViewController
                pvc?.present(viewController, animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func btnConfirmDidPressed(){
        
        self.runTextFieldValidation()
    }
    
    //MARK:- Others
    
    @objc func dismissPresentedViewWithBackgroundFaded() {
        
        homeViewController.updateUserProfileDetails()
        
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            
        } completion: { complete in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension KKLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case txtUsername:
            txtPassword.becomeFirstResponder()
        default:
            txtPassword.resignFirstResponder()
        }
    }
}

