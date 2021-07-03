//
//  KKHeaderBar.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 03/07/2021.
//
import Foundation
import UIKit

final class KKHeaderBar: UIView {
        
    @IBOutlet private var view: UIView!

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    
    @IBOutlet weak var moneyContainer: UIView!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var refreshWalletIcon: UIImageView!
    @IBOutlet weak var refreshWalletBtn: UIButton!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    @IBOutlet weak var moneyContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCoinWidth: NSLayoutConstraint!
    @IBOutlet weak var lblMoneyMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblMoneyMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgRefreshWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed("KKHeaderBar", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
        
        imgProfileWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        moneyContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCoinWidth.constant = KKUtil.ConvertSizeByDensity(size: 35)
        lblMoneyMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 5)
        lblMoneyMarginRight.constant = lblMoneyMarginLeft.constant
        imgRefreshWidth.constant = KKUtil.ConvertSizeByDensity(size: 18)
        
        lblProfileName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 13))
        lblMoney.font = lblProfileName.font
        lblProfileName.textColor = .spade_white_FFFFFF
        lblMoney.textColor = lblProfileName.textColor

        moneyContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        moneyContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)
    }
    
    func setupHeaderData(profileData: KKUserProfileDetails?) {
        if let avatar = profileData?.avatarId {
            let avatarString = "ic_avatar_\(avatar)"
            imgProfile.image = UIImage(named: avatarString)
        } else {
            imgProfile.image = UIImage(named: "img_placeholder")
        }
        
        if let code = profileData?.code {
            lblProfileName.text = code
        } else {
            lblProfileName.text = ""
        }
        
        if let wallet = profileData?.walletBalance {
            lblMoney.text = KKUtil.addCurrencyFormatWithFloat(value: wallet)
        } else {
            lblMoney.text = KKUtil.addCurrencyFormatWithFloat(value: 0.00)
        }
    }
    
    @IBAction func btnRefreshDidPressed(){
        self.getUserLatestWallet()
    }
    
    //MARK:- API Calls
    
    func getUserLatestWallet() {
        
        refreshWalletIcon.startRotate()
        refreshWalletBtn.isEnabled = false
        
        if UserDefaults.standard.bool(forKey: CacheKey.loginStatus) {
            KKApiClient.getUserLatestWallet().execute { userWalletResponse in
                
                self.refreshWalletIcon.removeRotate()
                self.refreshWalletBtn.isEnabled = true
                
                if var userProfile = KKUtil.decodeUserProfileFromCache(), let userInfo = userWalletResponse.results {
                    userProfile.walletBalance = userInfo.walletBalance!
                    
                    KKUtil.encodeUserProfile(object: userProfile)
                }
                
                if let userWalletResult = userWalletResponse.results {
                    self.lblMoney.text = KKUtil.addCurrencyFormatWithFloat(value: userWalletResult.walletBalance!)
                }
                
            } onFailure: { errorMessage in
                
                self.refreshWalletIcon.removeRotate()
                self.refreshWalletBtn.isEnabled = true
            }
        } else {
            self.refreshWalletIcon.removeRotate()
            self.refreshWalletBtn.isEnabled = true
        }
    }
}
