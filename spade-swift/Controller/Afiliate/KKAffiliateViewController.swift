//
//  KKAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKAffiliateViewController: KKBaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!

    @IBOutlet weak var headerBar: KKHeaderBar!
    @IBOutlet weak var headerBarWidth: NSLayoutConstraint!

    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = AffiliatteSideMenu.myAffiliate.rawValue
    var selectedTabItem = 0
    
    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var affiliateInfo: KKAffiliateProfileAffiliate!
    var payoutArray: [KKPayoutGroup]! = []
    var transactionArray: [KKTransactionTransactions]! = []
    var tableArray: [KKTableGroups]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBarLayout()
        initialLayout()
        appendSideMenuList()
        
        getUserBettingPlatformsAndGroupsAPI()
        getMyAffiliateAPI()
        getAffiliatePayoutAPI()
        getAffiliateTransactionAPI()
        getCommissionTableAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getNotified), name: Notification.Name("NotificationGetMyAffiliate"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationGetMyAffiliate"), object: nil)
    }
    
    @objc private func getNotified(notification: NSNotification){
        getMyAffiliateAPI()
    }
    
    func setHeaderBarLayout() {
        headerBarWidth.constant = ConstantSize.headerBarWidth
        headerBar.setupHeaderData(profileData: KKUtil.decodeUserProfileFromCache())
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        headerContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
    }
    
    func appendSideMenuList() {
        sideMenuTableView.register(UINib(nibName: "KKSideMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.sideMenuTVCIdentifier)

        sideMenuList.removeAll()
        
        var details = SideMenuDetails.init()
        for item in AffiliatteSideMenu.allCases {
            switch item {
            case .myAffiliate:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_my_affiliate")
                details.imgIcon = "ic_my_affiliate"
                
            case .guideline:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_guideline")
                details.imgIcon = "ic_information"
                
            case .downline:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_downline")
                details.imgIcon = "ic_downline"
                
            case .turnover:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_turnover")
                details.imgIcon = "ic_turnover"
                
            case .payout:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_payout")
                details.imgIcon = "ic_payout"
                
            case .commissionTrans:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_comm_trans")
                details.imgIcon = "ic_commtran"
                
            case .commissionTable:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "affiliates_comm_table")
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
    
    func getMyAffiliateAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.getMyAffiliate().execute { response in
            if let user = response.results?.user, var userProfile = KKUtil.decodeUserProfileFromCache() {
                if let wallet = user.wallet {
                    if let balance = wallet.balance {
                        userProfile.walletBalance = balance
                        KKUtil.encodeUserProfile(object: userProfile)
                    }
                }
            }
            if let affiliate = response.results?.affiliate {
                self.affiliateInfo = affiliate
            }
            self.setHeaderBarLayout()
            self.buttonHover(type: self.selectedViewType)
            self.hideAnimatedLoader()

        } onFailure: { errorMessage in
            self.buttonHover(type: self.selectedViewType)
            self.hideAnimatedLoader()
        }
    }
    
    func getAffiliatePayoutAPI() {
        self.showAnimatedLoader()
        KKApiClient.getAffiliatePayout().execute { response in
            self.hideAnimatedLoader()
            self.payoutArray = response.results?.group
        } onFailure: { errorMessage in

        }
    }
    
    func getAffiliateTransactionAPI() {
        self.showAnimatedLoader()
        KKApiClient.getAffiliateCommissionTransaction().execute { response in
            self.hideAnimatedLoader()
            self.transactionArray = response.results?.commissionTransactions
        } onFailure: { errorMessage in

        }
    }
    
    func getCommissionTableAPI() {
        KKApiClient.getAffiliateCommissionTable().execute { response in
            if let rebateResults = response.results?.groups {
                self.tableArray = rebateResults
            }
        } onFailure: { errorMessage in

        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        switch type {
        case AffiliatteSideMenu.guideline.rawValue:
            changeView(vc: KKGuidelineViewController())
            break;
        case AffiliatteSideMenu.downline.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .AffiliateDownline
            changeView(vc: viewController)
            break;
        case AffiliatteSideMenu.turnover.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .AffiliateTurnover
            changeView(vc: viewController)
            break;
        case AffiliatteSideMenu.payout.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.payoutArray = payoutArray
            viewController.tableArray = tableArray
            viewController.tableViewType = .AffiliatePayout
            changeView(vc: viewController)
            break;
        case AffiliatteSideMenu.commissionTrans.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.transactionArray = transactionArray
            viewController.tableViewType = .AffiliateCommTrans
            viewController.rightDropdownOptions = pickerTransTypeArray
            changeView(vc: viewController)
            break;
        case AffiliatteSideMenu.commissionTable.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableArray = tableArray
            viewController.tableViewType = .AffiliateCommTable
            changeView(vc: viewController)
            break;
        default:
            let viewController = KKMyAffiliateViewController.init()
            viewController.affiliateInfo = affiliateInfo
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

extension KKAffiliateViewController: UITableViewDataSource, UITableViewDelegate {
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
