//
//  KKAddBankViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKAddBankViewController: KKBaseViewController {
    
    @IBOutlet weak var lblCardholderName: UILabel!
    @IBOutlet weak var txtCardholderNameView: UIView!
    @IBOutlet weak var txtCardholderName: UITextField!
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var txtBankNameView: UIView!
    @IBOutlet weak var txtBankName: UITextField!
    
    @IBOutlet weak var lblBankAccount: UILabel!
    @IBOutlet weak var txtBankAccountView: UIView!
    @IBOutlet weak var txtBankAccount: UITextField!

    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        textFieldHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        buttonHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        txtCardholderNameView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        txtBankNameView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        txtBankAccountView.backgroundColor = UIColor(white: 0, alpha: 0.3)

        txtCardholderNameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        txtBankNameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        txtBankAccountView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        
        lblCardholderName.text = KKUtil.languageSelectedStringForKey(key: "withdraw_cardholder_name")
        lblBankName.text = KKUtil.languageSelectedStringForKey(key: "withdraw_bank_name")
        lblBankAccount.text = KKUtil.languageSelectedStringForKey(key: "withdraw_bank_account")
        lblDescription.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank_description")

        txtCardholderName.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "withdraw_cardholder_name_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtBankName.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "withdraw_bank_name"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtBankAccount.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "withdraw_bank_account_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblCardholderName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblBankName.font = lblCardholderName.font
        lblBankAccount.font = lblCardholderName.font
        
        txtCardholderName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        txtBankName.font = txtCardholderName.font
        txtBankAccount.font = txtCardholderName.font
        lblDescription.font = txtCardholderName.font
        
        lblCardholderName.textColor = UIColor.spade_white_FFFFFF
        lblBankName.textColor = lblCardholderName.textColor
        lblBankAccount.textColor = lblCardholderName.textColor
        txtCardholderName.textColor = lblCardholderName.textColor
        txtBankName.textColor = lblCardholderName.textColor
        txtBankAccount.textColor = lblCardholderName.textColor
        txtBankAccount.textColor = UIColor.spade_blue_5CB5DE
    }
    
    ///Button Actions
    @IBAction func btnDropdownDidPressed(){

    }
    
    @IBAction func btnBackDidPressed(){
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func btnConfirmDidPressed(){

    }
}
