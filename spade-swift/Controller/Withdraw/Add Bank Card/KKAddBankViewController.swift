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
    
    //TODO: remember change to get API
    var bankItemList: [PickerDetails]! = []
    var selectedBankItem: PickerDetails!

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
        
        lblCardholderName.text = KKUtil.languageSelectedStringForKey(key: "add_bank_bank_account_name")
        lblBankName.text = KKUtil.languageSelectedStringForKey(key: "add_bank_bank_name")
        lblBankAccount.text = KKUtil.languageSelectedStringForKey(key: "add_bank_bank_account_number")
        lblDescription.text = KKUtil.languageSelectedStringForKey(key: "add_bank_description")

        txtCardholderName.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "add_bank_bank_account_name_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtBankName.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "add_bank_bank_name_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtBankAccount.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "add_bank_bank_account_number_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
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
        lblDescription.textColor = UIColor.spade_yellow_FFFF00
                
        txtBankName.inputView = pickerView
        txtBankName.inputAccessoryView = pickerToolBarView
        
        txtBankAccount.keyboardType = .numberPad
        
        txtCardholderName.delegate = self
        txtBankName.delegate = self
        txtBankAccount.delegate = self
    }
    
    func validationField() {
        if txtCardholderName.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_account_name_empty"))
            return
        }
        
        if txtBankName.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_bank_name_empty"))
            return
        }
        
        if txtBankAccount.text!.count == 0 {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_error_account_number_empty"))
            return
        }
        
        addUserBankCardAPI()
    }
    
    //MARK: - API
    func addUserBankCardAPI(){
        self.showAnimatedLoader()
        //TODO: change bank id
        KKApiClient.addUserBankCard(bankAccountNo: txtCardholderName.text!, bankAccountName: txtBankAccount.text!, bankId: selectedBankItem.id).execute { addBankResponse in
            
            self.hideAnimatedLoader()
            self.backPreviousScreen()
            self.showAlertView(type: .Success, alertMessage: addBankResponse.message ?? "")
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @IBAction func btnBackDidPressed(){
        backPreviousScreen()
    }
    
    func backPreviousScreen() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        
        let vc = KKBankListViewController()
        vc.tableContentView = self.view
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(vc.view)
        self.addChild(vc)
    }
    
    @IBAction func btnConfirmDidPressed(){
        validationField()
    }
    
    @objc
    override func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
        if (selectedPickerItem == nil) {
            return
        }
        selectedBankItem = selectedPickerItem
    }
}

extension KKAddBankViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBankName {
            showPickerView(optionList: bankItemList)
            pickerTextField = textField
        }
        
        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
