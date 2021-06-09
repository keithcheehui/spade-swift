//
//  KKOTPViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

class KKOTPViewController: KKBaseViewController {
    
    enum OTPTextField: Int {
        
        case OTPTextField1          = 1
        case OTPTextField2          = 2
        case OTPTextField3          = 3
        case OTPTextField4          = 4
    }
    
    @IBOutlet weak var imgRegister: UIImageView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var lblOTPDigit: UILabel!
    @IBOutlet weak var otpView1: UIView!
    @IBOutlet weak var txtOTP1: UITextFieldDisableTouch!
    @IBOutlet weak var otpView2: UIView!
    @IBOutlet weak var txtOTP2: UITextFieldDisableTouch!
    @IBOutlet weak var otpView3: UIView!
    @IBOutlet weak var txtOTP3: UITextFieldDisableTouch!
    @IBOutlet weak var otpView4: UIView!
    @IBOutlet weak var txtOTP4: UITextFieldDisableTouch!
    @IBOutlet weak var lblNoReceive: UILabel!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var lblSend: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var OTPView: UIView!

    @IBOutlet weak var imgRegisterHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTitleWidth: NSLayoutConstraint!
    @IBOutlet weak var txtCountryCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSendWidth: NSLayoutConstraint!

    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var mobileContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var mobileContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var mobileContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var digitContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    var phoneNumber: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        countryCodeView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        mobileView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView1.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView2.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView3.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView4.backgroundColor = UIColor(white: 0, alpha: 0.5)

        countryCodeView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        mobileView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView1.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView2.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView3.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView4.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)

        imgRegisterHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        titleContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblTitleWidth.constant = KKUtil.ConvertSizeByDensity(size: 110)
        txtCountryCodeWidth.constant = KKUtil.ConvertSizeByDensity(size: 80)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
        containerMarginBottom.constant = containerMarginTop.constant
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 180)
        containerMarginRight.constant = containerMarginLeft.constant
        mobileContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 50)
        mobileContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        mobileContainerMarginRight.constant = mobileContainerMarginLeft.constant
        digitContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        lblMobileNumber.text = KKUtil.languageSelectedStringForKey(key: "otp_mobile")
        lblOTPDigit.text = KKUtil.languageSelectedStringForKey(key: "otp_digit")
        lblNoReceive.text = KKUtil.languageSelectedStringForKey(key: "otp_did_you_receive")
        lblResend.text = KKUtil.languageSelectedStringForKey(key: "otp_resend")
        lblSend.text = KKUtil.languageSelectedStringForKey(key: "otp_send")
        
        txtMobile.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "otp_mobile_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
                
        lblMobileNumber.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelFont)
        txtCountryCode.font = lblMobileNumber.font
        txtMobile.font = lblMobileNumber.font
        lblOTPDigit.font = lblMobileNumber.font
        txtOTP1.font = lblMobileNumber.font
        txtOTP2.font = lblMobileNumber.font
        txtOTP3.font = lblMobileNumber.font
        txtOTP4.font = lblMobileNumber.font
        
        txtOTP1.tag = OTPTextField.OTPTextField1.rawValue
        txtOTP2.tag = OTPTextField.OTPTextField2.rawValue
        txtOTP3.tag = OTPTextField.OTPTextField3.rawValue
        txtOTP4.tag = OTPTextField.OTPTextField4.rawValue
        
        lblNoReceive.font = lblMobileNumber.font
        lblResend.font = lblMobileNumber.font
        lblSend.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelSmallFont)

        txtMobile.delegate = self
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP1.backspaceDelegate = self
        txtOTP2.backspaceDelegate = self
        txtOTP3.backspaceDelegate = self
        txtOTP4.backspaceDelegate = self
        
        txtMobile.returnKeyType = .next
        txtOTP1.returnKeyType = .next
        txtOTP2.returnKeyType = .next
        txtOTP3.returnKeyType = .next
        txtOTP4.returnKeyType = .done
        
        txtOTP1.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP2.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP3.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP4.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        
        txtCountryCode.isEnabled = false
        
        OTPView.isUserInteractionEnabled = true
        OTPView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(checkOTPFirstResponder)))
    }

    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSendDidPressed(){

        if txtMobile.text!.isEmpty {
            
        }
        else
        {
            if txtMobile.text!.first == "0" {
                
                phoneNumber = "60\(txtMobile.text!.dropFirst())"
            }
            else
            {
                phoneNumber = "60\(txtMobile.text!)"
            }
            
            self.requestPhoneNumberOTP()
        }
    }
    
    @IBAction func btnResendDidPressed(){

        self.btnSendDidPressed()
    }
    
    @IBAction func btnConfirmDidPressed(){
        
        self.verifyOTPAndProceed()
    }
    
    //MARK:- API Calls
    
    @objc func requestPhoneNumberOTP() {
        
        KKApiClient.sendOTPRequest(phoneNumber: phoneNumber).execute { KKOTPRequestResponse in
            
            print("success request")
            
        } onFailure: { errorMessage in
            
            print("failed request")
        }
    }
    
    func verifyOTPAndProceed() {
        
        let OTPCode = "\(txtOTP1.text!)\(txtOTP2.text!)\(txtOTP3.text!)\(txtOTP4.text!)"
        
        if OTPCode.count != 4 {
            
            
        }
        else
        {
            self.showAnimatedLoader()
            
            KKApiClient.proceedOTPVerification(phoneNumber: phoneNumber, otpCode: OTPCode).execute { generalResponse in
                
                self.hideAnimatedLoader()
                self.closeOTPAndOpenRegistration()
                
            } onFailure: { errorMessage in
                
                self.hideAnimatedLoader()
            }

        }
    }
    
    //MARK:- Others
    
    func OTPConfirmButtonValidation() {
        
        if txtOTP1.text!.isEmpty || txtOTP2.text!.isEmpty || txtOTP3.text!.isEmpty || txtOTP4.text!.isEmpty {
            btnConfirm.alpha = 0.5
            btnConfirm.isUserInteractionEnabled = false
        } else {
            btnConfirm.alpha = 1.0
            btnConfirm.isUserInteractionEnabled = true
        }
    }

    @objc func checkOTPFirstResponder() {
        
        if txtOTP1.text!.isEmpty {
            
            txtOTP1.becomeFirstResponder()
        }
        else if txtOTP2.text!.isEmpty {
            
            txtOTP2.becomeFirstResponder()
        }
        else if txtOTP3.text!.isEmpty {
            
            txtOTP3.becomeFirstResponder()
        }
        else
        {
            txtOTP4.becomeFirstResponder()
        }
    }
    
    //MARK:- OTP and Registration
    @objc func closeOTPAndOpenRegistration() {

        weak var pvc = self.presentingViewController

        self.dismiss(animated: true, completion: {
            
            let viewController = KKRegistrationViewController.init()
            viewController.verifiedPhoneNumber = self.phoneNumber
            pvc?.present(viewController, animated: true, completion: nil)
        })
    }
}

