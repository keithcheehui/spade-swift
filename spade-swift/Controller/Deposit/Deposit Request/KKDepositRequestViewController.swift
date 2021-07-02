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
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblAccountNameValue: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblAccountNumberValue: UILabel!
    @IBOutlet weak var lblCopy: UILabel!

    @IBOutlet weak var depositSectionView: UIView!
    @IBOutlet weak var lblDepositSection: UILabel!
    
    @IBOutlet weak var lblDepositTime: UILabel!
    @IBOutlet weak var lblDepositTimeView: UIView!
    @IBOutlet weak var txtDepositTime: UITextField!

    @IBOutlet weak var lblDepositChannel: UILabel!
    @IBOutlet weak var lblDepositChannelView: UIView!
    @IBOutlet weak var txtDepositChannel: UITextField!
    
    @IBOutlet weak var lblDepositAmount: UILabel!
    @IBOutlet weak var lblDepositAmountView: UIView!
    @IBOutlet weak var txtDepositAmount: UITextField!
    
    @IBOutlet weak var lblReferenceNo: UILabel!
    @IBOutlet weak var lblReferenceNoView: UIView!
    @IBOutlet weak var txtReferenceNo: UITextField!
    
    @IBOutlet weak var lblPromotion: UILabel!
    @IBOutlet weak var lblPromotionView: UIView!
    @IBOutlet weak var txtPromotion: UITextField!
    
    @IBOutlet weak var lblReceipt: UILabel!
    @IBOutlet weak var lblReceiptValue: UILabel!
    @IBOutlet weak var receiptButtonContainer: UIView!
    
    @IBOutlet weak var bankSectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var lblBankNameWidth: NSLayoutConstraint!
    @IBOutlet weak var btnCopyWidth: NSLayoutConstraint!
    @IBOutlet weak var depositItemMargin: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    
