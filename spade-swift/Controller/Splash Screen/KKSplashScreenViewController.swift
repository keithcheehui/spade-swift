//
//  KKSplashScreenViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 27/04/2021.
//

import UIKit
import KeychainSwift

class KKSplashScreenViewController: KKBaseViewController {

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

        initialLayout()
        drawLoadingProgress()
        
        if KKUtil.isConnectedToInternet() {
            
            self.getAnnouncement()
        }
        else
        {
            self.appVersionApiFailed()
        }
    }

    func initialLayout(){
        imgLogoWidth.constant = KKUtil.ConvertSizeByDensity(size: 480)
        loadingBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        loadingBarMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 130)
        loadingBarMarginRight.constant = loadingBarMarginLeft.constant
        lblLoadingMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
    }

    func drawLoadingProgress(){
        
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
        }
        else if stopProgress >= 1
        {
            timerStop = true
            lblLoading.text = "loading 100%..."
            self.present(KKSelectCountryViewController(), animated: false, completion: nil)
        }
        else
        {
            timerStop = true
        }
    }
    
    //MARK:- API Calls
    
    func getAnnouncement() {
        
        KKApiClient.getContentAnnouncement().execute { announcementResponse in
            
            KKSingleton.sharedInstance.announcementArray = announcementResponse.results!.announcements!
            self.getAppVersion()
            
        } onFailure: { errorMessage in
            
            self.getAppVersion()
        }
    }
    
    func getAppVersion() {
        
        KKApiClient.getAppVersion().execute { appVersionResponse in
            
            guard let appVersionDetails = appVersionResponse.results else { return }
            
            do {
                KeychainSwift().set(try JSONEncoder().encode(appVersionDetails), forKey: CacheKey.appVersionDetails)
                KKSingleton.sharedInstance.countryArray = appVersionDetails.countries!
                KKSingleton.sharedInstance.languageArray = appVersionDetails.languages!
                
                self.stopProgress = 1
                
                if self.timerStop {
                    
                    self.perform(#selector(self.updateProgress), with: nil, afterDelay: 0.03)
                }
            }
            catch {
                
            }
            
        } onFailure: { errorMessage in
            
            self.appVersionApiFailed()
        }
    }
    
    //MARK:- Others
    
    func appVersionApiFailed() {
        
        let appVersionDetails = KKUtil.decodeAppVersionFromCache()
        
        if appVersionDetails != nil {
            
            KKSingleton.sharedInstance.countryArray = appVersionDetails!.countries!
            KKSingleton.sharedInstance.languageArray = appVersionDetails!.languages!
        }
        
        self.stopProgress = 1
        
        if self.timerStop {
            
            self.perform(#selector(self.updateProgress), with: nil, afterDelay: 0.03)
        }
    }
}
