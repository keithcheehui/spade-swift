//
//  KKLoginViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

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
    
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var rememberMeCheckboxWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var passwordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var rememberMeContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        usernameView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        passwordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        rememberView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        usernameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        passwordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        rememberView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        imgLoginHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        usernameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 80)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
        containerMarginBottom.constant = containerMarginTop.constant
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
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
    
    //MARK:- API Calls
    
    @objc func userAccountLogin() {
        
        self.showAnimatedLoader()
        
        KKApiClient.userAccountLogin(username: txtUsername.text!, password: txtPassword.text!).execute { userCredential in
            
            self.hideAnimatedLoader()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
        }
    }

    //MARK:- Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnRememberMeDidPressed(){
        if (imgRememberMe.isHidden){
            imgRememberMe.isHidden = false
        } else {
            imgRememberMe.isHidden = true
        }
    }
    
    @IBAction func btnForgotPasswordDidPressed(){
        
    }
    
    @IBAction func btnConfirmDidPressed(){
        self.dismiss(animated: false, completion: nil)
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

