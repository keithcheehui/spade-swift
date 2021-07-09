//
//  KKMyAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/05/2021.
//

import Foundation
import UIKit
import Photos

class KKMyAffiliateViewController: KKBaseViewController {
    
    @IBOutlet weak var lblMyID: UILabel!
    @IBOutlet weak var lblMyIDView: UIView!
    @IBOutlet weak var lblMyIDValue: UILabel!
    
    @IBOutlet weak var lblReferrerID: UILabel!
    @IBOutlet weak var lblReferrerIDView: UIView!
    @IBOutlet weak var lblReferrerIDValue: UILabel!
    
    @IBOutlet weak var lblMemberCount: UILabel!
    @IBOutlet weak var lblMemberCountView: UIView!
    @IBOutlet weak var lblMemberCountValue: UILabel!
    
    @IBOutlet weak var totalCommissionContainer: UIView!
    @IBOutlet weak var lblTitleTotalCommission: UILabel!
    @IBOutlet weak var lblTotalCommisionView: UIView!
    @IBOutlet weak var lblTotalCommisionValue: UILabel!
    
    @IBOutlet weak var totalTurnoverContainer: UIView!
    @IBOutlet weak var lblTitleTotalTurnover: UILabel!
    @IBOutlet weak var lblTotalTurnoverView: UIView!
    @IBOutlet weak var lblTotalTurnoverValue: UILabel!
    
    @IBOutlet weak var qrCodeContainer: UIView!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var lblSaveImage: UILabel!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var lblCopy: UILabel!
    
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
    
    @IBOutlet weak var myIDViewHeight: NSLayoutConstraint!
    @IBOutlet weak var myIDViewMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var myIDViewMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var iconMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight: NSLayoutConstraint!
    @IBOutlet weak var iconMarginLeft2: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight2: NSLayoutConstraint!
    @IBOutlet weak var amountMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var amountMarginRight: NSLayoutConstraint!

    @IBOutlet weak var btnCollectHeight: NSLayoutConstraint!
    @IBOutlet weak var btnShareHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCopyHeight: NSLayoutConstraint!

