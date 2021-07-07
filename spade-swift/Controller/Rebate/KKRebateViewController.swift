//
//  KKRebateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKRebateViewController: KKBaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    @IBOutlet weak var headerBar: KKHeaderBar!
    @IBOutlet weak var headerBarWidth: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = AffiliatteSideMenu.myAffiliate.rawValue
    
    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var rebateTableArray: [KKRebateTableResults]! = []
    var rebateInfo: KKRebateProfileRebate!

    override func viewDidLoad() {
        super.viewDidLoad()

        setHeaderBarLayout()
        initialLayout()
        appendSideMenuList()
        
        getUserBettingPlatformsAndGroupsAPI()
        getRebateTableAPI()
        getRebateProfileAPI()
    }
    
    func setHeaderBarLayout() {
        headerBarWidth.constant = ConstantSize.headerBarWidth
        headerBar.setupHeaderData(profileData: KKUtil.decodeUserProfileFromCache())
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
        for item in RebateSideMenu.allCases {
            switch item {
            case .myRebate:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "rebate_my_rebate")
                details.imgIcon = "ic_my_rebate"
                
            case .payout:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "rebate_payout")
                details.imgIcon = "ic_payout"
                
            case .rebateTrans:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "rebate_transaction")
                details.imgIcon = "ic_commtran"
                
            case .rebateTable:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "rebate_rebate_table")
                details.imgIcon = "ic_commtable"
            }
           
            sideMenuList.append(details)
        }
        
        sideMenuTableView.reloadData()
    }
    
    //MARK: API Call
    func getUserBettingPlatformsAndGroupsAPI() {
        KKApiClient.getUserBettingPlatformsAndGroups().execute { response in
            guard let groups = response.results?.groups else { return }
            if !groups.isEmpty {
                self.tabGroupArray = groups
            }
        } onFailure: { errorMessage in

        }
    }
    
    func getRebateTableAPI() {
        KKApiClient.getRebateTable().execute { response in
            if let rebateResults = response.results {
                self.rebateTableArray = rebateResults
            }
        } onFailure: { errorMessage in

        }
    }
    
    func getRebateProfileAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.getRebateProfile().execute { response in
            if let user = response.results?.user, var userProfile = KKUtil.decodeUserProfileFromCache() {
                if let wallet = user.wallet {
                    if let balance = wallet.balance {
                        if !balance.isEmpty {
                            let balanceFloat = Float(balance)
                            userProfile.walletBalance = balanceFloat
                            KKUtil.encodeUserProfile(object: userProfile)
                        }
                    }
                }
                if let rebate = user.rebate {
                    self.rebateInfo = rebate
                }
            }
            self.buttonHover(type: self.selectedViewType)
            self.hideAnimatedLoader()

        } onFailure: { errorMessage in
            self.buttonHover(type: self.selectedViewType)
            self.hideAnimatedLoader()
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        switch type {
        case RebateSideMenu.payout.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebatePayout
            viewController.tabGroupArray = tabGroupArray
            changeView(vc: viewController)
            break;
        case RebateSideMenu.rebateTrans.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateTrans
            viewController.rightDropdownOptions = pickerTransTypeArray
            changeView(vc: viewController)
            break;
        case RebateSideMenu.rebateTable.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.rebateTableArray = rebateTableArray
            viewController.tableViewType = .RebateTable
            changeView(vc: viewController)
            break;
        default:
            let viewController = KKMyRebateViewController.init()
            viewController.rebateInfo = rebateInfo
            changeView(vc: viewController)
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

extension KKRebateViewController: UITableViewDataSource, UITableViewDelegate {
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
        buttonHover(type: selectedViewType)
        sideMenuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}