//    var imagePicker = UIImagePickerController()
    let pickerController = UIImagePickerController()

    var dataResults: KKDepositPageDataResults!
    var userBankList: [KKPageDataUserBankCards]! = []
    var companyBankList: [KKPageDataUserBankCards]! = []
    var depositChannelList: [KKDepositPageDataDepositChannels]! = []
    var promotionsList: [KKDepositPageDataPromotions]! = []
    
    var companyBankItemList: [PickerDetails]! = []
    var channelItemList: [PickerDetails]! = []
    var promotionItemList: [PickerDetails]! = []

    var selectedBankItem: PickerDetails!
    var selectedChannelItem: PickerDetails!
    var selectedPromoItem: PickerDetails!
    var selectedReceipt64: String!
    
    var currentPicker: Int!
    enum CurrentPicker: Int {
        case bankName = 0
        case channel = 1
        case promotion = 2
        case date = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        uploadedReceipt(isUploaded: false)
        
        if let bankList = dataResults.userBankCards {
            userBankList = bankList
        }
        
        if let companyList = dataResults.companyBanks {
            companyBankList = companyList
            if (companyBankList.count > 0) {
                for bank in companyBankList {
                    var detail = PickerDetails()
                    detail.id = String(bank.bankId ?? -1)
                    detail.name = bank.bankName ?? ""
                    companyBankItemList.append(detail)
                }
                selectedBankItem = companyBankItemList[0]
                currentPicker = CurrentPicker.bankName.rawValue
                populatePickerInfo()
            }
        }
        
        if let channelList = dataResults.depositChannels {
            depositChannelList = channelList
            if (depositChannelList.count > 0) {
                for channel in depositChannelList {
                    var detail = PickerDetails()
                    detail.id = channel.code ?? ""
                    detail.name = channel.name ?? ""
                    channelItemList.append(detail)
                }
                selectedChannelItem = channelItemList[0]
                currentPicker = CurrentPicker.channel.rawValue
                populatePickerInfo()
            }
        }
        
        if let promoList = dataResults.promotions {
            promotionsList = promoList
            var detail = PickerDetails()
            detail.id = "-1"
            detail.name = KKUtil.languageSelectedStringForKey(key: "deposit_promotion_placeholder")
            promotionItemList.append(detail)
            
            if (promotionsList.count > 0) {
                for promo in promotionsList {
                    var detail = PickerDetails()
                    detail.id = promo.promoCode ?? ""
                    detail.name = promo.name ?? ""
                    promotionItemList.append(detail)
                }
            }
            selectedPromoItem = promotionItemList[0]
            currentPicker = CurrentPicker.promotion.rawValue
            populatePickerInfo()
        }
    }
    
    func initialLayout(){
        bankSectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        textFieldHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        lblBankNameWidth.constant = KKUtil.ConvertSizeByDensity(size: 85)
        btnCopyWidth.constant = KKUtil.ConvertSizeByDensity(size: 50)
        depositItemMargin.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
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
        lblDepositTime.text = KKUtil.languageSelectedStringForKey(key: "deposit_date")
        lblDepositChannel.text = KKUtil.languageSelectedStringForKey(key: "deposit_channel")
        lblDepositAmount.text = KKUtil.languageSelectedStringForKey(key: "deposit_amount")
        lblReferenceNo.text = KKUtil.languageSelectedStringForKey(key: "deposit_ref_no")
        lblPromotion.text = KKUtil.languageSelectedStringForKey(key: "deposit_promotion")
        lblReceipt.text = KKUtil.languageSelectedStringForKey(key: "deposit_receipt")

        txtReferenceNo.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "deposit_ref_no_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtDepositTime.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "deposit_select_date"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblBankSection.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblDepositSection.font = lblBankSection.font

        lblBankName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        txtBankName.font = lblBankName.font
        lblAccountName.font = lblBankName.font
        lblAccountNameValue.font = lblBankName.font
        lblAccountNumber.font = lblBankName.font
        lblAccountNumberValue.font = lblBankName.font
        lblCopy.font = lblBankName.font
        lblDepositTime.font = lblBankName.font
        txtDepositTime.font = lblBankName.font
        lblDepositChannel.font = lblBankName.font
        txtDepositChannel.font = lblBankName.font
        lblDepositAmount.font = lblBankName.font
        txtDepositAmount.font = lblBankName.font
        lblReferenceNo.font = lblBankName.font
        txtReferenceNo.font = lblBankName.font
        lblPromotion.font = lblBankName.font
        txtPromotion.font = lblBankName.font
        lblReceipt.font = lblBankName.font
        lblReceiptValue.font = lblBankName.font
        
        lblBankSection.textColor = UIColor.spade_white_FFFFFF
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

        lblAccountNameValue.textColor = UIColor.spade_white_FFFFFF
        txtBankName.textColor = lblAccountNameValue.textColor
        lblAccountNumberValue.textColor = lblAccountNameValue.textColor
        lblCopy.textColor = lblAccountNameValue.textColor
        txtDepositTime.textColor = lblAccountNameValue.textColor
        txtDepositChannel.textColor = lblAccountNameValue.textColor
        txtDepositAmount.textColor = lblAccountNameValue.textColor
        txtReferenceNo.textColor = lblAccountNameValue.textColor
        txtPromotion.textColor = lblAccountNameValue.textColor
        lblReceiptValue.textColor = lblAccountNameValue.textColor
        
        txtBankName.inputView = pickerView
        txtBankName.inputAccessoryView = pickerToolBarView
        txtBankName.delegate = self
        
        txtDepositChannel.inputView = pickerView
        txtDepositChannel.inputAccessoryView = pickerToolBarView
        txtDepositChannel.delegate = self
        
        txtPromotion.inputView = pickerView
        txtPromotion.inputAccessoryView = pickerToolBarView
        txtPromotion.delegate = self
        
        txtDepositTime.inputView = datePickerView
        txtDepositTime.inputAccessoryView = pickerToolBarView
        txtDepositTime.delegate = self
    }
    
    func updatePlaceholder(min: Int?, max: Int?) {
        if let minWithdraw = min, let maxWithdraw = max {
            let minFloat = KKUtil.addCurrencyFormatWithInt(value: minWithdraw)
            let maxFloat = KKUtil.addCurrencyFormatWithInt(value: maxWithdraw)
            let placeholder = String(format: KKUtil.languageSelectedStringForKey(key: "deposit_amount_placeholder"), minFloat, maxFloat)
            
            txtDepositAmount.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        } else {
            let placeholder = String(format: KKUtil.languageSelectedStringForKey(key: "deposit_amount_placeholder"), 0, 0)

            txtDepositAmount.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        }
    }
    
    func uploadedReceipt(isUploaded: Bool){
        if (isUploaded){
            lblReceiptValue.text = "Receipt.jpeg"
            lblReceiptValue.isHidden = false
            receiptButtonContainer.isHidden = true
        } else {
            lblReceiptValue.isHidden = true
            receiptButtonContainer.isHidden = false
        }
    }
    
    //MARK:- API Calls
    
