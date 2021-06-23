//
//  KKSettingsViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 28/04/2021.
//

import Foundation
import UIKit

class KKSettingsViewController: KKBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblVolumeSetting: UILabel!
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblLogout: UILabel!
    @IBOutlet weak var imgHoverVolumeSetting: UIImageView!
    @IBOutlet weak var imgHoverChangePassword: UIImageView!
    @IBOutlet weak var imgHoverVersion: UIImageView!
    @IBOutlet weak var imgHoverLogout: UIImageView!

    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!

    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!

    ///Change Password Subview
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var lblCurrentPassword: UILabel!
    @IBOutlet weak var currentPasswordView: UIView!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var lblReconfirmPassword: UILabel!
    @IBOutlet weak var reconfirmPasswordView: UIView!
    @IBOutlet weak var txtReconfirmPassword: UITextField!
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCurrentPasswordWidth: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmWidth: NSLayoutConstraint!
    
    ///Version Subview
    @IBOutlet weak var versionContentView: UIView!
    @IBOutlet weak var lblVersionIOS: UILabel!
    @IBOutlet weak var lblVersionAndroid: UILabel!
    @IBOutlet weak var lblVersionH5: UILabel!
    
    @IBOutlet weak var lblVersionIOSHeight: NSLayoutConstraint!
    
    ///Volume Setting Subview
    @IBOutlet weak var volumeContentView: UIView!
    @IBOutlet weak var soundSectionView: UIView!
    @IBOutlet weak var lblSoundSettings: UILabel!
    @IBOutlet weak var lblMusic: UILabel!
    @IBOutlet weak var lblSound: UILabel!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var soundSlider: UISlider!
    
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    
    enum viewType: Int {
        case volumeSetting = 0
        case changePassword = 1
        case version = 2
        case logout = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        volumeLayout()
        versionLayout()
        changePasswordLayout()
        
        buttonHover(type: viewType.volumeSetting.rawValue)
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        menuItemMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        
        lblVolumeSetting.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_setting")
        lblChangePassword.text = KKUtil.languageSelectedStringForKey(key: "settings_change_password")
        lblVersion.text = KKUtil.languageSelectedStringForKey(key: "settings_version")
        lblLogout.text = KKUtil.languageSelectedStringForKey(key: "settings_logout")
        
        lblVolumeSetting.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblChangePassword.font = lblVolumeSetting.font
        lblVersion.font = lblVolumeSetting.font
        lblLogout.font = lblVolumeSetting.font
    }

    func changePasswordLayout(){
        currentPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        reconfirmPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        currentPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        newPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        reconfirmPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        containerHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        lblCurrentPasswordWidth.constant = KKUtil.ConvertSizeByDensity(size: 100)
        btnConfirmWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        
        lblCurrentPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_current_password")
        lblNewPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_new_password")
        lblReconfirmPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_reconfirm_password")
        
        lblCurrentPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblNewPassword.font = lblCurrentPassword.font
        lblReconfirmPassword.font = lblCurrentPassword.font
        txtCurrentPassword.font = lblCurrentPassword.font
        txtNewPassword.font = lblCurrentPassword.font
        txtReconfirmPassword.font = lblCurrentPassword.font
        
        txtCurrentPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtNewPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtReconfirmPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "register_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        txtCurrentPassword.delegate = self
        txtNewPassword.delegate = self
        txtReconfirmPassword.delegate = self
        
        txtCurrentPassword.returnKeyType = .next
        txtNewPassword.returnKeyType = .next
        txtReconfirmPassword.returnKeyType = .done
    }
    
    func versionLayout(){
        lblVersionIOSHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        
        lblVersionIOS.text = KKUtil.languageSelectedStringForKey(key: "settings_version_ios")
        lblVersionAndroid.text = KKUtil.languageSelectedStringForKey(key: "settings_version_android")
        lblVersionH5.text = KKUtil.languageSelectedStringForKey(key: "settings_version_h5")
        
        lblVersionIOS.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblVersionAndroid.font = lblVersionIOS.font
        lblVersionH5.font = lblVersionIOS.font
    }
    
    func volumeLayout(){
        soundSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)

        lblSoundSettings.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_title")
        lblMusic.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_music")
        lblSound.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_sound")
        
        lblSoundSettings.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblMusic.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblSound.font = lblMusic.font
        
        musicSlider.setThumbImage(UIImage(named: "ic_spade"), for: .normal)
        soundSlider.setThumbImage(UIImage(named: "ic_spade"), for: .normal)
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnVolumeSettingDidPressed(){
        buttonHover(type: viewType.volumeSetting.rawValue)
    }
    
    @IBAction func btnChangePasswordDidPressed(){
        buttonHover(type: viewType.changePassword.rawValue)
    }

    @IBAction func btnVersionDidPressed(){
        buttonHover(type: viewType.version.rawValue)
    }
    
    @IBAction func btnLogoutDidPressed(){
        buttonHover(type: viewType.logout.rawValue)
    }
    
    @IBAction func btnConfirmChangePasswordDidPressed(){

    }
    
    func buttonHover(image: UIImageView){
        imgHoverVolumeSetting.isHidden = true
        imgHoverChangePassword.isHidden = true
        imgHoverVersion.isHidden = true
        imgHoverLogout.isHidden = true
        
        image.isHidden = false
    }
    
    func buttonHover(type: Int){
        if (type == viewType.logout.rawValue){
            KKUtil.logOutUser()
            return
        }
        
        imgHoverVolumeSetting.isHidden = true
        imgHoverChangePassword.isHidden = true
        imgHoverVersion.isHidden = true
        imgHoverLogout.isHidden = true
                
        volumeContentView.isHidden = true
        versionContentView.isHidden = true
        passwordContentView.isHidden = true

        switch type {
        case viewType.changePassword.rawValue:
            imgHoverChangePassword.isHidden = false
            passwordContentView.isHidden = false
            break;
        case viewType.version.rawValue:
            imgHoverVersion.isHidden = false
            versionContentView.isHidden = false
            break;
        default:
            imgHoverVolumeSetting.isHidden = false
            volumeContentView.isHidden = false
            break;
        }
    }
    
    ///TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case txtCurrentPassword:
            txtNewPassword.becomeFirstResponder()
        case txtNewPassword:
            txtReconfirmPassword.becomeFirstResponder()
        default:
            txtReconfirmPassword.resignFirstResponder()
        }
    }
}

