//
//  KKGeneralPopUpTableViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 19/06/2021.
//

import UIKit

class KKGeneralPopUpTableViewController: KKGeneralTableViewController {

    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var contentMarginTop: NSLayoutConstraint!
    @IBOutlet weak var contentMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var contentMarginRight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
    }
    
    override func initialLayout() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        contentMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 12)
        contentMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 14)
        contentMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 14)
        
        if tableViewType == .ComissionTable {
            
            imgTitle.image = UIImage(named: "title_commission_table")
        }
        else if tableViewType == .CommissionTransaction {
            
            imgTitle.image = UIImage(named: "title_commission_transaction")
        }
        else if tableViewType == .DepositHistory {
            
            imgTitle.image = UIImage(named: "title_deposit_history")
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
}
