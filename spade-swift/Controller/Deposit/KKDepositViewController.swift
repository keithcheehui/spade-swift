//
//  KKDepositViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKDepositViewController: KKBaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = DepositSideMenu.bankAccount.rawValue
    var userBankList: [KKUserBankCards]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        appendSideMenuList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBankListAPI()
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
        for item in DepositSideMenu.allCases {
            switch item {
            case .bankAccount:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "deposit_bank_account")
                details.imgIcon = "ic_password"
                
            case .depositHistory:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "deposit_history")
                details.imgIcon = "ic_withdraw_history"
                
            case .artificial:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "deposit_support")
                details.imgIcon = "ic_livechat"
            }
            sideMenuList.append(details)
        }
        sideMenuTableView.reloadData()
    }
    
    func getBankListAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.depositPageData().execute { depositPageDataResponse in
            self.hideAnimatedLoader()
            self.userBankList = depositPageDataResponse.results?.userBankCards
            self.buttonHover(type: self.selectedViewType)

        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.buttonHover(type: self.selectedViewType)
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        switch type {
        case DepositSideMenu.depositHistory.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.leftDropdownOptions = pickerTimeArray
            viewController.rightDropdownOptions = pickerStatusArray
            viewController.tableViewType = .DepositHistory
            changeView(vc: viewController)
            break;
        default:
            if userBankList.isEmpty {
                let viewController = KKNoBankViewController()
                viewController.isFromDeposit = true
                changeView(vc: viewController)
            } else {
                let viewController = KKDepositRequestViewController.init()
                viewController.userBankList = userBankList
                changeView(vc: viewController)
            }
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

extension KKDepositViewController: UITableViewDataSource, UITableViewDelegate {
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
        if (indexPath.row == DepositSideMenu.artificial.rawValue) {
            self.navigationController?.pushViewController(KKSupportViewController(), animated: true)
        } else {
            selectedViewType = indexPath.row
            buttonHover(type: selectedViewType)
            sideMenuTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}
