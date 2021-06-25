//
//  KKWithdrawCommissionViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 15/05/2021.
//

import Foundation
import UIKit

class KKWithdrawCommissionViewController: KKBaseViewController {
    
    @IBOutlet weak var lblCommissionAvailable: UILabel!
    @IBOutlet weak var lblCommissionAvailableValue: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblBalanceValue: UILabel!

    @IBOutlet weak var lblTransferCommission: UILabel!
    @IBOutlet weak var lblRM: UILabel!
    @IBOutlet weak var txtRMView: UIView!
    @IBOutlet weak var txtRM: UITextField!
    @IBOutlet weak var lblClear: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSubmitHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        txtRMView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        txtRMView.layer.cornerRadius = 4
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        textFieldHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnSubmitHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        lblCommissionAvailable.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_avaiable")
        lblCommissionAvailableValue.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_avaiable_value")
        lblBalance.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_balance")
        lblBalanceValue.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_avaiable_value")
        lblTransferCommission.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_transfer")
        lblRM.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_currency_rm")
        lblClear.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_clear")
        lblTip.text = KKUtil.languageSelectedStringForKey(key: "withdraw_com_tip")
        
        txtRM.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblCommissionAvailable.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblCommissionAvailableValue.font = lblCommissionAvailable.font
        lblBalance.font = lblCommissionAvailable.font
        lblBalanceValue.font = lblCommissionAvailable.font
        lblClear.font = lblCommissionAvailable.font
        
        lblTransferCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblRM.font = lblTransferCommission.font
        txtRM.font = lblTransferCommission.font

        lblTip.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        
        lblCommissionAvailable.textColor = UIColor.spade_white_FFFFFF
        lblBalance.textColor = lblCommissionAvailable.textColor
        lblTransferCommission.textColor = lblCommissionAvailable.textColor
        lblClear.textColor = lblCommissionAvailable.textColor
        lblRM.textColor = lblCommissionAvailable.textColor
        txtRM.textColor = lblCommissionAvailable.textColor

        lblTip.textColor = UIColor.spade_grey_B3C0E0
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnClearDidPressed(){
        txtRM.text = ""
    }
    
    @IBAction func btnTransferDidPressed(){

    }
}
