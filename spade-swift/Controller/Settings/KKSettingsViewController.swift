//
//  KKSettingsViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 28/04/2021.
//

import Foundation
import UIKit

class KKSettingsViewController: KKBaseViewController {
    
    @IBOutlet weak var lblVolumeSetting: UILabel!
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblDeviceBinding: UILabel!
    @IBOutlet weak var imgHoverVolumeSetting: UIImageView!
    @IBOutlet weak var imgHoverChangePassword: UIImageView!
    @IBOutlet weak var imgHoverVersion: UIImageView!
    @IBOutlet weak var imgHoverDeviceBinding: UIImageView!
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        sideMenuWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        imgMenuIconWidth.constant = KKUtil.ConvertSizeByDensity(size: 25)
        menuItemHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        separatorHeight.constant = KKUtil.ConvertSizeByDensity(size: 10)
        
        lblVolumeSetting.text = KKUtil.languageSelectedStringForKey(key: "settings_volume_setting")
        lblChangePassword.text = KKUtil.languageSelectedStringForKey(key: "settings_change_password")
        lblVersion.text = KKUtil.languageSelectedStringForKey(key: "settings_version")
        lblDeviceBinding.text = KKUtil.languageSelectedStringForKey(key: "settings_device_binding")
        
        lblVolumeSetting.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblChangePassword.font = lblVolumeSetting.font
        lblVersion.font = lblVolumeSetting.font
        lblDeviceBinding.font = lblVolumeSetting.font

        buttonHover(image: imgHoverVolumeSetting)
        
    }

    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnVolumeSettingDidPressed(){
        buttonHover(image: imgHoverVolumeSetting)
    }
    
    @IBAction func btnChangePasswordDidPressed(){
        buttonHover(image: imgHoverChangePassword)
    }

    @IBAction func btnVersionDidPressed(){
        buttonHover(image: imgHoverVersion)
    }
    
    @IBAction func btnDeviceBindingDidPressed(){
        buttonHover(image: imgHoverDeviceBinding)
    }
    
    func buttonHover(image: UIImageView){
        imgHoverVolumeSetting.isHidden = true
        imgHoverChangePassword.isHidden = true
        imgHoverVersion.isHidden = true
        imgHoverDeviceBinding.isHidden = true
        
        image.isHidden = false
    }
}

