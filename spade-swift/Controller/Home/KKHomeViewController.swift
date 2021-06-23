//
//  KKHomeViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/04/2021.
//

import Foundation
import UIKit
import MarqueeLabel
import KeychainSwift

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
    @IBOutlet weak var refreshWalletIcon: UIImageView!
    @IBOutlet weak var refreshWalletBtn: UIButton!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblMission: UILabel!
    @IBOutlet weak var lblBonus: UILabel!
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var announcementContainer: UIView!
    @IBOutlet weak var lblAnnouncement: MarqueeLabel!
    @IBOutlet weak var imgArrowUp: UIImageView!
    @IBOutlet weak var imgArrowDown: UIImageView!

    ///Guest
    @IBOutlet weak var guestContainer: UIView!

    ///Content
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    ///Footer Container
    @IBOutlet weak var lblAffiliate: UILabel!
    @IBOutlet weak var lblRebate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblSupport: UILabel!
    @IBOutlet weak var lblMore: UILabel!
    
    ///Announcement bubble
    @IBOutlet weak var announcementBubble: UIView!
    @IBOutlet weak var lblAnnouncementBubble: UILabel!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    @IBOutlet weak var imgProfileMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblProfileNameWidth: NSLayoutConstraint!
    @IBOutlet weak var lblCopyWidth: NSLayoutConstraint!
    @IBOutlet weak var expBarHeight: NSLayoutConstraint!
    @IBOutlet weak var moneyContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var moneyContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCoinWidth: NSLayoutConstraint!
    @IBOutlet weak var imgRefreshWidth: NSLayoutConstraint!
    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var topButtonsContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var announcementContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var announcementContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var footerContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var footerButtonContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var footerButtonContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgAffiliateWidth: NSLayoutConstraint!
    @IBOutlet weak var btnWithdrawWidth: NSLayoutConstraint!
    @IBOutlet weak var separaterHeight: NSLayoutConstraint!
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgArrowUpHeight: NSLayoutConstraint!
    @IBOutlet weak var announcementBubbleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var announcementBubbleIconWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
        initFlowLayout()
        
        if KKSingleton.sharedInstance.groupPlatformArray.count > 0 {

            self.menuCollectionView.reloadData()
            self.selectedDefaultSideMenu()
        }
        else {

            self.getContentGroupAndPlatform()
        }
        
        setupGuestView(isGuest: true)
    }
    
    func initialLayout(){
        topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 100)
        imgProfileMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgProfileWidth.constant = KKUtil.ConvertSizeByDensity(size: 40)
        lblProfileNameWidth.constant = KKUtil.ConvertSizeByDensity(size: 80)
        lblCopyWidth.constant = KKUtil.ConvertSizeByDensity(size: 60)
        expBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 4)
        moneyContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: 180)
        moneyContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCoinWidth.constant = KKUtil.ConvertSizeByDensity(size: 40)
        imgRefreshWidth.constant = KKUtil.ConvertSizeByDensity(size: 18)
        topButtonsContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        announcementContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 350 : 400)
        announcementContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        footerContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 50)
        footerButtonContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 30 : 35)
        footerButtonContainerMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgAffiliateWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 22)
        btnWithdrawWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 110 : 130)
        separaterHeight.constant = KKUtil.ConvertSizeByDensity(size: 16)
        menuWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        imgArrowUpHeight.constant = KKUtil.ConvertSizeByDensity(size: 15)
        announcementBubbleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 8)
        announcementBubbleIconWidth.constant = KKUtil.ConvertSizeByDensity(size: 12)
        
        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "home_copy_id")
        lblMission.text = KKUtil.languageSelectedStringForKey(key: "home_mission")
        lblBonus.text = KKUtil.languageSelectedStringForKey(key: "home_bonus")
        lblSettings.text = KKUtil.languageSelectedStringForKey(key: "home_settings")
        lblAffiliate.text = KKUtil.languageSelectedStringForKey(key: "home_affiliates")
        lblRebate.text = KKUtil.languageSelectedStringForKey(key: "home_rebate")
        lblMessage.text = KKUtil.languageSelectedStringForKey(key: "home_message")
        lblSupport.text = KKUtil.languageSelectedStringForKey(key: "home_support")
        lblMore.text = KKUtil.languageSelectedStringForKey(key: "home_more")
        lblAnnouncementBubble.text = KKUtil.languageSelectedStringForKey(key: "home_announcement")
        
        lblProfileName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblVip.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        lblAnnouncement.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblCopy.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        lblMoney.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 13))
        lblMission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblCountry.font = lblMission.font
        lblBonus.font = lblMission.font
        lblSettings.font = lblMission.font
        lblLanguage.font = lblMission.font
        lblAffiliate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblRebate.font = lblAffiliate.font
        lblMessage.font = lblAffiliate.font
        lblSupport.font = lblAffiliate.font
        lblMore.font = lblAffiliate.font
        lblAnnouncementBubble.font = lblAffiliate.font

        copyContainer.backgroundColor = UIColor(white: 0, alpha: 0.8)
        copyContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)
        copyContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1.0)
        copyContainer.layer.borderColor = UIColor.spade_white_FFFFFF.cgColor
        moneyContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        moneyContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)
        announcementContainer.backgroundColor = UIColor(white: 0, alpha: 0.5)
        announcementContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 9 : 10)

        setGradientBackground(colorTop: UIColor(white: 0, alpha: 0.0), colorCenter: UIColor(white: 0, alpha: 0.65), colorBottom: UIColor(white: 0, alpha: 0.0), view: menuContainer)

        imgArrowUp.transform = imgArrowUp.transform.rotated(by: .pi)
        announcementBubble.isHidden = true
        
        self.imgArrowUp.alpha = 0
        self.imgArrowDown.alpha = 1
        
        let ratio = Float(10) / Float(10)
        expBar.progress = Float(ratio)
        
        lblProfileName.text = KKUtil.languageSelectedStringForKey(key: "home_guest")
        lblVip.text = "VIP 1"
        lblMoney.text = "999,999,999"
        imgProfile.image = UIImage(named: "ic_profile")
        lblLanguage.text = KKUtil.decodeSelectedLanguageFromCache().name
        countryImageView.setUpImage(with: KKUtil.decodeSelectedCountryFromCache().img, placeholder: UIImage(named: "ic_malaysia"))
        lblCountry.text = KKUtil.decodeSelectedCountryFromCache().name
        setAnnouncementLabel()
    }
    
    func setAnnouncementLabel() {
        
        lblAnnouncement.fadeLength = 10.0
        lblAnnouncement.leadingBuffer = 30.0
        lblAnnouncement.trailingBuffer = 20.0
        lblAnnouncement.speed = MarqueeLabel.SpeedLimit.duration(20)

        var announcementString = ""
        for (_, announcementDetails) in KKSingleton.sharedInstance.announcementArray.reversed().enumerated() {
            announcementString += "\(announcementDetails.title!)               \(announcementDetails.descriptionValue!)                                                       "
        }

        lblAnnouncement.text = announcementString
    }
    
    func setGradientBackground(colorTop: UIColor, colorCenter: UIColor, colorBottom: UIColor, view: UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorCenter.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = view.bounds
        gradientLayer.frame.size.width = menuWidth.constant

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateLobbyBackgroundImage(gameType: Int) {
        switch gameType {
        case GameType.hotGame:
            imgBG.image = UIImage(named: "bg_hot_game")
        case GameType.slots:
            imgBG.image = UIImage(named: "bg_p2p")
        case GameType.fishing:
            imgBG.image = UIImage(named: "bg_fishing")
        case GameType.liveCasino:
            imgBG.image = UIImage(named: "bg_live_casino")
        case GameType.sports:
            imgBG.image = UIImage(named: "bg_sport")
        case GameType.lottery:
            imgBG.image = UIImage(named: "bg_lottery")
        case GameType.esports:
            imgBG.image = UIImage(named: "bg_esports")
        default:
            imgBG.image = UIImage(named: "bg_p2p")
        }
    }
    
    func getMenuIcon(index: Int) -> String{
        var menuIcon = ""
        switch index {
        case GameType.hotGame:
            menuIcon = "ic_hot"
        case GameType.slots:
            menuIcon = "ic_slots"
        case GameType.fishing:
            menuIcon = "ic_fishing"
        case GameType.liveCasino:
            menuIcon = "ic_live_casino"
        case GameType.p2pGame:
            menuIcon = "ic_p2p"
        case GameType.sports:
            menuIcon = "ic_sports"
        case GameType.lottery:
            menuIcon = "ic_lottery"
        case GameType.esports:
            menuIcon = "ic_esports"
        default:
            break
        }
        
        return menuIcon
    }
    
    func getMenuName(index: Int) -> String{
        var menuName = ""
        switch index {
        case GameType.hotGame:
            menuName = "home_hot_game"
        case GameType.slots:
            menuName = "home_slots"
        case GameType.fishing:
            menuName = "home_fishing"
        case GameType.liveCasino:
            menuName = "home_live_casino"
        case GameType.p2pGame:
            menuName = "home_p2p_game"
        case GameType.sports:
            menuName = "home_sports"
        case GameType.lottery:
            menuName = "home_lottery"
        case GameType.esports:
            menuName = "home_esports"
        default:
            break
        }
        
        return menuName
    }
    
    func setupGuestView(isGuest: Bool){
        if isGuest {
            guestContainer.isHidden = false
            copyContainer.isHidden = true
            lblVip.isHidden = true
            expBar.isHidden = true
            
        } else {
            guestContainer.isHidden = true
            copyContainer.isHidden = false
            lblVip.isHidden = false
            expBar.isHidden = false
        }
    }

    func changeView(vc: KKBaseViewController){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        vc.tableContentView = contentView
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
    
    //MARK:- API Calls
    
    func getUserLatestWallet() {
        
        refreshWalletIcon.startRotate()
        refreshWalletBtn.isEnabled = false
        
        KKApiClient.getUserLatestWallet().execute { userWalletResponse in
            
            self.refreshWalletIcon.removeRotate()
            self.refreshWalletBtn.isEnabled = true
            
            if var userProfile = KKUtil.decodeUserProfileFromCache(), let userInfo = userWalletResponse.results {
                userProfile.walletBalance = userInfo.walletBalance!
                
                do {
                    KeychainSwift().set(try JSONEncoder().encode(userProfile), forKey: CacheKey.userProfile)
                }
                catch {
                    
                }
            }
            
            if let userWalletResult = userWalletResponse.results {
                
                self.lblMoney.text = userWalletResult.walletBalance!.addCurrencyFormat()
            }
            
        } onFailure: { errorMessage in
            
            self.refreshWalletIcon.removeRotate()
            self.refreshWalletBtn.isEnabled = true
            self.showAlertView(alertMessage: errorMessage)
        }
    }
    
    func getContentGroupAndPlatform() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getContentGroupsAndPlatform().execute { groupPlatformResponse in
            
            self.hideAnimatedLoader()
            KKSingleton.sharedInstance.groupPlatformArray = groupPlatformResponse.results!.groups!
            self.menuCollectionView.reloadData()
            
            self.selectedGameType = 0
            self.updateLobbyBackgroundImage(gameType: self.selectedGameType)
            
            let viewController = KKGameListViewController.init()
            viewController.selectedGameType = self.selectedGameType
            viewController.gameListArray = KKSingleton.sharedInstance.groupPlatformArray[self.selectedGameType].platforms
            self.changeView(vc: viewController)
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: errorMessage)
        }
    }

    func animateHideBubble() {
        UIView.animate(withDuration: 10.0, animations: {
            self.announcementBubble.isHidden = true
        })
    }
    
    //MARK:- Button Actions
    
    @IBAction func btnProfileDidPressed(){
        self.navigationController?.pushViewController(KKPersonalViewController(), animated: true)
    }
    
    @IBAction func btnCopyDidPressed(){
        
    }
    
    @IBAction func btnLoginDidPressed(){
        announcementBubble.isHidden = true
        self.present(KKLoginViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnRegisterDidPressed(){
        announcementBubble.isHidden = true
        self.present(KKOTPViewController(), animated: false, completion: nil)
    }
    

    @IBAction func btnRefreshDidPressed(){
        announcementBubble.isHidden = true

        if UserDefaults.standard.bool(forKey: CacheKey.loginStatus) {
            
            self.getUserLatestWallet()
        }
    }
    
    @IBAction func btnCountryDidPressed(){
        announcementBubble.isHidden = true

    }
    
    @IBAction func btnMissionDidPressed(){
        announcementBubble.isHidden = true

    }
    
    @IBAction func btnBonusDidPressed(){
        announcementBubble.isHidden = true
        self.present(KKBonusViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnSettingsDidPressed(){
        announcementBubble.isHidden = true
        self.present(KKSettingsViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnLanguageDidPressed(){
        announcementBubble.isHidden = true
    }
    
    @IBAction func btnAnnouncementDidPressed(){
        announcementBubble.isHidden = true
        self.present(KKAnnouncementViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnAffiliatesDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKAffiliateViewController(), animated: true)
    }
    
    @IBAction func btnRebateDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKRebateViewController(), animated: true)
    }
    
    @IBAction func btnMessageDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKMessageViewController(), animated: true)
    }
    
    @IBAction func btnSupportDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKSupportViewController(), animated: true)
    }
    
    @IBAction func btnMoreDidPressed(){
        announcementBubble.isHidden = !announcementBubble.isHidden
    }
    
    @IBAction func btnDepositDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKDepositViewController(), animated: true)
    }
    
    @IBAction func btnWithdrawDidPressed(){
        announcementBubble.isHidden = true
        self.navigationController?.pushViewController(KKWithdrawViewController(), animated: true)
    }
    
    //MARK:- Collection View Flow Layout
    
    func initFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        flowLayout.itemSize = CGSize(width: menuWidth.constant, height: KKUtil.ConvertSizeByDensity(size: 45))

        menuCollectionView.collectionViewLayout = flowLayout
        menuCollectionView.register(UINib(nibName: "KKGameMenuItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.gameMenuItemCVCIdentifier)
    }
    
    //MARK:- Others
    
    func selectedDefaultSideMenu() {
        
        self.selectedGameType = 0
        self.updateLobbyBackgroundImage(gameType: self.selectedGameType)
        
        let viewController = KKGameListViewController.init()
        viewController.selectedGameType = self.selectedGameType
        viewController.gameListArray = KKSingleton.sharedInstance.groupPlatformArray[self.selectedGameType].platforms
        self.changeView(vc: viewController)
    }
}

