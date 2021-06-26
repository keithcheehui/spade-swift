//
//  KKWithdrawViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKWithdrawViewController: KKBaseViewController {
    
    @IBOutlet weak var lblWithdraw: UILabel!
    @IBOutlet weak var lblWithdrawHistory: UILabel!
    @IBOutlet weak var lblBankCard: UILabel!
    @IBOutlet weak var imgHoverWithdraw: UIImageView!
    @IBOutlet weak var imgHoverWithdrawHistory: UIImageView!
    @IBOutlet weak var imgHoverBankCard: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case withdraw = 0
        case withdrawHistory = 1
        case bankCard = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.withdraw.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblWithdraw.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
        lblWithdrawHistory.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_history")
        lblBankCard.text = KKUtil.languageSelectedStringForKey(key: "withdraw_bank_card")
        
        lblWithdraw.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblWithdrawHistory.font = lblWithdraw.font
        lblBankCard.font = lblWithdraw.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnWithdrawDidPressed(){
        buttonHover(type: viewType.withdraw.rawValue)
    }
    
    @IBAction func btnWithdrawHistoryDidPressed(){
        buttonHover(type: viewType.withdrawHistory.rawValue)
    }

    @IBAction func btnBankCardDidPressed(){
        buttonHover(type: viewType.bankCard.rawValue)
    }
    
    func buttonHover(type: Int){
        imgHoverWithdraw.isHidden = true
        imgHoverWithdrawHistory.isHidden = true
        imgHoverBankCard.isHidden = true
        
        switch type {
        case viewType.withdrawHistory.rawValue:
            imgHoverWithdrawHistory.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .WithdrawHistory
            changeView(vc: viewController)
            break;
        case viewType.bankCard.rawValue:
            imgHoverBankCard.isHidden = false
            let viewController = KKBankListViewController()
            changeView(vc: viewController)
            break;
        default:
            imgHoverWithdraw.isHidden = false
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
        imgHoverWithdraw.isHidden = true
        imgHoverWithdrawHistory.isHidden = true
        imgHoverBankCard.isHidden = false
        
        changeView(vc: KKAddBankViewController())
    }
}
