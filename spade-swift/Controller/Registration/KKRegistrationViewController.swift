//
//  KKRegistrationViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

class KKRegistrationViewController: KKBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgRegister: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
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
    
    @IBOutlet weak var imgRegisterHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var txtUsernameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmWidth: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var usernameContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var passwordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        usernameView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        passwordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        confirmPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        usernameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        passwordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        confirmPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        imgRegisterHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        usernameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        txtUsernameWidth.constant = KKUtil.ConvertSizeByDensity(size: 300)
        btnConfirmWidth.constant = KKUtil.ConvertSizeByDensity(size: 200)
        usernameContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 50)
        usernameContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        usernameContainerMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 80)
        passwordContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        confirmPasswordContainerMarginTop.constant = passwordContainerMarginTop.constant
        btnConfirmContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 40)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        lblUsername.text = KKUtil.languageSelectedStringForKey(key: "register_username")
        lblPassword.text = KKUtil.languageSelectedStringForKey(key: "register_password")
        lblConfirmPassword.text = KKUtil.languageSelectedStringForKey(key: "register_confirm_password")

        txtUsername.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_username_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_confirm_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
                
        lblUsername.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        txtUsername.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        lblPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        txtPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        lblConfirmPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))
        txtConfirmPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: ConstantSize.ssoLabelFont))

        txtUsername.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        txtUsername.returnKeyType = .next
        txtPassword.returnKeyType = .next
        txtConfirmPassword.returnKeyType = .done
    }

    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
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
        case txtPassword:
            txtConfirmPassword.becomeFirstResponder()
        default:
            txtConfirmPassword.resignFirstResponder()
        }
    }

}
