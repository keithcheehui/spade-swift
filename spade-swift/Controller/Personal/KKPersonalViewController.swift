//
//  KKPersonalViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKPersonalViewController: KKBaseViewController {
    
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblBettingRecord: UILabel!
    @IBOutlet weak var lblAccountDetails: UILabel!
    @IBOutlet weak var lblIndividualReport: UILabel!
    @IBOutlet weak var imgHoverUserInfo: UIImageView!
    @IBOutlet weak var imgHoverBettingRecord: UIImageView!
    @IBOutlet weak var imgHoverAccountDetails: UIImageView!
    @IBOutlet weak var imgHoverIndividualReport: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var groupsCollectionViewHeight: NSLayoutConstraint!
    
    enum viewType: Int {
        case userInfo = 0
        case bettingRecord = 1
        case accountDetail = 2
        case individualReport = 3
    }
    
    var selectedViewType = viewType.userInfo.rawValue
    var selectedTabItem = 0

    var bettingRecordGroupsArray: [KKUserBettingGroupDetails]! = []
    var bettingRecordGroupsNameArray: [String]! = []

    var bettingRecordPlatfromsArray: [KKUserBettingPlatformDetails]! = []
    var bettingRecordPlatfromsNameArray: [String]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        
        initFlowLayout()
        getTabArrayAPI()
        
        buttonHover(type: selectedViewType)
        
        if UserDefaults.standard.bool(forKey: CacheKey.loginStatus) {
            getUserLatestWallet()
        }
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblUserInfo.text = KKUtil.languageSelectedStringForKey(key: "personal_user_info")
        lblBettingRecord.text = KKUtil.languageSelectedStringForKey(key: "personal_betting_record")
        lblAccountDetails.text = KKUtil.languageSelectedStringForKey(key: "personal_account_detail")
        lblIndividualReport.text = KKUtil.languageSelectedStringForKey(key: "personal_individual_report")
        
        lblUserInfo.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBettingRecord.font = lblUserInfo.font
        lblAccountDetails.font = lblUserInfo.font
        lblIndividualReport.font = lblUserInfo.font
    }
        
    func initFlowLayout(){
        let size = KKUtil.ConvertSizeByDensity(size: 40)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 5)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size * 3, height: size)

        groupsCollectionView.collectionViewLayout = flowLayout
        groupsCollectionView.register(UINib(nibName: "KKTabListItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier)
    }
    
    func getUserLatestWallet() {
        
        KKApiClient.getUserLatestWallet().execute { userWalletResponse in
            
            if let userWalletResult = userWalletResponse.results {
                
                self.getUserProfile(walletBalance: userWalletResult.walletBalance!)
            }
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: errorMessage)
        }
    }
    
    @objc func getUserProfile(walletBalance: String) {
        
        KKApiClient.getUserProfile().execute { userProfileResponse in
            
            guard var userProfile = userProfileResponse.results?.user![0] else { return }
            userProfile.walletBalance = walletBalance
            
            do {
                KeychainSwift().set(try JSONEncoder().encode(userProfile), forKey: CacheKey.userProfile)
                KeychainSwift().set(try JSONEncoder().encode(KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == userProfile.locale})!), forKey: CacheKey.selectedLanguage)
            }
            catch {
                self.hideAnimatedLoader()
                self.showAlertView(alertMessage: error.localizedDescription)
            }
            
            self.hideAnimatedLoader()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: errorMessage)
        }
    }
    
    func getTabArrayAPI() {
        KKApiClient.getUserBettingGroupAndPlatform().execute { response in
            guard let groups = response.results?.groups else { return }
            guard let platforms = response.results?.platforms else { return }

            if !groups.isEmpty {
                self.bettingRecordGroupsArray = groups
                self.bettingRecordGroupsNameArray.removeAll()
                for group in groups {
                    self.bettingRecordGroupsNameArray.append(group.name ?? "")
                }
            }
            if !platforms.isEmpty {
                self.bettingRecordPlatfromsArray = platforms
                self.bettingRecordPlatfromsNameArray.removeAll()
                for platform in platforms {
                    self.bettingRecordPlatfromsNameArray.append(platform.name ?? "")
                }
            }
            self.groupsCollectionView.reloadData()
            
        } onFailure: { errorMessage in
            self.showAlertView(alertMessage: errorMessage)
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUserInfoDidPressed(){
        buttonHover(type: viewType.userInfo.rawValue)
    }
    
    @IBAction func btnBettingRecordDidPressed(){
        buttonHover(type: viewType.bettingRecord.rawValue)
    }

    @IBAction func btnAccountDetailsDidPressed(){
        buttonHover(type: viewType.accountDetail.rawValue)
    }
    
    @IBAction func btnIndividualReportDidPressed(){
        buttonHover(type: viewType.individualReport.rawValue)
    }
    
    func buttonHover(type: Int){
        selectedViewType = type
        
        imgHoverUserInfo.isHidden = true
        imgHoverBettingRecord.isHidden = true
        imgHoverAccountDetails.isHidden = true
        imgHoverIndividualReport.isHidden = true
                
        groupsCollectionView.isHidden = false
        groupsCollectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        groupsCollectionView.reloadData()
        
        switch type {
        case viewType.bettingRecord.rawValue:
            imgHoverBettingRecord.isHidden = false
            let viewController = KKGeneralTableViewController.init()
            viewController.leftDropdownOptions = pickerTimeArray
            viewController.rightDropdownOptions = bettingRecordPlatfromsNameArray
            viewController.tableViewType = .BettingRecord
            changeView(vc: viewController)
            break;
        case viewType.accountDetail.rawValue:
            imgHoverAccountDetails.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .AccountDetails
            changeView(vc: viewController)
            break;
        case viewType.individualReport.rawValue:
            imgHoverIndividualReport.isHidden = false
            changeView(vc: KKOnBoardingViewController())
            break;
        default:
            groupsCollectionView.isHidden = true
            groupsCollectionViewHeight.constant = 0
            
            imgHoverUserInfo.isHidden = false
            changeView(vc: KKUserInfoViewController())
            break;
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
}

extension KKPersonalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (selectedViewType == viewType.bettingRecord.rawValue) {
            return bettingRecordGroupsArray.count
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier, for: indexPath) as? KKTabListItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == selectedTabItem) {
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        cell.lblTitle.text = bettingRecordGroupsArray[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTabItem = indexPath.item
        collectionView.reloadData()
        return
    }
}
