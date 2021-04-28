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
    
    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
        imgBackWidth.constant = KKUtil.ConvertSizeByDensity(size: 35)
        sideMenuWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        imgMenuIconWidth.constant = KKUtil.ConvertSizeByDensity(size: 25)
        menuItemHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        separatorHeight.constant = KKUtil.ConvertSizeByDensity(size: 10)

        headerContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
        menuItemMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        
        lblUserInfo.text = KKUtil.languageSelectedStringForKey(key: "personal_user_info")
        lblBettingRecord.text = KKUtil.languageSelectedStringForKey(key: "personal_betting_record")
        lblAccountDetails.text = KKUtil.languageSelectedStringForKey(key: "personal_account_detail")
        lblIndividualReport.text = KKUtil.languageSelectedStringForKey(key: "personal_individual_report")
        
        lblUserInfo.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBettingRecord.font = lblUserInfo.font
        lblAccountDetails.font = lblUserInfo.font
        lblIndividualReport.font = lblUserInfo.font

        buttonHover(image: imgHoverUserInfo)
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        
    }
    
    @IBAction func btnUserInfoDidPressed(){
        buttonHover(image: imgHoverUserInfo)
    }
    
    @IBAction func btnBettingRecordDidPressed(){
        buttonHover(image: imgHoverBettingRecord)
    }

    @IBAction func btnAccountDetailsDidPressed(){
        buttonHover(image: imgHoverAccountDetails)
    }
    
    @IBAction func btnIndividualReportDidPressed(){
        buttonHover(image: imgHoverIndividualReport)
    }
    
    func buttonHover(image: UIImageView){
        imgHoverUserInfo.isHidden = true
        imgHoverBettingRecord.isHidden = true
        imgHoverAccountDetails.isHidden = true
        imgHoverIndividualReport.isHidden = true
        
        image.isHidden = false
    }
}