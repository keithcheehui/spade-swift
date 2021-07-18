//
//  KKSplashScreenViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 27/04/2021.
//

import UIKit
import KeychainSwift
import Kingfisher

class KKSplashScreenViewController: KKBaseViewController {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var loadingBar: UIView!
    @IBOutlet weak var imgBgloadingBar: UIImageView!
    @IBOutlet weak var lblLoading: UILabel!
    
    @IBOutlet weak var imgLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var loadingBarHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblLoadingMarginBottom: NSLayoutConstraint!
    
    var imgProgress: UIImageView!
    var progressValue: CGFloat = 0
    var stopProgress: CGFloat = 0.7
    var timerStop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()

        initialLayout()
        drawLoadingProgress()
                
        if KKUtil.isConnectedToInternet() {
            if (KeychainSwift().get(CacheKey.username) == nil || KeychainSwift().get(CacheKey.secret) == nil) {
                KKUtil.cleanSet()
                self.getAppVersionAPI()
            } else if (KeychainSwift().get(CacheKey.username)!.isEmpty || KeychainSwift().get(CacheKey.secret)!.isEmpty) {
                KKUtil.cleanSet()
                self.getAppVersionAPI()
            } else {
                self.loginAPI(username: KeychainSwift().get(CacheKey.username)!, password: KeychainSwift().get(CacheKey.secret)!)
            }
        } else {
            self.showAlertView(type: .Error, alertMessage: "error_internet_connection_desc")
            self.appVersionApiFailed()
        }
    }

    func initialLayout(){
        imgLogoWidth.constant = KKUtil.ConvertSizeByDensity(size: 480)
        loadingBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        loadingBarMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 130)
        loadingBarMarginRight.constant = loadingBarMarginLeft.constant
        lblLoadingMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        
        if (ScreenSize.maxLength < 812.0) {
            imgBG.image = UIImage(named: "bg_sso")
        } else {
            imgBG.image = UIImage(named: "bg_sso2")
        }
    }

    func drawLoadingProgress(){
        loadingBar.layer.cornerRadius = loadingBar.frame.size.height/2 - 2
        loadingBar.clipsToBounds = true
        
        imgProgress = UIImageView.init()
        imgProgress.image = UIImage(named: "bg_loading_bar")
        imgProgress.contentMode = .scaleToFill
        imgProgress.clipsToBounds = true
        imgProgress.frame = CGRect(x: 1, y: 0.25, width: 0, height: loadingBar.bounds.height - 6)
        loadingBar.addSubview(imgProgress)
        
        self.perform(#selector(updateProgress), with: nil, afterDelay: 0.1)
    }
    
    //MARK:- Animation
    
    @objc func updateProgress() {
        progressValue = progressValue + 0.01
        self.imgProgress.frame.size.width = self.loadingBar.bounds.width * progressValue

        if progressValue <= stopProgress {
            timerStop = false
            lblLoading.text = String.init(format: "loading %.0f%%...", progressValue*100)
            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.03)
        } else if stopProgress >= 1 {
            timerStop = true
            lblLoading.text = "loading 100%..."
            if KKUtil.isUserLogin() {
                KKUtil.redirectToHome()
            } else {
                self.present(KKSelectCountryViewController(), animated: false, completion: nil)
            }
        } else {
            timerStop = true
        }
    }
    
    //MARK:- API Calls
    
    func loginAPI(username: String, password: String) {
        KKApiClient.login(username: username, password: password).execute { userCredential in
            KKTokenManager.setUserCredential(userCredential: userCredential)
            UserDefaults.standard.set(true, forKey: CacheKey.loginStatus)
            UserDefaults.standard.synchronize()
            self.deviceRegister()
        } onFailure: { errorMessage in
            KKUtil.cleanSet()
            self.getAppVersionAPI()
        }
    }
    
    @objc func deviceRegister() {
        
        KKApiClient.deviceRegister().execute { generalResponse in
            
            self.getMemberLandingAPI()
            
        } onFailure: { errorMessage in
            
            self.getMemberLandingAPI()
        }
    }
    
    func getAppVersionAPI() {
        KKApiClient.appVersion().execute { appVersionResponse in
            guard let appVersionDetails = appVersionResponse.results else { return }
            KKUtil.encodeAppVersion(object: appVersionDetails)
            KKSingleton.sharedInstance.countryArray = appVersionDetails.countries!
            KKSingleton.sharedInstance.languageArray = appVersionDetails.languages!
            KKSingleton.sharedInstance.appVersion = appVersionDetails.appVersion!

            self.stopProgress = 1
            if self.timerStop {
                self.perform(#selector(self.updateProgress), with: nil, afterDelay: 0.03)
            }
        } onFailure: { errorMessage in
            self.appVersionApiFailed()
        }
    }
    
    func getMemberLandingAPI() {
        KKApiClient.memberLandingData().execute { response in

            if let detailResponse = response.results {
                KKSingleton.sharedInstance.announcementArray = detailResponse.announcements!
                KKSingleton.sharedInstance.groupPlatformArray = detailResponse.groups!
                let name = detailResponse.userCountry?.countryName
                let countryObject = KKSingleton.sharedInstance.countryArray.first(where: {$0.name == name})
                KKUtil.encodeUserCountry(object: countryObject)
                
                let locale = detailResponse.userInfo?.locale
                let languageObject = KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == locale})
                KKUtil.encodeUserLanguage(object: languageObject)
                
                let walletBalance = detailResponse.userInfo?.walletBalance
                self.getUserProfilAPI(walletBalance: walletBalance)
            }
        } onFailure: { errorMessage in
            self.getUserProfilAPI(walletBalance: "0.00")
        }
    }
    
    @objc func getUserProfilAPI(walletBalance: String?) {
        KKApiClient.getUserProfile().execute { userProfileResponse in
            guard var userProfile = userProfileResponse.results?.user else { return }
            userProfile.walletBalance = walletBalance
            KKUtil.encodeUserProfile(object: userProfile)
            self.getAppVersionAPI()
        } onFailure: { errorMessage in
            self.getAppVersionAPI()
        }
    }
    
    //MARK:- Others
    
    func appVersionApiFailed() {
        let appVersionDetails = KKUtil.decodeAppVersionFromCache()
        if appVersionDetails != nil {
            KKSingleton.sharedInstance.countryArray = appVersionDetails!.countries!
            KKSingleton.sharedInstance.languageArray = appVersionDetails!.languages!
            KKSingleton.sharedInstance.appVersion = appVersionDetails!.appVersion!
        }
        
        self.stopProgress = 1
        if self.timerStop {
            self.perform(#selector(self.updateProgress), with: nil, afterDelay: 0.03)
        }
    }
}
