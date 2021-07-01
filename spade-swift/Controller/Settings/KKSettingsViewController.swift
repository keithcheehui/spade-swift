//
//  KKSettingsViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 28/04/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKSettingsViewController: KKBaseViewController {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
   
    @IBOutlet weak var settingContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var settingContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var volumeContentViewMarginLeft: NSLayoutConstraint!

    ///Change Password Subview
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var lblCurrentPassword: UILabel!
    @IBOutlet weak var currentPasswordView: UIView!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblReconfirmPassword: UILabel!
    @IBOutlet weak var reconfirmPasswordView: UIView!
    @IBOutlet weak var txtReconfirmPassword: UITextField!
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordContentViewMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var passwordContentViewMarginRight: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmMarginBottom: NSLayoutConstraint!

    ///Version Subview
    @IBOutlet weak var versionContentView: UIView!
    @IBOutlet weak var lblVersionIOS: UILabel!
    @IBOutlet weak var lblVersionAndroid: UILabel!
    @IBOutlet weak var lblVersionH5: UILabel!
    
    @IBOutlet weak var lblVersionIOSHeight: NSLayoutConstraint!
    @IBOutlet weak var lblVersionIOSMarginLeft: NSLayoutConstraint!
    
    ///Volume Setting Subview
    @IBOutlet weak var volumeContentView: UIView!
    @IBOutlet weak var soundSectionView: UIView!
    @IBOutlet weak var lblSoundSettings: UILabel!
    @IBOutlet weak var lblMusic: UILabel!
    @IBOutlet weak var musicToggleView: UIView!
    @IBOutlet weak var lblMusicToggleStatus: UILabel!
    @IBOutlet weak var imgMusicToggle: UIImageView!

    @IBOutlet weak var lblSound: UILabel!
    @IBOutlet weak var soundToggleView: UIView!
    @IBOutlet weak var lblSoundToggleStatus: UILabel!
    @IBOutlet weak var imgSoundToggle: UIImageView!
    
    @IBOutlet weak var lblMute: UILabel!
    @IBOutlet weak var muteToggleView: UIView!
    @IBOutlet weak var lblMuteToggleStatus: UILabel!
    @IBOutlet weak var imgMuteToggle: UIImageView!

    @IBOutlet weak var toggleMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var toggleMarginRight: NSLayoutConstraint!
    @IBOutlet weak var soundToggleMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var toggleContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var toggleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgToggleWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imgMusicToggleMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var imgSoundToggleMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var imgMuteToggleMarginLeft: NSLayoutConstraint!

    var musicToggleisOn = true
    var soundToggleisOn = true
    var muteToggleisOn = false
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = SettingsSideMenu.volumeSetting.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        appendSideMenuList()
        
        volumeLayout()
        versionLayout()
        changePasswordLayout()
        
        buttonHover(type: selectedViewType)
        
        muteToggleOnChanged()
        musicToggleOnChanged()
        soundToggleOnChanged()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        settingContainerWidth.constant = ConstantSize.ssoPopUpWidth
        settingContainerHeight.constant = ConstantSize.ssoPopUpHeight
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        menuItemMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
    }
    
    func appendSideMenuList() {
        sideMenuTableView.register(UINib(nibName: "KKSideMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.sideMenuTVCIdentifier)

        sideMenuList.removeAll()
        
        var details = SideMenuDetails.init()
        for item in SettingsSideMenu.allCases {
            switch item {
            case .volumeSetting:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "settings_volume_setting")
                details.imgIcon = "ic_volume"
                
            case .changePassword:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "settings_change_password")
                details.imgIcon = "ic_password"
                
            case .version:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "settings_version")
                details.imgIcon = "ic_information"
                
            case .logout:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "settings_logout")
                details.imgIcon = "ic_logout"
            }
           
            sideMenuList.append(details)
        }
        
        sideMenuTableView.reloadData()
    }
    
    func changePasswordLayout(){
        currentPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        reconfirmPasswordView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        passwordContentViewMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)
        passwordContentViewMarginRight.constant = passwordContentViewMarginLeft.constant

        currentPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        newPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        reconfirmPasswordView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        
        containerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        btnConfirmMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 20)
        
        lblCurrentPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_current_password")
        lblNewPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_new_password")
        lblReconfirmPassword.text = KKUtil.languageSelectedStringForKey(key: "settings_reconfirm_password")
        lblNote.text = KKUtil.languageSelectedStringForKey(key: "settings_notes")
        
        lblNote.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 9))
        lblNote.textColor = .spade_orange_FFBA00
        
        lblCurrentPassword.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblNewPassword.font = lblCurrentPassword.font
        lblReconfirmPassword.font = lblCurrentPassword.font
        txtCurrentPassword.font = lblCurrentPassword.font
        txtNewPassword.font = lblCurrentPassword.font
        txtReconfirmPassword.font = lblCurrentPassword.font
        
        txtCurrentPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "settings_current_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtNewPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "settings_new_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtReconfirmPassword.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "settings_reconfirm_password_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        txtCurrentPassword.delegate = self
        txtNewPassword.delegate = self
        txtReconfirmPassword.delegate = self
        
        txtCurrentPassword.returnKeyType = .next
        txtNewPassword.returnKeyType = .next
        txtReconfirmPassword.returnKeyType = .done
    }
    
    func versionLayout(){
        lblVersionIOSHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        lblVersionIOSMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)

        lblVersionIOS.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblVersionAndroid.font = lblVersionIOS.font
        lblVersionH5.font = lblVersionIOS.font
        
        let version = KKSingleton.sharedInstance.appVersion
        if version != nil {
            lblVersionIOS.text = String(format: KKUtil.languageSelectedStringForKey(key: "settings_version_ios"), version!.appVersion!.isEmpty ? "" : version!.appVersion!)
            lblVersionAndroid.text = String(format: KKUtil.languageSelectedStringForKey(key: "settings_version_android"), version!.appVersion!.isEmpty ? "" : version!.appVersion!)
            lblVersionH5.text = String(format: KKUtil.languageSelectedStringForKey(key: "settings_version_h5"), version!.appVersion!.isEmpty ? "" : version!.appVersion!)
        }
    }
    
    func volumeLayout(){
        soundSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        titleViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        volumeContentViewMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)

        lblSoundSettings.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_title")
        lblMusic.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_music")
        lblSound.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_sound")
        
        lblSoundSettings.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblMusic.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblSound.font = lblMusic.font
        
        toggleMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 90)
        toggleMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        soundToggleMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)
        toggleContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: 60)
        toggleViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 17)
        imgToggleWidth.constant = KKUtil.ConvertSizeByDensity(size: 25)
        
        musicToggleView.layer.cornerRadius = toggleViewHeight.constant / 2
        imgMusicToggle.image = UIImage(named: "ic_spade")
        lblMusicToggleStatus.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        
        soundToggleView.layer.cornerRadius = toggleViewHeight.constant / 2
        imgSoundToggle.image = UIImage(named: "ic_spade")
        lblSoundToggleStatus.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        
        muteToggleView.layer.cornerRadius = toggleViewHeight.constant / 2
        imgMuteToggle.image = UIImage(named: "ic_spade")
        lblMuteToggleStatus.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
    }
    
    func musicToggleOnChanged(){
        if (musicToggleisOn) {
            musicToggleView.backgroundColor = .green
            lblMusicToggleStatus.text = "On"
            lblMusicToggleStatus.textAlignment = .left
            lblMusicToggleStatus.textColor = .spade_black_000000
            imgMusicToggleMarginLeft.constant = toggleContainerWidth.constant - imgToggleWidth.constant
        } else {
            musicToggleView.backgroundColor = .darkGray
            lblMusicToggleStatus.text = "Off"
            lblMusicToggleStatus.textAlignment = .right
            lblMusicToggleStatus.textColor = .spade_white_FFFFFF
            imgMusicToggleMarginLeft.constant = 0
        }
    }
    
    func soundToggleOnChanged(){
        if (soundToggleisOn) {
            soundToggleView.backgroundColor = .green
            lblSoundToggleStatus.text = "On"
            lblSoundToggleStatus.textAlignment = .left
            lblSoundToggleStatus.textColor = .spade_black_000000
            imgSoundToggleMarginLeft.constant = toggleContainerWidth.constant - imgToggleWidth.constant
        } else {
            soundToggleView.backgroundColor = .darkGray
            lblSoundToggleStatus.text = "Off"
            lblSoundToggleStatus.textAlignment = .right
            lblSoundToggleStatus.textColor = .spade_white_FFFFFF
            imgSoundToggleMarginLeft.constant = 0
        }
    }
    
    func muteToggleOnChanged(){
        if (muteToggleisOn) {
            muteToggleView.backgroundColor = .green
            lblMuteToggleStatus.text = "On"
            lblMuteToggleStatus.textAlignment = .left
            lblMuteToggleStatus.textColor = .spade_black_000000
            imgMuteToggleMarginLeft.constant = toggleContainerWidth.constant - imgToggleWidth.constant
        } else {
            muteToggleView.backgroundColor = .darkGray
            lblMuteToggleStatus.text = "Off"
            lblMuteToggleStatus.textAlignment = .right
            lblMuteToggleStatus.textColor = .spade_white_FFFFFF
            imgMuteToggleMarginLeft.constant = 0
        }
    }
    
    @IBAction func btnMusicToggleDidPressed(){
        musicToggleisOn = !musicToggleisOn
        
        if (!musicToggleisOn && !soundToggleisOn) {
            muteToggleisOn = true
        } else {
            muteToggleisOn = false
        }

        musicToggleOnChanged()
        muteToggleOnChanged()
    }
    
    @IBAction func btnSoundToggleDidPressed(){
        soundToggleisOn = !soundToggleisOn
        if (!musicToggleisOn && !soundToggleisOn) {
            muteToggleisOn = true
        } else {
            muteToggleisOn = false
        }
        
        soundToggleOnChanged()
        muteToggleOnChanged()
    }
    
    @IBAction func btnMuteToggleDidPressed(){
        muteToggleisOn = !muteToggleisOn
        
        if (muteToggleisOn) {
            musicToggleisOn = false
            soundToggleisOn = false
        } else {
            musicToggleisOn = true
            soundToggleisOn = true
        }
        
        muteToggleOnChanged()
        musicToggleOnChanged()
        soundToggleOnChanged()
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnConfirmChangePasswordDidPressed(){
        self.view.endEditing(true)

        if txtCurrentPassword.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_required_desc"))
            return
        }
        
        if txtReconfirmPassword.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_confirm_required_desc"))
            return
        }
        
        if txtReconfirmPassword.text != txtNewPassword.text {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_password_not_match_desc"))
            return
        }
        
        userChangePassword()
    }
    
    func buttonHover(type: Int){
        if (type == SettingsSideMenu.logout.rawValue){
            return
        }
        
        volumeContentView.isHidden = true
        versionContentView.isHidden = true
        passwordContentView.isHidden = true

        switch type {
        case SettingsSideMenu.changePassword.rawValue:
            passwordContentView.isHidden = false
            break;
        case SettingsSideMenu.version.rawValue:
            versionContentView.isHidden = false
            break;
        default:
            volumeContentView.isHidden = false
            break;
        }
    }
    
    //MARK:- API Calls
    
    @objc func userChangePassword() {
        
        self.showAnimatedLoader()
        
        KKApiClient.changePassword(currentPwd: txtCurrentPassword.text!, newPwd: txtReconfirmPassword.text!).execute { userCredential in
            self.hideAnimatedLoader()
            KeychainSwift().set(self.txtCurrentPassword.text!, forKey: CacheKey.secret)
            
            self.txtCurrentPassword.text = ""
            self.txtNewPassword.text = ""
            self.txtReconfirmPassword.text = ""
            self.showAlertView(type: .Success, alertMessage: userCredential.message ?? "")

        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    //MARK:- OTP and Registration
    
    @objc func closeSettingsAndOpenDialog() {

        weak var pvc = self.presentingViewController

        UIView.animate(withDuration: 0.25) {
            
            self.view.backgroundColor = UIColor(white: 0, alpha: 0)
            
        } completion: { complete in
            
            self.dismiss(animated: true, completion: {
                let viewController = KKDialogAlertViewController.init()
                viewController.alertType = .Logout
                pvc?.present(viewController, animated: true, completion: nil)
            })
        }
    }
}

extension KKSettingsViewController: UITextFieldDelegate {
    
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

extension KKSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.sideMenuTVCIdentifier, for: indexPath) as? KKSideMenuTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        if (selectedViewType == indexPath.row){
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        cell.imgIcon.image = UIImage(named: sideMenuList[indexPath.row].imgIcon)
        cell.lblName.text = sideMenuList[indexPath.row].title
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == SettingsSideMenu.logout.rawValue){
            closeSettingsAndOpenDialog()
            return
        } else {
            selectedViewType = indexPath.row
            buttonHover(type: selectedViewType)
            sideMenuTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}
