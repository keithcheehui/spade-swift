//
//  KKWithdrawViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKWithdrawViewController: KKBaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = WithdrawSideMenu.withdraw.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        appendSideMenuList()
        
        buttonHover(type: selectedViewType)
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
        for item in WithdrawSideMenu.allCases {
            switch item {
            case .withdraw:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
                details.imgIcon = "ic_withdraw"
                
            case .withdrawHistory:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_history")
                details.imgIcon = "ic_withdraw_history"
                
            case .bankCard:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "withdraw_bank_card")
                details.imgIcon = "ic_bank_card"
            }
           
            sideMenuList.append(details)
        }
        
        sideMenuTableView.reloadData()
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        switch type {
        case WithdrawSideMenu.withdrawHistory.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .WithdrawHistory
            changeView(vc: viewController)
            break;
        case WithdrawSideMenu.bankCard.rawValue:
            let viewController = KKBankListViewController()
            changeView(vc: viewController)
            break;
        default:
            let viewController = KKWithdrawRequestViewController.init()
            viewController.parentVC = self
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
    
    func changeToHoverBankCard() {
        selectedViewType = WithdrawSideMenu.bankCard.rawValue
        buttonHover(type: selectedViewType)
        changeView(vc: KKAddBankViewController())
    }
}

extension KKWithdrawViewController: UITableViewDataSource, UITableViewDelegate {
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
