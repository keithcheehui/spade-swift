//
//  KKLoginViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

class KKLoginViewController: KKBaseViewController,UITextFieldDelegate {

    @IBOutlet weak var imgLogin: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgRememberMe: UIImageView!
    @IBOutlet weak var lblRememberMe: UILabel!
    @IBOutlet weak var btnRememberMe: UIButton!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var imgConfirm: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var imgLoginHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var txtUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var passwordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var rememberMeContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.05)

        imgLoginHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 40)
        usernameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        lblUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 100)
        txtUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 350)
        btnConfirmWidth.constant = KKUtil.ConvertSizeByDensity(size: 200)
        usernameContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        usernameContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        usernameContainerMarginRight.constant = usernameContainerMarginLeft.constant
        passwordContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        rememberMeContainerMarginTop.constant = 0
        btnConfirmContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 20)
        
        lblUsername.text = KKUtil.languageSelectedStringForKey(key: "login_username")
        txtUsername.placeholder = KKUtil.languageSelectedStringForKey(key: "login_username_placeholder")
        lblPassword.text = KKUtil.languageSelectedStringForKey(key: "login_password")
        txtPassword.placeholder = KKUtil.languageSelectedStringForKey(key: "login_password_placeholder")
        lblRememberMe.text = KKUtil.languageSelectedStringForKey(key: "login_remember_me")
        lblForgotPassword.text = KKUtil.languageSelectedStringForKey(key: "login_forgot_password")

        lblUsername.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        txtUsername.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        lblPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        txtPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        lblRememberMe.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelSmallFont))
        lblForgotPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelSmallFont))
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        
        txtUsername.returnKeyType = .next
        txtPassword.returnKeyType = .done
    }

    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnRememberMeDidPressed(){
        
    }
    
    @IBAction func btnForgotPasswordDidPressed(){
        
    }
    
    @IBAction func btnConfirmDidPressed(){
        
    }
    
    ///TextField Delegate
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

