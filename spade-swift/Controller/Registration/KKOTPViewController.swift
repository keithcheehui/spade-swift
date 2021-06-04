//
//  KKOTPViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

class KKOTPViewController: KKBaseViewController, UITextFieldDelegate {
    
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
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var otpView2: UIView!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var otpView3: UIView!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var otpView4: UIView!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var lblNoReceive: UILabel!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var lblSend: UILabel!
    @IBOutlet weak var btnResend: UIButton!

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
        lblNoReceive.font = lblMobileNumber.font
        lblResend.font = lblMobileNumber.font
        lblSend.font = UIFont.systemFont(ofSize: ConstantSize.ssoLabelSmallFont)

        txtMobile.delegate = self
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        
        txtMobile.returnKeyType = .next
        txtOTP1.returnKeyType = .next
        txtOTP2.returnKeyType = .next
        txtOTP3.returnKeyType = .next
        txtOTP4.returnKeyType = .done
        
        txtCountryCode.isEnabled = false
    }

    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSendDidPressed(){

    }
    
    @IBAction func btnResendDidPressed(){

    }
    
    @IBAction func btnConfirmDidPressed(){
        self.closeOTPAndOpenRegistration()
    }
    
    ///TextField Delegate
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
        if (range.location > 0 && textField == txtOTP4) {
            textField.text?.removeLast()
        }
        return true
    }
}
