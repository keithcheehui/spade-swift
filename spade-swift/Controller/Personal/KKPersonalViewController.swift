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

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = PersonalSideMenu.userInfo.rawValue

    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var historyTabArray: [PickerDetails]! = []

    var bettingRecordPlatfromsArray: [KKUserBettingPlatformDetails]! = []
    var bettingRecordPlatfromsNameArray: [PickerDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        appendSideMenuList()
        setupHistoryTab()
        
        getUserBettingPlatformsAndGroupsAPI()
        buttonHover(type: selectedViewType)
    }
    
    func setupHistoryTab() {
        historyTabArray.removeAll()

        for item in HistoryTab.allCases {
            var detail = PickerDetails()

            switch item {
            case .deposit:
                detail.id = item.rawValue
                detail.name = KKUtil.languageSelectedStringForKey(key: "picker_cf_deposit")
                
            case .withdraw:
                detail.id = item.rawValue
                detail.name = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
                  
            case .transfer:
                detail.id = item.rawValue
                detail.name = KKUtil.languageSelectedStringForKey(key: "picker_transfer")
                        
            case .promotion:
                detail.id = item.rawValue
                detail.name = KKUtil.languageSelectedStringForKey(key: "deposit_promotion")
            }
            historyTabArray.append(detail)
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
                
            case .wallet:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_wallet")
                details.imgIcon = "ic_user_info"
                
            case .bankCard:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_bank_card")
                details.imgIcon = "ic_bank_card"
                
            case .history:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "personal_history")
                details.imgIcon = "ic_withdraw_history"
            }
           
            sideMenuList.append(details)
        }
        
        sideMenuTableView.reloadData()
    }
    
    func getUserBettingPlatformsAndGroupsAPI() {
        KKApiClient.getUserBettingPlatformsAndGroups().execute { response in
            guard let groups = response.results?.groups else { return }
            guard let platforms = response.results?.platforms else { return }

            if !groups.isEmpty {
                self.tabGroupArray = groups
            }
            if !platforms.isEmpty {
                self.bettingRecordPlatfromsArray = platforms
                self.bettingRecordPlatfromsNameArray.removeAll()
                var detail = PickerDetails()
                detail.id = ""
                detail.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_all_provider")
                self.bettingRecordPlatfromsNameArray.append(detail)

                for platform in platforms {
                    detail = PickerDetails()
                    detail.id = platform.code ?? ""
                    detail.name = platform.name ?? ""
                    self.bettingRecordPlatfromsNameArray.append(detail)
                }
            }
            
        } onFailure: { errorMessage in

        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        selectedViewType = type
        
        switch type {
        case PersonalSideMenu.bettingRecord.rawValue:
            let viewController = KKGeneralTableViewController.init()
            viewController.tabGroupArray = tabGroupArray
            viewController.rightDropdownOptions = bettingRecordPlatfromsNameArray
            viewController.tableViewType = .BettingRecord
            changeView(vc: viewController)
            break;
        case PersonalSideMenu.accountDetail.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .AccountDetails
            changeView(vc: viewController)
            break;
        case PersonalSideMenu.wallet.rawValue:
            let viewController = KKWalletViewController.init()
            changeView(vc: viewController)
            break;
        case PersonalSideMenu.bankCard.rawValue:
            changeView(vc: KKBankListViewController())
            break;
        case PersonalSideMenu.history.rawValue:
            let viewController = KKGeneralTableViewController.init()
            viewController.historyTabArray = historyTabArray
            viewController.tableViewType = .History
            changeView(vc: viewController)
            break;
        default:
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
        buttonHover(type: selectedViewType)
        sideMenuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}
