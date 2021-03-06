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
        case OTPTextField5          = 5
        case OTPTextField6          = 6
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
    @IBOutlet weak var otpView5: UIView!
    @IBOutlet weak var txtOTP5: UITextFieldDisableTouch!
    @IBOutlet weak var otpView6: UIView!
    @IBOutlet weak var txtOTP6: UITextFieldDisableTouch!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var lblNoReceive: UILabel!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var lblSend: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var OTPView: UIView!
    @IBOutlet weak var btnSendContainer: UIView!
    
    @IBOutlet weak var imgRegisterHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTitleWidth: NSLayoutConstraint!
    @IBOutlet weak var txtCountryCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSendWidth: NSLayoutConstraint!

    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var mobileContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var digitContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmContainerMarginBottom: NSLayoutConstraint!
    
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblNotesMarginTop: NSLayoutConstraint!
    @IBOutlet weak var lblNotesMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var lblNotesMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblNotesMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblNotesHeight: NSLayoutConstraint!

    var homeViewController: KKHomeViewController!
    var phoneNumber: String! = ""
    var otpTextField6NotEmpty = false
    var timerCountdown = 60
    var timer = Timer()
    
    var isFromForgotPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        countryCodeView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        mobileView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView1.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView2.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView3.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView4.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView5.backgroundColor = UIColor(white: 0, alpha: 0.5)
        otpView6.backgroundColor = UIColor(white: 0, alpha: 0.5)

        countryCodeView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        mobileView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView1.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView2.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView3.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView4.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView5.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        otpView6.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)

        imgRegisterHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        titleContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblTitleWidth.constant = KKUtil.ConvertSizeByDensity(size: 110)
        txtCountryCodeWidth.constant = KKUtil.ConvertSizeByDensity(size: 80)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        containerWidth.constant = ConstantSize.ssoPopUpWidth
        containerHeight.constant = ConstantSize.ssoPopUpHeight
        mobileContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        mobileContainerMarginRight.constant = mobileContainerMarginLeft.constant
        digitContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 16)
        btnConfirmContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        lblNotesMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 35)
        lblNotesMarginRight.constant = KKUtil.ConvertSizeByDensity(size: -35)
        
        let selectedCountryDetails = KKUtil.decodeUserCountryFromCache()
        txtCountryCode.text = "\(selectedCountryDetails.code!.dropLast()) +\(selectedCountryDetails.countryPrefix!)"
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
        txtOTP5.font = lblMobileNumber.font
        txtOTP6.font = lblMobileNumber.font

        txtOTP1.tag = OTPTextField.OTPTextField1.rawValue
        txtOTP2.tag = OTPTextField.OTPTextField2.rawValue
        txtOTP3.tag = OTPTextField.OTPTextField3.rawValue
        txtOTP4.tag = OTPTextField.OTPTextField4.rawValue
        txtOTP5.tag = OTPTextField.OTPTextField5.rawValue
        txtOTP6.tag = OTPTextField.OTPTextField6.rawValue

        lblNoReceive.font = lblMobileNumber.font
        lblResend.font = lblMobileNumber.font
        lblSend.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelSmallFont)

        txtMobile.delegate = self
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP5.delegate = self
        txtOTP6.delegate = self
        txtOTP1.backspaceDelegate = self
        txtOTP2.backspaceDelegate = self
        txtOTP3.backspaceDelegate = self
        txtOTP4.backspaceDelegate = self
        txtOTP5.backspaceDelegate = self
        txtOTP6.backspaceDelegate = self
        
        txtMobile.returnKeyType = .next
        txtOTP1.returnKeyType = .next
        txtOTP2.returnKeyType = .next
        txtOTP3.returnKeyType = .next
        txtOTP4.returnKeyType = .next
        txtOTP5.returnKeyType = .next
        txtOTP6.returnKeyType = .done
        
        txtOTP1.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP2.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP3.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP4.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP5.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        txtOTP6.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)

        txtMobile.keyboardType = .numberPad
        txtOTP1.keyboardType = .numberPad
        txtOTP2.keyboardType = .numberPad
        txtOTP3.keyboardType = .numberPad
        txtOTP4.keyboardType = .numberPad
        txtOTP5.keyboardType = .numberPad
        txtOTP6.keyboardType = .numberPad

        txtCountryCode.isEnabled = false
        
        OTPView.isUserInteractionEnabled = true
        OTPView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(checkOTPFirstResponder)))
        
        resendView.isHidden = true
        btnSend.isUserInteractionEnabled = true
        
        if (isFromForgotPassword) {
            lblNotesMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 40)
            lblNotesMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 15)
            lblNotesHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
            
            imgRegister.image = UIImage(named: "title_forgotpassword")
            lblNotes.isHidden = false
            
            lblNotes.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelSmallFont)
            lblNotes.textColor = .spade_white_FFFFFF
            lblNotes.text = KKUtil.languageSelectedStringForKey(key: "forgot_pwd_note")
        } else {
            lblNotesMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 50)
            lblNotesMarginBottom.constant = 0
            lblNotesHeight.constant = 0

            imgRegister.image = UIImage(named: "title_register")
            lblNotes.isHidden = true
        }
    }

    @objc func timerUpdate() {
        if(timerCountdown > 0) {
            timerCountdown -= 1
            lblResend.text = KKUtil.languageSelectedStringForKey(key: "otp_resend") + String(timerCountdown)
            btnSend.isUserInteractionEnabled = false
            btnResend.isUserInteractionEnabled = false
        } else {
            timer.invalidate()
            btnSend.isUserInteractionEnabled = true
            btnResend.isUserInteractionEnabled = true
            lblResend.text = KKUtil.languageSelectedStringForKey(key: "otp_click_to_resend")
        }
    }
    
    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismissPresentedViewWithBackgroundFaded()
    }
    
    @IBAction func btnSendDidPressed(){

        if txtMobile.text!.isEmpty {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_mobile_required_desc"))
        } else {
            //TODO: Keith this one need review again, ask not always selected Malaysia country
            if txtMobile.text!.first == "0" {
                phoneNumber = "60\(txtMobile.text!.dropFirst())"
            } else {
                phoneNumber = "60\(txtMobile.text!)"
            }
            
            if (isFromForgotPassword) {
                self.forgotPasswordOTPRequestAPI()
            } else {
                self.registerOTPRequestAPI()
            }
        }
    }
    
    @IBAction func btnResendDidPressed(){
        self.btnSendDidPressed()
    }
    
    @IBAction func btnConfirmDidPressed(){
        self.verifyOTPAndProceed()
    }
    
    //MARK:- API Calls
    
    @objc func registerOTPRequestAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.registerOTPRequest(phoneNumber: phoneNumber).execute { KKOTPRequestResponse in
            self.hideAnimatedLoader()
            self.resendView.isHidden = false
            self.timerCountdown = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
            
            self.txtOTP1.becomeFirstResponder()
            self.txtMobile.isEnabled = false
            self.txtMobile.isUserInteractionEnabled = false
            self.btnSendContainer.isHidden = true
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc func forgotPasswordOTPRequestAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.forgotPasswordOTPRequest(phoneNumber: phoneNumber).execute { KKOTPRequestResponse in
            self.hideAnimatedLoader()
            self.resendView.isHidden = false
            self.timerCountdown = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
            
            self.txtOTP1.becomeFirstResponder()
            self.txtMobile.isEnabled = false
            self.txtMobile.isUserInteractionEnabled = false
            self.btnSendContainer.isHidden = true
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func verifyOTPAndProceed() {
        
        let OTPCode = "\(txtOTP1.text!)\(txtOTP2.text!)\(txtOTP3.text!)\(txtOTP4.text!)\(txtOTP5.text!)\(txtOTP6.text!)"
        if OTPCode.count != 6 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_otp_required_desc"))
        } else {
            self.showAnimatedLoader()
            
            if (isFromForgotPassword) {
                KKApiClient.forgotPasswordOTPVerify(phoneNumber: phoneNumber, otpCode: OTPCode).execute { generalResponse in
                    self.hideAnimatedLoader()
                    self.closeOTPAndOpenRegistration()
                } onFailure: { errorMessage in
                    self.hideAnimatedLoader()
                    self.showAlertView(type: .Error, alertMessage: errorMessage)
                }
            } else {
                KKApiClient.registerOTPVerify(phoneNumber: phoneNumber, otpCode: OTPCode).execute { generalResponse in
                    self.hideAnimatedLoader()
                    self.closeOTPAndOpenRegistration()
                } onFailure: { errorMessage in
                    self.hideAnimatedLoader()
                    self.showAlertView(type: .Error, alertMessage: errorMessage)
                }
            }
        }
    }
    
    //MARK:- Others
    
    func OTPConfirmButtonValidation() {
        
        if txtOTP1.text!.isEmpty || txtOTP2.text!.isEmpty || txtOTP3.text!.isEmpty || txtOTP4.text!.isEmpty || txtOTP5.text!.isEmpty || txtOTP6.text!.isEmpty {
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
        } else if txtOTP2.text!.isEmpty {
            txtOTP2.becomeFirstResponder()
        } else if txtOTP3.text!.isEmpty {
            txtOTP3.becomeFirstResponder()
        } else if txtOTP4.text!.isEmpty {
            txtOTP4.becomeFirstResponder()
        } else if txtOTP5.text!.isEmpty {
            txtOTP5.becomeFirstResponder()
        }else {
            txtOTP6.becomeFirstResponder()
        }
    }
    
    //MARK:- Others
    
    @objc func dismissPresentedViewWithBackgroundFaded() {
        
        UIView.animate(withDuration: 0.25) {
            
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            
        } completion: { complete in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- OTP and Registration
    
    @objc func closeOTPAndOpenRegistration() {

        weak var pvc = self.presentingViewController

        UIView.animate(withDuration: 0.25) {
            
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            
        } completion: { complete in
            
            self.dismiss(animated: true, completion: {
                let viewController = KKRegistrationViewController.init()
                viewController.verifiedPhoneNumber = self.phoneNumber
                viewController.isFromForgotPassword = self.isFromForgotPassword
                viewController.homeViewController = self.homeViewController
                pvc?.present(viewController, animated: true, completion: nil)
            })
        }
    }
}

extension KKOTPViewController: UITextFieldDelegate, UITextFieldBackspaceDelegate {
    
    @objc func textfieldDidChange(_ sender: UITextField) {
        let string = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (sender == txtOTP5 && string.isEmpty){
            txtOTP5.resignFirstResponder()
            txtOTP4.becomeFirstResponder()
        }else if (sender == txtOTP4 && string.isEmpty){
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
        } else if (sender == txtOTP5 && !string.isEmpty){
            txtOTP5.text = String(string.last!)
            txtOTP5.resignFirstResponder()
        } else if (sender == txtOTP6 && !string.isEmpty){
            txtOTP6.text = String(string.last!)
            txtOTP6.resignFirstResponder()
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
        case txtOTP4:
            txtOTP5.becomeFirstResponder()
        case txtOTP5:
            txtOTP6.becomeFirstResponder()
        default:
            txtOTP6.resignFirstResponder()
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
            } else if (textField == txtOTP4 && currentText != "") {
                txtOTP5.becomeFirstResponder()
            } else if (textField == txtOTP5 && currentText != "") {
                txtOTP6.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == OTPTextField.OTPTextField6.rawValue {
            
            let string = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if string.isEmpty {
                
                otpTextField6NotEmpty = false
            }
            else
            {
                otpTextField6NotEmpty = true
            }
        }
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldDidDelete(textField: UITextField) {
        
        let string = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !otpTextField6NotEmpty {
            
            if string.isEmpty {
                
                if textField.tag != OTPTextField.OTPTextField1.rawValue {
                    
                    let previousTextField: UITextField = view.viewWithTag(textField.tag - 1) as! UITextField
                    previousTextField.text = ""
                    previousTextField.becomeFirstResponder()
                }
            }
        }
        else
        {
            otpTextField6NotEmpty = false
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

