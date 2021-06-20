//
//  KKRebateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKRebateViewController: KKBaseViewController {
    
    @IBOutlet weak var lblManualRebate: UILabel!
    @IBOutlet weak var lblRebateRecord: UILabel!
    @IBOutlet weak var lblRebateRatio: UILabel!
    @IBOutlet weak var imgHoverManualRebate: UIImageView!
    @IBOutlet weak var imgHoverRebateRecord: UIImageView!
    @IBOutlet weak var imgHoverRebateRatio: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var redeemContainer: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblRebateAmountTitle: UILabel!
    @IBOutlet weak var lblRebateAmount: UILabel!
    
    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var redeemContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var redeemContainerMarginTop: NSLayoutConstraint!
    
    enum viewType: Int {
        case manualRebate = 0
        case rebateRecord = 1
        case rebateRatio = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.manualRebate.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblManualRebate.text = KKUtil.languageSelectedStringForKey(key: "rebate_manual_rebate")
        lblRebateRecord.text = KKUtil.languageSelectedStringForKey(key: "rebate_rebate_record")
        lblRebateRatio.text = KKUtil.languageSelectedStringForKey(key: "rebate_rebate_ratio")
        
        lblManualRebate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblRebateRecord.font = lblManualRebate.font
        lblRebateRatio.font = lblManualRebate.font
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
            
            lblID.font = lblManualRebate.font
            lblRebateAmountTitle.font = lblManualRebate.font
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
    
    @IBAction func btnManualRebateDidPressed(){
        buttonHover(type: viewType.manualRebate.rawValue)
    }
    
    @IBAction func btnRebateRecordDidPressed(){
        buttonHover(type: viewType.rebateRecord.rawValue)
    }

    @IBAction func btnRebateRatioDidPressed(){
        buttonHover(type: viewType.rebateRatio.rawValue)
    }
    
    func buttonHover(type: Int){
        imgHoverManualRebate.isHidden = true
        imgHoverRebateRecord.isHidden = true
        imgHoverRebateRatio.isHidden = true
                
        showRedeemContainer(shouldShow: false)

        switch type {
        case viewType.rebateRecord.rawValue:
            imgHoverRebateRecord.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateRecord
            changeView(vc: viewController)
            break;
        case viewType.rebateRatio.rawValue:
            imgHoverRebateRatio.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .RebateRatio
            changeView(vc: viewController)

            break;
        default:
            imgHoverManualRebate.isHidden = false
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
        
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
}
