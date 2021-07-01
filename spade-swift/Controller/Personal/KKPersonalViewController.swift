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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var groupsCollectionView: UICollectionView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var groupsCollectionViewHeight: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = PersonalSideMenu.userInfo.rawValue
    var selectedTabItem = 0

    var bettingRecordGroupsArray: [KKUserBettingGroupDetails]! = []
    var bettingRecordGroupsNameArray: [String]! = []

    var bettingRecordPlatfromsArray: [KKUserBettingPlatformDetails]! = []
    var bettingRecordPlatfromsNameArray: [PickerDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        appendSideMenuList()
        
        initFlowLayout()
        getTabArrayAPI()
        
        buttonHover(type: selectedViewType, needRefresh: true)
        
        if UserDefaults.standard.bool(forKey: CacheKey.loginStatus) {
            getUserLatestWallet()
        }
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
    }
    
    func appendSideMenuList() {
        sideMenuTableView.register(UINib(nibName: "KKSideMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.sideMenuTVCIdentifier)

        sideMenuList.removeAll()
        
        var details = SideMenuDetails.init()
        for item in PersonalSideMenu.allCases {
            switch item {
            case .userInfo:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_user_info")
                details.imgIcon = "ic_user_info"
                
            case .bettingRecord:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_betting_record")
                details.imgIcon = "ic_betting_record"
                
            case .accountDetail:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_account_detail")
                details.imgIcon = "ic_account_detail"
                
            case .individualReport:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_individual_report")
                details.imgIcon = "ic_report"
                
            case .wallet:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_wallet")
                details.imgIcon = "ic_user_info"
                
            case .history:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_history")
                details.imgIcon = "ic_user_info"
            }
           
            sideMenuList.append(details)
        }
        
        sideMenuTableView.reloadData()
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
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc func getUserProfile(walletBalance: Float) {
        
        KKApiClient.getUserProfile().execute { userProfileResponse in
            
            guard var userProfile = userProfileResponse.results?.user![0] else { return }
            userProfile.walletBalance = walletBalance
            
            KKUtil.encodeUserProfile(object: userProfile)
            KKUtil.encodeUserLanguage(object: KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == userProfile.locale}))
            self.hideAnimatedLoader()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
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
                    var detail = PickerDetails()
                    detail.id = platform.code ?? ""
                    detail.name = platform.name ?? ""
                    self.bettingRecordPlatfromsNameArray.append(detail)
                }
            }
            self.groupsCollectionView.reloadData()
            
        } onFailure: { errorMessage in
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int, needRefresh: Bool? = false){
        selectedViewType = type
        if needRefresh! {
            selectedTabItem = 0
        }
        
        groupsCollectionView.isHidden = false
        groupsCollectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        groupsCollectionView.reloadData()
        
        switch type {
        case PersonalSideMenu.bettingRecord.rawValue:
            let viewController = KKGeneralTableViewController.init()
            viewController.rightDropdownOptions = bettingRecordPlatfromsNameArray
            viewController.selectedTabItem = bettingRecordGroupsArray[selectedTabItem].code
            viewController.tableViewType = .BettingRecord
            changeView(vc: viewController)
            break;
        case PersonalSideMenu.accountDetail.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.selectedTabItem = pickerCashflowArray[selectedTabItem].id
            viewController.tableViewType = .AccountDetails
            changeView(vc: viewController)
            break;
        case PersonalSideMenu.individualReport.rawValue:
            changeView(vc: KKIndividualReportViewController())
            break;
        default:
            groupsCollectionView.isHidden = true
            groupsCollectionViewHeight.constant = 0
            
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
        if (selectedViewType == PersonalSideMenu.bettingRecord.rawValue || selectedViewType == PersonalSideMenu.individualReport.rawValue) {
            return bettingRecordGroupsArray.count
        } else if (selectedViewType == PersonalSideMenu.accountDetail.rawValue) {
            return pickerCashflowArray.count
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
        
        if (selectedViewType == PersonalSideMenu.accountDetail.rawValue) {
            cell.lblTitle.text = pickerCashflowArray[indexPath.item].name
        } else {
            cell.lblTitle.text = bettingRecordGroupsArray[indexPath.item].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTabItem = indexPath.item
        collectionView.reloadData()
        buttonHover(type: selectedViewType)
        return
    }
}

extension KKPersonalViewController: UITableViewDataSource, UITableViewDelegate {
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
            cell.lblName.font = ConstantSize.sideMenuSelectedFont
        } else {
            cell.imgHover.isHidden = true
            cell.lblName.font = ConstantSize.sideMenuFont
        }
        
        cell.imgIcon.image = UIImage(named: sideMenuList[indexPath.row].imgIcon)
        cell.lblName.text = sideMenuList[indexPath.row].title
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedViewType = indexPath.row
        buttonHover(type: selectedViewType, needRefresh: true)
        sideMenuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}