//    func depositHistoryAPI() {
//
//        self.showAnimatedLoader()
//
//        KKApiClient.depositHistory(historyStatus: "").execute { depositHistoryResponse in
//
//            self.hideAnimatedLoader()
//            let viewController = KKGeneralPopUpTableViewController.init()
//            viewController.leftDropdownOptions = pickerTimeArray
//            viewController.rightDropdownOptions = pickerStatusArray
//            viewController.tableViewType = .DepositHistory
//            viewController.depositHistoryArray = depositHistoryResponse.results?.depositHistory
//            self.present(viewController, animated: false, completion: nil)
//
//        } onFailure: { errorMessage in
//
//            self.hideAnimatedLoader()
//            self.showAlertView(type: .Error, alertMessage: errorMessage)
//        }
//    }
    
    func validate() {
        if (txtDepositTime.text!.isEmpty) {
            return
        }
        
        if (txtDepositAmount.text!.isEmpty) {
            return
        }
        
        if (txtBankName.text!.isEmpty) {
            return
        }
        
        if (txtDepositChannel.text!.isEmpty) {
            return
        }
        
        if (txtReferenceNo.text!.isEmpty) {
            return
        }
        
        if (txtPromotion.text!.isEmpty) {
            return
        }
        
        if (selectedReceipt64.isEmpty) {
            return
        }
        
        depositAPI()
        
    }
    
    func depositAPI() {
        return;
        
        self.showAnimatedLoader()
        
        let parameter = [
            APIKeys.depositTime: txtDepositTime.text!,
            APIKeys.depositAmount: txtDepositAmount.text!,
            APIKeys.companyBankID: selectedBankItem.id,
            APIKeys.depositChannelCode: txtDepositChannel.text!,
            APIKeys.referenceNumber: txtReferenceNo.text!,
            APIKeys.receipt: selectedReceipt64,
            APIKeys.promotionCode: txtPromotion.text!,
            
        ] as [String : Any]
        
        KKApiClient.deposit(parameter: parameter).execute { response in
            self.hideAnimatedLoader()
            
            let viewController = KKDialogAlertViewController.init()
            viewController.alertType = .Deposit
            viewController.transactionId = ""
            self.present(viewController, animated: true, completion: nil)
            
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    ///Button Actions
    @IBAction func btnBankNameDidPressed(){

    }
    
    @IBAction func btnCopyDidPressed(){
        if let value = lblAccountNumberValue.text {
            if value.isEmpty {
                return
            }
            
            UIPasteboard.general.string = lblAccountNumberValue.text
            self.showAlertView(type: .Success, alertMessage: KKUtil.languageSelectedStringForKey(key: "alert_copied"))
        }
    }
    
//    @IBAction func btnDepositHistoryDidPressed(){
//        self.depositHistoryAPI()
//    }
    
    @IBAction func btnChannelDidPressed(){

    }
    
    @IBAction func btnPromotionDidPressed(){

    }
    
    @IBAction func btnUploadDidPressed(){
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//
//            present(imagePicker, animated: true, completion: nil)
//        }
        
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
    
    @IBAction func btnSubmitDidPressed(){

    }
    
    @objc
    override func handleDateSelection(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy/MM/dd HH:mm"
        let dateString = dateFormatter.string(from: picker.date);

        txtDepositTime.text = dateString
    }
    
    @objc
    override func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
        if (selectedPickerItem == nil) {
            return
        }
        
        switch currentPicker {
        case CurrentPicker.bankName.rawValue:
            selectedBankItem = selectedPickerItem
            break
            
        case CurrentPicker.channel.rawValue:
            selectedChannelItem = selectedPickerItem
            break
            
        case CurrentPicker.promotion.rawValue:
            selectedPromoItem = selectedPickerItem
            break
            
//        case CurrentPicker.date.rawValue:
//            break

        default: break
        }
        
        populatePickerInfo()
    }
    
    func populatePickerInfo() {
        switch currentPicker {
        case CurrentPicker.bankName.rawValue:
            if let bankList = companyBankList, let pickerList = companyBankItemList {
                if bankList.count > 0 && pickerList.count > 0 {
                    let detail = bankList.first(where: {$0.bankId! == Int(selectedBankItem.id)})
                    if detail == nil {
                        
                    } else {
                        lblAccountNameValue.text = detail!.bankAccountName
                        lblAccountNumberValue.text = detail!.bankAccountNumber
                        txtBankName.text = detail!.bankName
                        updatePlaceholder(min: detail!.bankMinDeposit, max: detail!.bankMaxDeposit)
                    }
                }
            }
            break
            
        case CurrentPicker.channel.rawValue:
            txtDepositChannel.text = selectedChannelItem.name
            break
            
        case CurrentPicker.promotion.rawValue:
            txtPromotion.text = selectedPromoItem.name
            break
            
        case CurrentPicker.date.rawValue:
            break

        default: break
        }
        
    }
}

extension KKDepositRequestViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBankName {
            showPickerView(optionList: companyBankItemList)
            pickerTextField = textField
            currentPicker = CurrentPicker.bankName.rawValue
        } else if textField == txtDepositChannel {
            showPickerView(optionList: channelItemList)
            pickerTextField = textField
            currentPicker = CurrentPicker.channel.rawValue
        } else if textField == txtPromotion {
            showPickerView(optionList: promotionItemList)
            pickerTextField = textField
            currentPicker = CurrentPicker.promotion.rawValue
        } else if textField == txtDepositTime {
            showDatePickerView(showTime: true)
            datePickerTextField = textField
        }
        
        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
    
    private func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == txtBankName || textField == txtDepositChannel || textField == txtPromotion {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension KKDepositRequestViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
////        self.dismiss(animated: true, completion: { () -> Void in
////
////        })
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//
//            }
//
//
//        let jpegCompressionQuality: CGFloat = 0.9 // Set this to whatever suits your purpose
//        if let base64String = image.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString() {
//            selectedReceipt64 = base64String
//            uploadedReceipt(isUploaded: true)
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        let jpegCompressionQuality: CGFloat = 0.9 // Set this to whatever suits your purpose
        if let base64String = image.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString() {
            uploadedReceipt(isUploaded: true)
        }
        
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: imagePath)
//
//            uploadedReceipt(isUploaded: true)
//        }

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
