//
//  KKDepositRequestViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 14/05/2021.
//

import Foundation
import UIKit

class KKDepositRequestViewController: KKBaseViewController {
    
    @IBOutlet weak var bankSectionView: UIView!
    @IBOutlet weak var lblBankSection: UILabel!
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblBankNameView: UIView!
    @IBOutlet weak var lblBankNameValue: UILabel!
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblAccountNameValue: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblAccountNumberValue: UILabel!
    @IBOutlet weak var lblCopy: UILabel!

    @IBOutlet weak var depositSectionView: UIView!
    @IBOutlet weak var lblDepositSection: UILabel!
    @IBOutlet weak var lblDepositHistory: UILabel!
    
    @IBOutlet weak var lblDepositTime: UILabel!
    @IBOutlet weak var lblDepositTimeView: UIView!
    @IBOutlet weak var txtDepositTime: UITextField!

    @IBOutlet weak var lblDepositChannel: UILabel!
    @IBOutlet weak var lblDepositChannelView: UIView!
    @IBOutlet weak var lblDepositChannelValue: UILabel!
    
    @IBOutlet weak var lblDepositAmount: UILabel!
    @IBOutlet weak var lblDepositAmountView: UIView!
    @IBOutlet weak var txtDepositAmount: UITextField!
    
    @IBOutlet weak var lblReferenceNo: UILabel!
    @IBOutlet weak var lblReferenceNoView: UIView!
    @IBOutlet weak var txtReferenceNo: UITextField!
    
    @IBOutlet weak var lblPromotion: UILabel!
    @IBOutlet weak var lblPromotionView: UIView!
    @IBOutlet weak var lblPromotionValue: UILabel!
    
    @IBOutlet weak var lblReceipt: UILabel!
    @IBOutlet weak var lblReceiptValue: UILabel!
    @IBOutlet weak var receiptButtonContainer: UIView!
    
    @IBOutlet weak var bankSectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var lblBankNameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnCopyWidth: NSLayoutConstraint!
    @IBOutlet weak var depositItemMargin: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        uploadedReceipt(isUploaded: false)
    }
    
    func initialLayout(){
        bankSectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        textFieldHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        lblBankNameWidth.constant = KKUtil.ConvertSizeByDensity(size: 85)
        btnCopyWidth.constant = KKUtil.ConvertSizeByDensity(size: 50)
        depositItemMargin.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
        
        bankSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        depositSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)

        lblBankNameView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblDepositTimeView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblDepositChannelView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblDepositAmountView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblReferenceNoView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblPromotionView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        lblBankNameView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblDepositTimeView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblDepositChannelView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblDepositAmountView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblReferenceNoView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblPromotionView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)

        lblBankSection.text = KKUtil.languageSelectedStringForKey(key: "deposit_bank_account")
        lblBankName.text = KKUtil.languageSelectedStringForKey(key: "deposit_bank_name")
        lblAccountName.text = KKUtil.languageSelectedStringForKey(key: "deposit_account_name")
        lblAccountNumber.text = KKUtil.languageSelectedStringForKey(key: "deposit_account_number")
        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "deposit_copy")
        lblDepositSection.text = KKUtil.languageSelectedStringForKey(key: "deposit_information")
        lblDepositHistory.text = KKUtil.languageSelectedStringForKey(key: "deposit_history")
        lblDepositTime.text = KKUtil.languageSelectedStringForKey(key: "deposit_time")
        lblDepositChannel.text = KKUtil.languageSelectedStringForKey(key: "deposit_channel")
        lblDepositAmount.text = KKUtil.languageSelectedStringForKey(key: "deposit_amount")
        lblReferenceNo.text = KKUtil.languageSelectedStringForKey(key: "deposit_ref_no")
        lblPromotion.text = KKUtil.languageSelectedStringForKey(key: "deposit_promotion")
        lblPromotionValue.text = KKUtil.languageSelectedStringForKey(key: "deposit_promotion_placeholder")
        lblReceipt.text = KKUtil.languageSelectedStringForKey(key: "deposit_receipt")

        txtDepositAmount.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "deposit_amount_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtReferenceNo.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "deposit_ref_no_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblBankSection.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblDepositSection.font = lblBankSection.font
        lblDepositHistory.font = lblBankSection.font

        lblBankName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBankNameValue.font = lblBankName.font
        lblAccountName.font = lblBankName.font
        lblAccountNameValue.font = lblBankName.font
        lblAccountNumber.font = lblBankName.font
        lblAccountNumberValue.font = lblBankName.font
        lblCopy.font = lblBankName.font
        lblDepositTime.font = lblBankName.font
        txtDepositTime.font = lblBankName.font
        lblDepositChannel.font = lblBankName.font
        lblDepositChannelValue.font = lblBankName.font
        lblDepositAmount.font = lblBankName.font
        txtDepositAmount.font = lblBankName.font
        lblReferenceNo.font = lblBankName.font
        txtReferenceNo.font = lblBankName.font
        lblPromotion.font = lblBankName.font
        lblPromotionValue.font = lblBankName.font
        lblReceipt.font = lblBankName.font
        lblReceiptValue.font = lblBankName.font
        
        lblBankSection.textColor = UIColor.spade_grey_B3C0E0
        lblBankName.textColor = lblBankSection.textColor
        lblAccountName.textColor = lblBankSection.textColor
        lblAccountNumber.textColor = lblBankSection.textColor
        lblDepositSection.textColor = lblBankSection.textColor
        lblDepositTime.textColor = lblBankSection.textColor
        lblDepositChannel.textColor = lblBankSection.textColor
        lblDepositAmount.textColor = lblBankSection.textColor
        lblReferenceNo.textColor = lblBankSection.textColor
        lblPromotion.textColor = lblBankSection.textColor
        lblReceipt.textColor = lblBankSection.textColor

        lblBankNameValue.textColor = UIColor.spade_white_FFFFFF
        lblAccountNameValue.textColor = lblBankNameValue.textColor
        lblAccountNumberValue.textColor = lblBankNameValue.textColor
        lblCopy.textColor = lblBankNameValue.textColor
        lblDepositHistory.textColor = lblBankNameValue.textColor
        txtDepositTime.textColor = lblBankNameValue.textColor
        lblDepositChannelValue.textColor = lblBankNameValue.textColor
        txtDepositAmount.textColor = lblBankNameValue.textColor
        txtReferenceNo.textColor = lblBankNameValue.textColor
        lblPromotionValue.textColor = lblBankNameValue.textColor
        lblReceiptValue.textColor = lblBankNameValue.textColor
    }
    
    func uploadedReceipt(isUploaded: Bool){
        if (isUploaded){
            lblReceiptValue.isHidden = false
            receiptButtonContainer.isHidden = true
        } else {
            lblReceiptValue.isHidden = true
            receiptButtonContainer.isHidden = false
        }
    }
    
    ///Button Actions
    @IBAction func btnBankNameDidPressed(){

    }
    
    @IBAction func btnCopyDidPressed(){

    }
    
    @IBAction func btnDepositHistoryDidPressed(){

    }
    
    @IBAction func btnChannelDidPressed(){

    }
    
    @IBAction func btnPromotionDidPressed(){

    }
    
    @IBAction func btnUploadDidPressed(){

    }
    
    @IBAction func btnSubmitDidPressed(){

    }
}