    var affiliateInfo: KKAffiliateProfileAffiliate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        updateValue()
    }
    
    func initialLayout(){
        titleContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        myIDViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 22)
        iconWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: 45))
        
        iconMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 20)
        iconMarginRight.constant = iconMarginLeft.constant
        iconMarginLeft2.constant = iconMarginLeft.constant
        iconMarginRight2.constant = iconMarginLeft.constant
        amountMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 10)
        amountMarginRight.constant = amountMarginLeft.constant
        myIDViewMarginLeft.constant = amountMarginLeft.constant
        myIDViewMarginRight.constant = amountMarginLeft.constant
        
        btnCopyHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        btnShareHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        btnCollectHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)

        lblMyIDView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        lblReferrerIDView.backgroundColor = lblMyIDView.backgroundColor
        lblMemberCountView.backgroundColor = lblMyIDView.backgroundColor
        
        urlView.backgroundColor = lblMyIDView.backgroundColor
        totalCommissionContainer.backgroundColor = lblMyIDView.backgroundColor
        lblTotalCommisionView.backgroundColor = lblMyIDView.backgroundColor
        availableCommissionContainer.backgroundColor = lblMyIDView.backgroundColor
        lblAvailableCommissionView.backgroundColor = lblMyIDView.backgroundColor
        totalTurnoverContainer.backgroundColor = lblMyIDView.backgroundColor
        lblTotalTurnoverView.backgroundColor = lblMyIDView.backgroundColor
        withdrawCommissionContainer.backgroundColor = lblMyIDView.backgroundColor
        lblWithdrawCommissionView.backgroundColor = lblMyIDView.backgroundColor

        lblMyIDView.layer.cornerRadius = 4
        lblReferrerIDView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblMemberCountView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        
        urlView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblTotalCommisionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblTotalTurnoverView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblAvailableCommissionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblWithdrawCommissionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        qrCodeContainer.layer.cornerRadius = 8

        lblMyID.text = KKUtil.languageSelectedStringForKey(key: "my_affi_my_id")
        lblReferrerID.text = KKUtil.languageSelectedStringForKey(key: "my_affi_referrer_id")
        lblMemberCount.text = KKUtil.languageSelectedStringForKey(key: "my_affi_member_count")
        
        lblSaveImage.text = KKUtil.languageSelectedStringForKey(key: "my_affi_save")
        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "my_affi_copy")
        lblTitleTotalCommission.text = KKUtil.languageSelectedStringForKey(key: "my_affi_total_com")
        lblTitleTotalTurnover.text = KKUtil.languageSelectedStringForKey(key: "my_affi_total_turnover")
        lblTitleAvailableCommision.text = KKUtil.languageSelectedStringForKey(key: "my_affi_available_com")
        lblTitleWithdrawCommission.text = KKUtil.languageSelectedStringForKey(key: "my_affi_withdraw_com")
        lblEnterAmount.text = KKUtil.languageSelectedStringForKey(key: "my_affi_enter_amt")
        lblTips.text = KKUtil.languageSelectedStringForKey(key: "my_affi_tips")
        
        lblMyID.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 9))
        lblMyIDValue.font = lblMyID.font
        lblReferrerID.font = lblMyID.font
        lblReferrerIDValue.font = lblMyID.font
        lblMemberCount.font = lblMyID.font
        lblMemberCountValue.font = lblMyID.font
        
        lblTitleTotalCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 11 : 12))
        lblTitleTotalTurnover.font = lblTitleTotalCommission.font
        lblTitleAvailableCommision.font = lblTitleTotalCommission.font
        lblTitleWithdrawCommission.font = lblTitleTotalCommission.font
        
        lblTotalCommisionValue.font = lblMyID.font
        lblTotalTurnoverValue.font = lblMyID.font
        lblAvailableCommissionValue.font = lblMyID.font
        lblEnterAmount.font = lblMyID.font
        lblCurrency.font = lblMyID.font
        txtWithdrawCommissionValue.font = lblMyID.font
        lblTips.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        
        lblSaveImage.font = lblMyID.font
        lblURL.font = lblMyID.font
        lblCopy.font = lblMyID.font

        lblMyID.textColor = UIColor.spade_white_FFFFFF
        lblMyIDValue.textColor = lblMyIDValue.textColor
        lblReferrerID.textColor = lblMyID.textColor
        lblReferrerIDValue.textColor = lblMyIDValue.textColor
        lblMemberCount.textColor = lblMyID.textColor
        lblMemberCountValue.textColor = lblMyIDValue.textColor
        
        lblTitleTotalCommission.textColor = lblMyID.textColor
        lblTitleTotalTurnover.textColor = lblMyID.textColor
        lblTitleAvailableCommision.textColor = lblMyID.textColor
        lblTitleWithdrawCommission.textColor = lblMyID.textColor
        
        lblTotalCommisionValue.textColor = lblMyIDValue.textColor
        lblTotalTurnoverValue.textColor = lblMyIDValue.textColor
        lblAvailableCommissionValue.textColor = lblMyIDValue.textColor
        lblEnterAmount.textColor = lblMyIDValue.textColor
        lblCurrency.textColor = lblMyIDValue.textColor
        txtWithdrawCommissionValue.textColor = lblMyIDValue.textColor
        lblTips.textColor = lblMyIDValue.textColor
        
        lblSaveImage.textColor = UIColor.spade_black_000000
        lblURL.textColor = lblMyIDValue.textColor
        lblCopy.textColor = lblMyIDValue.textColor
        
        txtWithdrawCommissionValue.delegate = self
        txtWithdrawCommissionValue.keyboardType = .numberPad
        txtWithdrawCommissionValue.returnKeyType = .done
    }
    
    func updateValue() {
        if let info = affiliateInfo {
            if let userId = KKUtil.decodeUserProfileFromCache()?.code {
                lblMyIDValue.text = userId
            }
            if let referrerCode = info.referrerCode {
                lblReferrerIDValue.text = referrerCode
            }
            if let memberRecruited = info.memberRecruited {
                lblMemberCountValue.text = String(format: "\(memberRecruited)")
            }
            if let url = info.affiliateUrl {
                lblURL.text = url
            }
            if let commission = info.commission {
                lblTotalCommisionValue.text = commission.total
                lblTotalTurnoverValue.text = commission.turnover
                lblAvailableCommissionValue.text = commission.available
            }
        }
        lblCurrency.text = KKUtil.decodeUserCountryFromCache().currency
    }
    
    ///Button Actions
    @IBAction func btnSaveQRDidPressed(){
        writeToPhotoAlbum(image: UIImage(named: "ic_sample_qr")!)
    }
    
    @IBAction func clearText() {
        txtWithdrawCommissionValue.text = ""
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc
    func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
    @IBAction func btnCopyURLDidPressed(){
        UIPasteboard.general.string = "[Hardcode data] - this is a hard code text"
        self.showAlertView(type: .Success, alertMessage: KKUtil.languageSelectedStringForKey(key: "alert_copied"))
    }
    
    @IBAction func btnShareDidPressed() {
        let text = "[Hardcode data] - this is a hard code text"
        let shareAll = [text]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
            self.showAlertView(type: .Success, alertMessage: KKUtil.languageSelectedStringForKey(key: "alert_shared"))
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnCollectCommissionDidPressed(){
        if let text = txtWithdrawCommissionValue.text {
            if text.isEmpty {
                self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_amount_empty"))
                return
            }
            affiliateCollectAPI(amount: text)
        }
    }
    
    //MARK: API Call
    func affiliateCollectAPI(amount: String){
        self.showAnimatedLoader()
        KKApiClient.affiliateCollect(amount: amount).execute{ response in
            self.hideAnimatedLoader()
            NotificationCenter.default.post(name: Notification.Name("NotificationGetMyAffiliate"), object: nil)
            self.clearText()
            self.showAlertView(type: .Success, alertMessage: response.message ?? "")
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
}

extension KKMyAffiliateViewController: UITextFieldDelegate {
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