extension KKHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KKSingleton.sharedInstance.groupPlatformArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gameMenuItemCVCIdentifier, for: indexPath) as? KKGameMenuItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == selectedGameType) {
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        cell.lblMenuName.text = KKSingleton.sharedInstance.groupPlatformArray[indexPath.item].name
        cell.imgMenuIcon.setUpImage(with: KKSingleton.sharedInstance.groupPlatformArray[indexPath.item].img)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        announcementBubble.isHidden = true
        selectedGameType = indexPath.item
        updateLobbyBackgroundImage(gameType: selectedGameType)
        
        switch selectedGameType {
        case GameType.liveCasino:
            let viewController = KKLiveCasinoViewController.init()
            viewController.selectedGameType = selectedGameType
            viewController.liveCasinoArray = KKSingleton.sharedInstance.groupPlatformArray[indexPath.item].platforms
            changeView(vc: viewController)
            break;
        default:
            let viewController = KKGameListViewController.init()
            viewController.selectedGameType = selectedGameType
            viewController.gameListArray = KKSingleton.sharedInstance.groupPlatformArray[indexPath.item].platforms
            changeView(vc: viewController)
            break;
        }
        
        collectionView.reloadData()
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        announcementBubble.isHidden = true
        
        if (indexPath.row == KKSingleton.sharedInstance.groupPlatformArray.count - 1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.imgArrowUp.alpha = 1
                self.imgArrowDown.alpha = 0
            })
        } else if (indexPath.row == 0) {
            UIView.animate(withDuration: 0.3, animations: {
                self.imgArrowUp.alpha = 0
                self.imgArrowDown.alpha = 1
            })
        }
    }
}
