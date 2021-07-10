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
    @IBOutlet weak var imgBankCardMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var imgBankCardMarginRight: NSLayoutConstraint!

    @IBOutlet weak var headerBar: KKHeaderBar!
    @IBOutlet weak var headerBarWidth: NSLayoutConstraint!
    

    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = WithdrawSideMenu.withdraw.rawValue
    var userBankList: [KKUserBankCards]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBarLayout()
        initialLayout()
        appendSideMenuList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBankListAPI()
    }
    
    func setHeaderBarLayout() {
        imgBankCardMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 10)
        imgBankCardMarginRight.constant = imgBankCardMarginLeft.constant
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
        for item in WithdrawSideMenu.allCases {
            switch item {
            case .withdraw:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
                details.imgIcon = "ic_withdraw"
                
            case .withdrawHistory:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "withdraw_history")
                details.imgIcon = "ic_withdraw_history"
            }
            sideMenuList.append(details)
        }
        sideMenuTableView.reloadData()
    }
    
    func getBankListAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.withdrawPageData().execute { withdrawBankResponse in
            self.hideAnimatedLoader()
            self.userBankList = withdrawBankResponse.results?.userBankCards
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
    
    @IBAction func btnBankCardDidPressed() {
        let vc = KKPersonalViewController.init()
        vc.selectedViewType = PersonalSideMenu.bankCard.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func buttonHover(type: Int){
        switch type {
        case WithdrawSideMenu.withdrawHistory.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .WithdrawHistory
            changeView(vc: viewController)
            break;
        default:
            if userBankList.isEmpty {
                let viewController = KKNoBankViewController()
                viewController.isFromDeposit = false
                changeView(vc: viewController)
            } else {
                let viewController = KKWithdrawRequestViewController.init()
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
