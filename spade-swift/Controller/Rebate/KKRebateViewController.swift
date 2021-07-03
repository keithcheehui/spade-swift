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
    
    @IBOutlet weak var redeemContainer: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblRebateAmountTitle: UILabel!
    @IBOutlet weak var lblRebateAmount: UILabel!
    
    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var redeemContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var redeemContainerMarginTop: NSLayoutConstraint!
    
    @IBOutlet weak var headerBar: KKHeaderBar!
    @IBOutlet weak var headerBarWidth: NSLayoutConstraint!
    
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = AffiliatteSideMenu.myAffiliate.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHeaderBarLayout()
        initialLayout()
        appendSideMenuList()
        
        buttonHover(type: selectedViewType)
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
                
            case .transaction:
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
    
    func showRedeemContainer(shouldShow: Bool) {
        if (shouldShow) {
            redeemContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 60)
            redeemContainer.isHidden = false
            
            redeemContainer.backgroundColor = UIColor(white: 0, alpha: 0.1)
            redeemContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
            redeemContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
            redeemContainer.layer.cornerRadius = 8
            
            lblID.text = KKUtil.languageSelectedStringForKey(key: "rebate_rebate_profile_id") + String(80808080)
            lblRebateAmountTitle.text = KKUtil.languageSelectedStringForKey(key: "rebate_rebate_amount")
            lblRebateAmount.text = "0.00"
            
            lblID.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
            lblRebateAmountTitle.font = lblID.font
            lblRebateAmount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 24))
        } else {
            redeemContainerHeight.constant = 0
            redeemContainer.isHidden = true
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        showRedeemContainer(shouldShow: false)

        switch type {
        case RebateSideMenu.payout.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateRecord
            changeView(vc: viewController)
            break;
            
        case RebateSideMenu.transaction.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateRatio
            changeView(vc: viewController)
            break;
            
        case RebateSideMenu.rebateTable.rawValue:
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateRatio
            changeView(vc: viewController)
            break;
            
        default:
            showRedeemContainer(shouldShow: true)
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .ManualRebate
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

