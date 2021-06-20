//
//  KKPersonalViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKPersonalViewController: KKBaseViewController {
    
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblBettingRecord: UILabel!
    @IBOutlet weak var lblAccountDetails: UILabel!
    @IBOutlet weak var lblIndividualReport: UILabel!
    @IBOutlet weak var imgHoverUserInfo: UIImageView!
    @IBOutlet weak var imgHoverBettingRecord: UIImageView!
    @IBOutlet weak var imgHoverAccountDetails: UIImageView!
    @IBOutlet weak var imgHoverIndividualReport: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case userInfo = 0
        case bettingRecord = 1
        case accountDetail = 2
        case individualReport = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.userInfo.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblUserInfo.text = KKUtil.languageSelectedStringForKey(key: "personal_user_info")
        lblBettingRecord.text = KKUtil.languageSelectedStringForKey(key: "personal_betting_record")
        lblAccountDetails.text = KKUtil.languageSelectedStringForKey(key: "personal_account_detail")
        lblIndividualReport.text = KKUtil.languageSelectedStringForKey(key: "personal_individual_report")
        
        lblUserInfo.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBettingRecord.font = lblUserInfo.font
        lblAccountDetails.font = lblUserInfo.font
        lblIndividualReport.font = lblUserInfo.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUserInfoDidPressed(){
        buttonHover(type: viewType.userInfo.rawValue)
    }
    
    @IBAction func btnBettingRecordDidPressed(){
        buttonHover(type: viewType.bettingRecord.rawValue)
    }

    @IBAction func btnAccountDetailsDidPressed(){
        buttonHover(type: viewType.accountDetail.rawValue)
    }
    
    @IBAction func btnIndividualReportDidPressed(){
        buttonHover(type: viewType.individualReport.rawValue)
    }
    
    func buttonHover(type: Int){
        imgHoverUserInfo.isHidden = true
        imgHoverBettingRecord.isHidden = true
        imgHoverAccountDetails.isHidden = true
        imgHoverIndividualReport.isHidden = true
                
        switch type {
        case viewType.bettingRecord.rawValue:
            imgHoverBettingRecord.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .BettingRecord
            changeView(vc: viewController)
            break;
        case viewType.accountDetail.rawValue:
            imgHoverAccountDetails.isHidden = false
            let viewController = KKGeneralTableViewController()
            viewController.tableViewType = .AccountDetails
            changeView(vc: viewController)

            break;
        case viewType.individualReport.rawValue:
            imgHoverIndividualReport.isHidden = false
            changeView(vc: KKOnBoardingViewController())
            break;
        default:
            imgHoverUserInfo.isHidden = false
            changeView(vc: KKUserInfoViewController())
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