extension KKOTPViewController: UITextFieldDelegate, UITextFieldBackspaceDelegate {
    
    @objc func textfieldDidChange(_ sender: UITextField) {
        let string = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (sender == txtOTP4 && string.isEmpty){
            txtOTP4.resignFirstResponder()
            txtOTP3.becomeFirstResponder()
        }else if (sender == txtOTP3 && string.isEmpty){
            txtOTP3.resignFirstResponder()
            txtOTP2.becomeFirstResponder()
        }else if (sender == txtOTP2 && string.isEmpty){
            txtOTP2.resignFirstResponder()
            txtOTP1.becomeFirstResponder()
        } else if (sender == txtOTP1 && string.isEmpty){
            txtOTP1.resignFirstResponder()
        }
        
        if (sender == txtOTP1 && !string.isEmpty){
            txtOTP1.text = String(string.last!)
            txtOTP1.resignFirstResponder()
            txtOTP2.becomeFirstResponder()
        } else if (sender == txtOTP2 && !string.isEmpty){
            txtOTP2.text = String(string.last!)
            txtOTP2.resignFirstResponder()
            txtOTP3.becomeFirstResponder()
        } else if (sender == txtOTP3 && !string.isEmpty){
            txtOTP3.text = String(string.last!)
            txtOTP3.resignFirstResponder()
            txtOTP4.becomeFirstResponder()
        } else if (sender == txtOTP4 && !string.isEmpty){
            txtOTP4.text = String(string.last!)
            txtOTP4.resignFirstResponder()
        }
        
        OTPConfirmButtonValidation()
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case txtMobile:
            txtOTP1.becomeFirstResponder()
        case txtOTP1:
            txtOTP2.becomeFirstResponder()
        case txtOTP2:
            txtOTP3.becomeFirstResponder()
        case txtOTP3:
            txtOTP4.becomeFirstResponder()
        default:
            txtOTP4.resignFirstResponder()
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (textField != txtCountryCode && textField != txtMobile) {

            let currentText = textField.text ?? ""
            if (textField == txtOTP1 && currentText != "") {
                txtOTP2.becomeFirstResponder()
            } else if (textField == txtOTP2 && currentText != "") {
                txtOTP3.becomeFirstResponder()
            } else if (textField == txtOTP3 && currentText != "") {
                txtOTP4.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldDidDelete(textField: UITextField) {
        
        let string = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if string.isEmpty {
            
            if textField.tag != OTPTextField.OTPTextField1.rawValue {
                
                let previousTextField: UITextField = view.viewWithTag(textField.tag - 1) as! UITextField
                previousTextField.text = ""
                previousTextField.becomeFirstResponder()
            }
        }
    }
}

protocol UITextFieldBackspaceDelegate: AnyObject {
    func textFieldDidDelete(textField: UITextField)
}

class UITextFieldDisableTouch: UITextField {
    
    weak var backspaceDelegate: UITextFieldBackspaceDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        backspaceDelegate?.textFieldDidDelete(textField: self)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}
