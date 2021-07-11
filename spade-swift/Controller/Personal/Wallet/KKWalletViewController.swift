//
//  KKMyAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/05/2021.
//

import Foundation
import UIKit
import Photos

class KKWalletViewController: KKBaseViewController {
    
    @IBOutlet weak var totalCommissionContainer: UIView!
    @IBOutlet weak var lblTitleTotalCommission: UILabel!
    
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
    
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var inputContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var iconMarginLeft2: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight2: NSLayoutConstraint!
    @IBOutlet weak var amountMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var amountMarginRight: NSLayoutConstraint!

    @IBOutlet weak var btnCollectHeight: NSLayoutConstraint!

    @IBOutlet weak var fromContainer: UIView!
    @IBOutlet weak var toContainer: UIView!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblSwap: UILabel!
    @IBOutlet weak var fromContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgSwapHeight: NSLayoutConstraint!

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
        
        iconMarginLeft2.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 50 : 70)
        iconMarginRight2.constant = iconMarginLeft2.constant
        amountMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 40)
        amountMarginRight.constant = amountMarginLeft.constant
        btnCollectHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        
        totalCommissionContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        availableCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        lblAvailableCommissionView.backgroundColor = totalCommissionContainer.backgroundColor
        withdrawCommissionContainer.backgroundColor = totalCommissionContainer.backgroundColor
        lblWithdrawCommissionView.backgroundColor = totalCommissionContainer.backgroundColor

        lblAvailableCommissionView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        lblWithdrawCommissionView.layer.cornerRadius = lblAvailableCommissionView.layer.cornerRadius

        lblTitleTotalCommission.text = KKUtil.languageSelectedStringForKey(key: "wallet_platform_wallet_balance")
        lblTitleAvailableCommision.text = KKUtil.languageSelectedStringForKey(key: "wallet_total_wallet")
        lblTitleWithdrawCommission.text = KKUtil.languageSelectedStringForKey(key: "wallet_transfer")
        lblEnterAmount.text = KKUtil.languageSelectedStringForKey(key: "my_affi_enter_amt")
        
        lblTitleTotalCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 11 : 12))
        lblTitleAvailableCommision.font = lblTitleTotalCommission.font
        lblTitleWithdrawCommission.font = lblTitleTotalCommission.font
        
        txtWithdrawCommissionValue.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 9))
        lblAvailableCommissionValue.font = txtWithdrawCommissionValue.font
        lblEnterAmount.font = txtWithdrawCommissionValue.font
        lblCurrency.font = txtWithdrawCommissionValue.font
        txtWithdrawCommissionValue.font = txtWithdrawCommissionValue.font
        
        lblTitleTotalCommission.textColor = .spade_white_FFFFFF
        lblTitleAvailableCommision.textColor = lblTitleTotalCommission.textColor
        lblTitleWithdrawCommission.textColor = lblTitleTotalCommission.textColor
        
        lblAvailableCommissionValue.textColor = lblTitleTotalCommission.textColor
        lblEnterAmount.textColor = lblTitleTotalCommission.textColor
        lblCurrency.textColor = lblTitleTotalCommission.textColor
        txtWithdrawCommissionValue.textColor = lblTitleTotalCommission.textColor
        
        txtWithdrawCommissionValue.delegate = self
        txtWithdrawCommissionValue.keyboardType = .numberPad
        txtWithdrawCommissionValue.returnKeyType = .done
        
        fromContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 70)
        fromContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        toContainer.backgroundColor = fromContainer.backgroundColor
        fromContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        toContainer.layer.cornerRadius = fromContainer.layer.cornerRadius
        fromContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 2)
        toContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 2)

        imgSwapHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        lblSwap.text = KKUtil.languageSelectedStringForKey(key: "wallet_swap")
        lblSwap.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        lblSwap.textColor = .spade_white_FFFFFF

    }
    
    func updateValue() {
        if let info = rebateInfo {
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

extension KKWalletViewController: UITextFieldDelegate {
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
