//
//  KKMyAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/05/2021.
//

import Foundation
import UIKit
import Photos

class KKMyRebateViewController: KKBaseViewController {
    
    @IBOutlet weak var totalCommissionContainer: UIView!
    @IBOutlet weak var lblTitleTotalCommission: UILabel!
    @IBOutlet weak var lblTotalCommisionView: UIView!
    @IBOutlet weak var lblTotalCommisionValue: UILabel!
    
    @IBOutlet weak var availableCommissionContainer: UIView!
    @IBOutlet weak var lblTitleAvailableCommision: UILabel!
    @IBOutlet weak var lblAvailableCommissionView: UIView!
    @IBOutlet weak var lblAvailableCommissionValue: UILabel!
    
    @IBOutlet weak var withdrawCommissionContainer: UIView!
    @IBOutlet weak var lblTitleWithdrawCommission: UILabel!
    @IBOutlet weak var lblEnterAmount: UILabel!
    @IBOutlet weak var lblWithdrawCommissionView: UIView!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var txtWithdrawCommissionValue: UITextField!
    @IBOutlet weak var lblTips: UILabel!
    
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var inputContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var iconMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight: NSLayoutConstraint!
    @IBOutlet weak var iconMarginLeft2: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight2: NSLayoutConstraint!
    @IBOutlet weak var amountMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var amountMarginRight: NSLayoutConstraint!

    @IBOutlet weak var btnCollectHeight: NSLayoutConstraint!

    var rebateInfo: KKRebateProfileRebate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        updateValue()
    }
    
    func initialLayout(){
        titleContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        inputContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 22)
        iconWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: 45))
        
        iconMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 20)
        iconMarginRight.constant = iconMarginLeft.constant
        iconMarginLeft2.constant = KKUtil.ConvertSizeByDensity(size: 60)
        iconMarginRight2.constant = iconMarginLeft2.constant
        amountMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 40)
        amountMarginRight.constant = amountMarginLeft.constant
        
        btnCollectHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)

        totalCommissionContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        lblTotalCommisionView.backgroundColor = totalCommissionContainer.backgroundColor
        availableCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        lblAvailableCommissionView.backgroundColor = totalCommissionContainer.backgroundColor
        withdrawCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        lblWithdrawCommissionView.backgroundColor = totalCommissionContainer.backgroundColor

        lblTotalCommisionView.layer.cornerRadius = 4
        lblAvailableCommissionView.layer.cornerRadius = lblTotalCommisionView.layer.cornerRadius
        lblWithdrawCommissionView.layer.cornerRadius = lblTotalCommisionView.layer.cornerRadius

        lblTitleTotalCommission.text = KKUtil.languageSelectedStringForKey(key: "my_rebate_total_rebate")
        lblTitleAvailableCommision.text = KKUtil.languageSelectedStringForKey(key: "my_rebate_available_rebate")
        lblTitleWithdrawCommission.text = KKUtil.languageSelectedStringForKey(key: "my_rebate_withdraw_rebate")
        lblEnterAmount.text = KKUtil.languageSelectedStringForKey(key: "my_affi_enter_amt")
        lblTips.text = KKUtil.languageSelectedStringForKey(key: "my_affi_tips")
        
        lblTitleTotalCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 11 : 12))
        lblTitleAvailableCommision.font = lblTitleTotalCommission.font
        lblTitleWithdrawCommission.font = lblTitleTotalCommission.font
        
        lblTotalCommisionValue.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 9))
        txtWithdrawCommissionValue.font = lblTotalCommisionValue.font
        lblAvailableCommissionValue.font = lblTotalCommisionValue.font
        lblEnterAmount.font = lblTotalCommisionValue.font
        lblCurrency.font = lblTotalCommisionValue.font
        txtWithdrawCommissionValue.font = lblTotalCommisionValue.font
        lblTips.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        
        lblTitleTotalCommission.textColor = .spade_white_FFFFFF
        lblTitleAvailableCommision.textColor = lblTitleTotalCommission.textColor
        lblTitleWithdrawCommission.textColor = lblTitleTotalCommission.textColor
        
        lblTotalCommisionValue.textColor = lblTitleTotalCommission.textColor
        lblAvailableCommissionValue.textColor = lblTitleTotalCommission.textColor
        lblEnterAmount.textColor = lblTitleTotalCommission.textColor
        lblCurrency.textColor = lblTitleTotalCommission.textColor
        txtWithdrawCommissionValue.textColor = lblTitleTotalCommission.textColor
        lblTips.textColor = lblTitleTotalCommission.textColor
        
        txtWithdrawCommissionValue.delegate = self
        txtWithdrawCommissionValue.keyboardType = .numberPad
        txtWithdrawCommissionValue.returnKeyType = .done
    }
    
    func updateValue() {
        if let info = rebateInfo {
            if let totalRebate = info.totalRebate {
                lblTotalCommisionValue.text = KKUtil.addCurrencyFormatWithString(value: totalRebate)
            }
            
            if let availableRebate = info.availableRebate {
                lblAvailableCommissionValue.text = KKUtil.addCurrencyFormatWithString(value: availableRebate)
            }
        }
        
        lblCurrency.text = KKUtil.decodeUserCountryFromCache().currency
    }
    
    ///Button Actions
    @IBAction func btnCollectCommissionDidPressed(){
        if let text = txtWithdrawCommissionValue.text {
            if text.isEmpty {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_amount_empty"))
                return
            }
            rebateCollectAPI(amount: text)
        }
    }
    
    @IBAction func clearText() {
        txtWithdrawCommissionValue.text = ""
    }
    
    //MARK: API Call
    func rebateCollectAPI(amount: String){
        self.showAnimatedLoader()
        KKApiClient.rebateCollect(amount: amount).execute{ response in
            self.hideAnimatedLoader()
            NotificationCenter.default.post(name: Notification.Name("NotificationGetMyRebate"), object: nil)
            self.clearText()
            self.showAlertView(type: .Success, alertMessage: response.message ?? "")
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
}

extension KKMyRebateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

         // Uses the number format corresponding to your Locale
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         formatter.locale = Locale.current
         formatter.maximumFractionDigits = 0


        // Uses the grouping separator corresponding to your Locale
        // e.g. "," in the US, a space in France, and so on
        if let groupingSeparator = formatter.groupingSeparator {

            if string == groupingSeparator {
                return true
            }


            if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: groupingSeparator, with: "") {
                var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
                if string.isEmpty { // pressed Backspace key
                    totalTextWithoutGroupingSeparators.removeLast()
                }
                if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
                    let formattedText = formatter.string(from: numberWithoutGroupingSeparator) {

                    textField.text = formattedText
                    return false
                }
            }
        }
        return true
    }
}
