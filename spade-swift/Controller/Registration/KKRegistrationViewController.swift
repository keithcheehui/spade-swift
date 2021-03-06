//
//  KKRegistrationViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import KeychainSwift
import UIKit

class KKRegistrationViewController: KKBaseViewController {
    
    @IBOutlet weak var imgRegister: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var usernameContainer: UIView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var imgConfirm: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblNote: UILabel!

    @IBOutlet weak var imgRegisterHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var passwordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    var verifiedPhoneNumber: String!
    var homeViewController: KKHomeViewController!
    var isFromForgotPassword = false

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
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
        
        usernameView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        passwordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        confirmPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        usernameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        passwordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        confirmPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        imgRegisterHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        usernameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 120)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        containerWidth.constant = ConstantSize.ssoPopUpWidth
        containerHeight.constant = ConstantSize.ssoPopUpHeight
        usernameContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 50)
        usernameContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 60)
        usernameContainerMarginRight.constant = usernameContainerMarginLeft.constant
        passwordContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        lblUsername.text = KKUtil.languageSelectedStringForKey(key: "register_username")
        lblPassword.text = isFromForgotPassword ? KKUtil.languageSelectedStringForKey(key: "forgot_pwd_new_pwd") : KKUtil.languageSelectedStringForKey(key: "register_password")
        lblConfirmPassword.text = KKUtil.languageSelectedStringForKey(key: "register_confirm_password")

        txtUsername.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_username_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_confirm_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
                
        lblUsername.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelFont)
        txtUsername.font = lblUsername.font
        lblPassword.font = lblUsername.font
        txtPassword.font = lblUsername.font
        lblConfirmPassword.font = lblUsername.font
        txtConfirmPassword.font = lblUsername.font

        txtUsername.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        txtUsername.returnKeyType = .next
        txtPassword.returnKeyType = .next
        txtConfirmPassword.returnKeyType = .done
        
        lblNote.text = KKUtil.languageSelectedStringForKey(key: "settings_notes")
        lblNote.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 9))
        lblNote.textColor = .spade_orange_FFBA00
        
        if (isFromForgotPassword) {
            usernameContainer.isHidden = true
            txtUsername.isUserInteractionEnabled = false
            imgRegister.image = UIImage(named: "title_forgotpassword")

        } else {
            usernameContainer.isHidden = false
            txtUsername.isUserInteractionEnabled = true
            imgRegister.image = UIImage(named: "title_register")

        }
    }
    
    //MARK:- Validation
    
    @objc func runTextFieldValidation() {
        
        self.view.endEditing(true)
        
        if (!isFromForgotPassword) {
            if txtUsername.text!.count == 0 {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_username_required_desc"))
                return
            }
            
            if !KKUtil.isValidInput(testStr: txtUsername.text!){
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_username_text_length"))
                return
            }
        }
        
        if txtPassword.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_required_desc"))
            return
        }
        
        if !KKUtil.isValidPasswordInput(testStr: txtPassword.text!){
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_text_length"))
            return
        }
        
        if txtConfirmPassword.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_confirm_required_desc"))
            return
        }
        
        if txtConfirmPassword.text != txtPassword.text {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_not_match_desc"))
            return
        }
        
        if (isFromForgotPassword) {
            self.forgotPasswordAPI()
        } else {
            self.registrationAPI()
        }
    }
    
    //MARK:- API Calls
    
    @objc func registrationAPI() {
        
        self.showAnimatedLoader()
        
        KKApiClient.registration(username: txtUsername.text!, password: txtPassword.text!, phoneNumber: verifiedPhoneNumber).execute { userCredential in
            self.showAlertView(type: .Success, alertMessage: userCredential.message ?? "")

            self.loginAPI()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc func forgotPasswordAPI() {
        
        self.showAnimatedLoader()
        
        KKApiClient.forgotPassword(password: txtPassword.text!, phoneNumber: verifiedPhoneNumber).execute { userCredential in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Success, alertMessage: userCredential.message ?? "")

            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismissPresentedViewWithBackgroundFaded()
            }
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc func loginAPI() {
        
        KKApiClient.login(username: txtUsername.text!, password: txtPassword.text!).execute { userCredential in
            KeychainSwift().set(self.txtUsername.text!, forKey: CacheKey.username)
            KeychainSwift().set(self.txtPassword.text!, forKey: CacheKey.secret)
            
            KKTokenManager.setUserCredential(userCredential: userCredential)
            UserDefaults.standard.set(true, forKey: CacheKey.loginStatus)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name("NotificationUpdateProfile"), object: nil)

            self.deviceRegister()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc func deviceRegister() {
        
        KKApiClient.deviceRegister().execute { generalResponse in
            
            self.hideAnimatedLoader()
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.dismissPresentedViewWithBackgroundFaded()
            }
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }

    //MARK:- Button Actions
    
    @IBAction func btnCloseDidPressed(){
        self.dismissPresentedViewWithBackgroundFaded()
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

extension KKRegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case txtUsername:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            txtConfirmPassword.becomeFirstResponder()
        default:
            txtConfirmPassword.resignFirstResponder()
        }
    }

}
