//
//  KKUserInfoViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 08/05/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKUserInfoViewController: KKBaseViewController {
    
    @IBOutlet weak var levelSectionView: UIView!
    @IBOutlet weak var lblLevelSection: UILabel!
    
    @IBOutlet weak var lblCurrentMembership: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCurrentRank: UIImageView!
    @IBOutlet weak var imgNextRank: UIImageView!
    @IBOutlet weak var rankProgressBar: UIProgressView!

    @IBOutlet weak var basicSectionView: UIView!
    @IBOutlet weak var lblBasicSection: UILabel!
    @IBOutlet weak var imgEdit: UIImageView!
    
    @IBOutlet weak var lblTitleAccount: UILabel!
    @IBOutlet weak var lblTitleUsername: UILabel!
    @IBOutlet weak var lblTitleBirthday: UILabel!
    @IBOutlet weak var lblTitleID: UILabel!
    @IBOutlet weak var lblTitleGender: UILabel!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtAccountView: UIView!
    @IBOutlet weak var txtUsernameView: UIView!
    @IBOutlet weak var txtBirthdayView: UIView!
    @IBOutlet weak var txtIDView: UIView!
    @IBOutlet weak var txtGenderView: UIView!
    
    @IBOutlet weak var lblTitleEmail: UILabel!
    @IBOutlet weak var lblTtitlePhone: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmailView: UIView!
    @IBOutlet weak var txtPhoneView: UIView!
    
    @IBOutlet weak var sectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sectionIconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    @IBOutlet weak var rankContainerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var viewMarginRight: NSLayoutConstraint!
    @IBOutlet weak var textFieldMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var textFieldMarginRight: NSLayoutConstraint!
    
    var isEditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        defaultLayoutValue()

        isEditMode = false
        displayView()
    }
    
    func initialLayout(){
        levelSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        basicSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)

        sectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        sectionIconWidth.constant = KKUtil.ConvertSizeByDensity(size: 12)
        
        imgProfileWidth.constant = KKUtil.ConvertSizeByDensity(size: 60)
        rankContainerViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        
        viewMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 16 : 24)
        viewMarginRight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 8 : 16)
        textFieldMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 15 : 30)
        textFieldMarginRight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 15 : 30)

        lblLevelSection.text = KKUtil.languageSelectedStringForKey(key: "user_info_level_privilege")
        lblBasicSection.text = KKUtil.languageSelectedStringForKey(key: "user_info_basic_information")
        
        lblTitleAccount.text = KKUtil.languageSelectedStringForKey(key: "user_info_account")
        lblTitleUsername.text = KKUtil.languageSelectedStringForKey(key: "user_info_username")
        lblTitleBirthday.text = KKUtil.languageSelectedStringForKey(key: "user_info_birthday")
        lblTitleID.text = KKUtil.languageSelectedStringForKey(key: "user_info_id")
        lblTitleGender.text = KKUtil.languageSelectedStringForKey(key: "user_info_gender")
        lblTitleEmail.text = KKUtil.languageSelectedStringForKey(key: "user_info_email")
        lblTtitlePhone.text = KKUtil.languageSelectedStringForKey(key: "user_info_phone")
        
        lblLevelSection.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
        lblBasicSection.font = lblLevelSection.font

        lblCurrentMembership.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblAccountNumber.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblProgress.font = lblAccountNumber.font
        
        lblTitleAccount.font = lblAccountNumber.font
        lblTitleUsername.font = lblAccountNumber.font
        lblTitleBirthday.font = lblAccountNumber.font
        lblTitleID.font = lblAccountNumber.font
        lblTitleGender.font = lblAccountNumber.font
        lblTitleEmail.font = lblAccountNumber.font
        lblTtitlePhone.font = lblAccountNumber.font
        
        txtAccount.font = lblAccountNumber.font
        txtUsername.font = lblAccountNumber.font
        txtBirthday.font = lblAccountNumber.font
        txtID.font = lblAccountNumber.font
        txtGender.font = lblAccountNumber.font
        txtEmail.font = lblAccountNumber.font
        txtPhone.font = lblAccountNumber.font
        
        txtBirthday.delegate = self
        txtGender.delegate = self
        txtEmail.delegate = self
        txtPhone.delegate = self

        txtBirthday.returnKeyType = .next
        txtGender.returnKeyType = .next
        txtEmail.returnKeyType = .done
        
        txtBirthdayView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        txtGenderView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        txtEmailView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        txtPhoneView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        txtAccountView.backgroundColor = UIColor(white: 0, alpha: 0)
        txtUsernameView.backgroundColor = UIColor(white: 0, alpha: 0)
        txtIDView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        txtAccount.isUserInteractionEnabled = false
        txtUsername.isUserInteractionEnabled = false
        txtID.isUserInteractionEnabled = false
    }
    
    func defaultLayoutValue(){
        if KKUtil.isUserLogin(), let userProfile = KKUtil.decodeUserProfileFromCache() {
            if let code = userProfile.code {
                lblAccountNumber.text = code
                txtAccount.text = code
            }
            
            if let username = userProfile.username {
                txtUsername.text = username
            }
            
            if let gender = userProfile.gender {
                txtGender.text = gender
            }
            
            if let id = userProfile.id {
                txtID.text = String(id)
            }
            
            if let phone = userProfile.phoneNo {
                txtPhone.text = String(format: "+\(phone)")
            }
            
            if let dob = userProfile.dob {
                txtBirthday.text = dob
            }
            
            if let email = userProfile.email {
                txtEmail.text = email
            }
            
            if let tier = userProfile.tier {
                if let currentTier = tier.currentLevelName {
                    lblCurrentMembership.text = String(format: KKUtil.languageSelectedStringForKey(key: "user_info_current_membership"), currentTier)
                }
                if let balance = tier.balance, let next = tier.totalAmountToNextLevel, let currency = userProfile.currencyCode {
                    lblProgress.text = String(format: "%@%@ / %@%@", currency, balance, currency, next)
                    
                    let progress = Float(balance)!/Float(next)!
                    rankProgressBar.setProgress(progress, animated: false)
                }
                if let imgCurrent = tier.currentLevelImg, let imgNext = tier.nextLevelImg {
                    imgCurrentRank.setUpImage(with: imgCurrent)
                    imgNextRank.setUpImage(with: imgNext)
                }
            }
        } else {
            lblAccountNumber.text = ""
            lblCurrentMembership.text = String(format: KKUtil.languageSelectedStringForKey(key: "user_info_current_membership"), "")

            txtAccount.text = ""
            txtUsername.text = ""
            txtGender.text = ""
            txtID.text = ""
            txtPhone.text = ""
            txtBirthday.text = ""
            txtEmail.text = ""
            lblProgress.text = ""
        }
    }
    
    func displayView(){
        imgEdit.image = UIImage(named: "ic_edit")
        txtBirthdayView.backgroundColor = UIColor(white: 0, alpha: 0)
        txtGenderView.backgroundColor = UIColor(white: 0, alpha: 0)
        txtEmailView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        txtBirthday.isUserInteractionEnabled = false
        txtGender.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
    }
    
    func editView(){
        imgEdit.image = UIImage(named: "ic_save")
        txtBirthdayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        txtGenderView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        txtEmailView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        txtBirthday.isUserInteractionEnabled = true
        txtGender.isUserInteractionEnabled = true
        txtEmail.isUserInteractionEnabled = true
        
        txtBirthday.inputView = datePickerView
        txtBirthday.inputAccessoryView = pickerToolBarView
        
        txtGender.inputView = pickerView
        txtGender.inputAccessoryView = pickerToolBarView
    }
    
    
    ///Button Actions
    @IBAction func btnAvatarDidPressed(){
        self.present(KKAvatarViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnMyVipLevelDidPressed(){
        
    }
    
    @IBAction func btnEditDidPressed(){
        if !KKUtil.isUserLogin() {
            return
        }
        
        if (isEditMode){
            self.view.endEditing(true)
            
            if txtEmail.text!.count == 0 {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_email_empty"))
                return
            }
            
            if txtBirthday.text!.count == 0 {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_birthday_empty"))
                return
            }
            
            if txtGender.text!.count == 0 {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_gender_empty"))
                return
            }
            
            if KKUtil.isValidEmail(testStr: txtEmail.text!) {
                editPersonalDataAPI()
            } else {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_email_invalid"))
            }
        }else{
            isEditMode = true
            editView()
        }
    }
    
    func editPersonalDataAPI(){
        showAnimatedLoader()

        KKApiClient.updateUserProfile(email: txtEmail.text!, gender: txtGender.text!, birthday: txtBirthday.text!).execute { response in
            self.hideAnimatedLoader()
            
            if var userProfile = KKUtil.decodeUserProfileFromCache() {
                userProfile.email = self.txtEmail.text!
                userProfile.gender = self.txtGender.text!
                userProfile.dob = self.txtBirthday.text!

                KKUtil.encodeUserProfile(object: userProfile)
                self.isEditMode = false
                self.displayView()
            }
            
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
}

extension KKUserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtGender {
            showPickerView(optionList: pickerGenderArray)
            pickerTextField = textField
            
            //TODO: KEITH, add the subclass, and add disable copy paste pop up
            textField.tintColor = UIColor.clear
        } else if textField == txtBirthday {
            showDatePickerView(showTime: false)
            datePickerTextField = textField
            
            //TODO: KEITH, add the subclass, and add disable copy paste pop up
            textField.tintColor = UIColor.clear
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
