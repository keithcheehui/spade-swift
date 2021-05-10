//
//  KKHomeViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/04/2021.
//

import Foundation
import UIKit

class KKHomeViewController: KKBaseViewController {
    
    @IBOutlet weak var imgBG: UIImageView!
    
    ///Top Container
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var copyContainer: UIView!
    @IBOutlet weak var lblCopy: UILabel!
    @IBOutlet weak var lblVip: UILabel!
    @IBOutlet weak var expBar: UIProgressView!
    @IBOutlet weak var moneyContainer: UIView!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblMission: UILabel!
    @IBOutlet weak var lblBonus: UILabel!
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var announcementContainer: UIView!
    @IBOutlet weak var lblAnnouncement: UILabel!
    
    ///Content
    @IBOutlet weak var menuContainer: UIView!
    
    
    ///Footer Container
    @IBOutlet weak var lblAffiliate: UILabel!
    @IBOutlet weak var lblRebate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblSupport: UILabel!
    @IBOutlet weak var lblMore: UILabel!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    @IBOutlet weak var lblProfileNameWidth: NSLayoutConstraint!
    @IBOutlet weak var lblCopyWidth: NSLayoutConstraint!
    @IBOutlet weak var expBarHeight: NSLayoutConstraint!
    @IBOutlet weak var moneyContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var moneyContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCoinWidth: NSLayoutConstraint!
    @IBOutlet weak var imgRefreshWidth: NSLayoutConstraint!
    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var missionContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var announcementContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var announcementContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgAnnouncementHeight: NSLayoutConstraint!
    @IBOutlet weak var footerContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var footerButtonContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgAffiliateWidth: NSLayoutConstraint!
    @IBOutlet weak var btnWithdrawWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 70)
        imgProfileWidth.constant = KKUtil.ConvertSizeByDensity(size: 50)
        lblProfileNameWidth.constant = KKUtil.ConvertSizeByDensity(size: 70)
        lblCopyWidth.constant = KKUtil.ConvertSizeByDensity(size: 60)
        expBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 4)
        moneyContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: 180)
        moneyContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCoinWidth.constant = KKUtil.ConvertSizeByDensity(size: 40)
        imgRefreshWidth.constant = KKUtil.ConvertSizeByDensity(size: 18)
        missionContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 45 : 40)
        announcementContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 350 : 400)
        announcementContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgAnnouncementHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        footerContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        footerButtonContainerMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgAffiliateWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 18 : 22)
        btnWithdrawWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 110 : 130)

        imgBG.image = UIImage(named: "bg_main")
        imgProfile.image = UIImage(named: "ic_profile")

        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "home_copy_id")
        lblMission.text = KKUtil.languageSelectedStringForKey(key: "home_mission")
        lblBonus.text = KKUtil.languageSelectedStringForKey(key: "home_bonus")
        lblSettings.text = KKUtil.languageSelectedStringForKey(key: "home_settings")
        lblAffiliate.text = KKUtil.languageSelectedStringForKey(key: "home_affiliates")
        lblRebate.text = KKUtil.languageSelectedStringForKey(key: "home_rebate")
        lblMessage.text = KKUtil.languageSelectedStringForKey(key: "home_message")
        lblSupport.text = KKUtil.languageSelectedStringForKey(key: "home_support")
        lblMore.text = KKUtil.languageSelectedStringForKey(key: "home_more")
        
        lblProfileName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblVip.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        lblAnnouncement.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblCopy.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        lblMoney.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 13))
        lblMission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBonus.font = lblMission.font
        lblSettings.font = lblMission.font
        lblLanguage.font = lblMission.font
        lblAffiliate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblRebate.font = lblAffiliate.font
        lblMessage.font = lblAffiliate.font
        lblSupport.font = lblAffiliate.font
        lblMore.font = lblAffiliate.font

        lblProfileName.text = "80808080"
        lblVip.text = "VIP 1"
        lblMoney.text = "999,999,999"
        lblAnnouncement.text = "Welcome Welcome Welcome Welcome Welcome"
        lblLanguage.text = "English"

        
        copyContainer.backgroundColor = UIColor(white: 0, alpha: 0.8)
        copyContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)
        copyContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1.0)
        copyContainer.layer.borderColor = UIColor.spade_white_FFFFFF.cgColor
        moneyContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        moneyContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)
        announcementContainer.backgroundColor = UIColor(white: 0, alpha: 0.5)
        announcementContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)

        setGradientBackground(colorTop: UIColor(white: 0, alpha: 0.0), colorCenter: UIColor(white: 0, alpha: 0.5), colorBottom: UIColor(white: 0, alpha: 0.0), view: menuContainer)

        let ratio = Float(10) / Float(10)
        expBar.progress = Float(ratio)
    }
    
    func setGradientBackground(colorTop: UIColor, colorCenter: UIColor, colorBottom: UIColor, view: UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorCenter.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    ///Button Actions
    @IBAction func btnProfileDidPressed(){
        self.navigationController?.pushViewController(KKPersonalViewController(), animated: true)
    }
    
    @IBAction func btnCopyDidPressed(){
        
    }

    @IBAction func btnRefreshDidPressed(){
        
    }
    
    @IBAction func btnMissionDidPressed(){
        
    }
    
    @IBAction func btnBonusDidPressed(){
        
    }
    
    @IBAction func btnSettingsDidPressed(){
        self.present(KKSettingsViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnLanguageDidPressed(){
        
    }
    
    @IBAction func btnAnnouncementDidPressed(){
        self.present(KKAnnouncementViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnAffiliatesDidPressed(){
        self.navigationController?.pushViewController(KKAffiliateViewController(), animated: true)
    }
    
    @IBAction func btnRebateDidPressed(){
        self.navigationController?.pushViewController(KKRebateViewController(), animated: true)
    }
    
    @IBAction func btnMessageDidPressed(){
        self.navigationController?.pushViewController(KKMessageViewController(), animated: true)
    }
    
    @IBAction func btnSupportDidPressed(){
        self.navigationController?.pushViewController(KKSupportViewController(), animated: true)
    }
    
    @IBAction func btnMoreDidPressed(){
        
    }
    
    @IBAction func btnDepositDidPressed(){
        self.navigationController?.pushViewController(KKDepositViewController(), animated: true)
    }
    
    @IBAction func btnWithdrawDidPressed(){
        self.navigationController?.pushViewController(KKWithdrawViewController(), animated: true)
    }
}
