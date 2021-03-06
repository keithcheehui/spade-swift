//
//  KKWithdrawRequestViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKWithdrawRequestViewController: KKBaseViewController {
    
    @IBOutlet weak var lblWithdrawAmount: UILabel!
    @IBOutlet weak var txtWithdrawAmountView: UIView!
    @IBOutlet weak var txtWithdrawAmount: UITextField!
    @IBOutlet weak var lblNotice: UILabel!
    
    @IBOutlet weak var addBankContainer: UIView!
    @IBOutlet weak var lblTitleWithdraw: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var bankListContainer: UIView!
    @IBOutlet weak var lblSelectBank: UILabel!
    @IBOutlet weak var bankTableView: UITableView!

    @IBOutlet weak var withdrawContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var addBankContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
        
    var userBankList: [KKUserBankCards]! = []
    var selectedBankItem = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        changeLayoutView(noBank: userBankList.isEmpty)
        setNoticeLabel(min: userBankList[selectedBankItem].bank?.minWithdrawal, max: userBankList[selectedBankItem].bank?.maxWithdrawal)
    }
    
    func initialLayout(){
        withdrawContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        txtWithdrawAmountView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addBankContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)

        txtWithdrawAmountView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        addBankContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        addBankContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        addBankContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        
        lblWithdrawAmount.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_amount")
        lblTitleWithdraw.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
        lblDescription.text = KKUtil.languageSelectedStringForKey(key: "withdraw_description")
        lblSelectBank.text = KKUtil.languageSelectedStringForKey(key: "withdraw_select_bank")

        txtWithdrawAmount.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblWithdrawAmount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        txtWithdrawAmount.font = lblWithdrawAmount.font
        lblNotice.font = lblWithdrawAmount.font
        lblSelectBank.font = lblWithdrawAmount.font
        lblTitleWithdraw.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblDescription.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        
        lblWithdrawAmount.textColor = UIColor.spade_white_FFFFFF
        txtWithdrawAmount.textColor = lblWithdrawAmount.textColor
        lblTitleWithdraw.textColor = lblWithdrawAmount.textColor
        lblDescription.textColor = lblWithdrawAmount.textColor
        lblSelectBank.textColor = lblWithdrawAmount.textColor
        lblNotice.textColor = UIColor.spade_orange_FFBA00
        
        bankTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        bankTableView.register(UINib(nibName: "KKBankTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bankTVCIdentifier)

        txtWithdrawAmount.keyboardType = .numberPad
        txtWithdrawAmount.delegate = self
        
        changeLayoutView(noBank: true)
    }
    
    func setNoticeLabel(min: String?, max: String?) {
        let currency = KKUtil.decodeUserCountryFromCache().currency ?? ""

        if let minWithdraw = min, let maxWithdraw = max {
            lblNotice.text = String(format: KKUtil.languageSelectedStringForKey(key: "withdraw_notice"), currency, minWithdraw, currency, maxWithdraw)
        } else {
            lblNotice.text = String(format: KKUtil.languageSelectedStringForKey(key: "withdraw_notice"), currency, 0, currency, 0)
        }
    }
    
    func changeLayoutView(noBank: Bool) {
        if (noBank){
            bankListContainer.isHidden = true
            addBankContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 55)
        } else {
            bankListContainer.isHidden = false
            addBankContainerHeight.constant = 0
        }
    }

    func validateEnty() {
        if (userBankList.isEmpty) {
            return
        }
        withdrawAPI()
    }
    
    func withdrawAPI(){
        self.showAnimatedLoader()
        
        let amount: String = txtWithdrawAmount.text!
        let amountFloat = Float(amount)
        
        let bankId = userBankList[selectedBankItem].bank?.id ?? 0
        
        KKApiClient.withdraw(amount: amountFloat!, bankId: bankId).execute { withdrawResponse in
            self.hideAnimatedLoader()
            self.txtWithdrawAmount.text = ""
            
            let viewController = KKDialogAlertViewController.init()
            viewController.alertType = .Withdraw
            viewController.message = withdrawResponse.message
            self.present(viewController, animated: true, completion: nil)
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    ///Button Actions
    @IBAction func btnClearDidPressed(){
        txtWithdrawAmount.text = ""
    }
    
    @IBAction func btnConfirmDidPressed(){
        validateEnty()
    }
    
}

extension KKWithdrawRequestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bankTVCIdentifier, for: indexPath) as? KKBankTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == selectedBankItem) {
            cell.imgSelected.isHidden = false
            cell.containerView.layer.borderWidth = 1
            cell.containerView.layer.borderColor = UIColor.spade_green_8AD942.cgColor
        } else {
            cell.imgSelected.isHidden = true
            cell.containerView.layer.borderWidth = 0
        }
 
        cell.lblBankAccount.text = userBankList[indexPath.row].bankAccountNumber?.bankAccountMasked
        cell.lblAccountName.text = userBankList[indexPath.row].bankAccountName
        cell.imgBank.setUpImage(with: userBankList[indexPath.row].bank?.img)
        cell.lblBankName.text = userBankList[indexPath.row].bank?.name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBankItem = indexPath.row
        setNoticeLabel(min: userBankList[selectedBankItem].bank?.minWithdrawal, max: userBankList[selectedBankItem].bank?.maxWithdrawal)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 60)
    }
}

extension KKWithdrawRequestViewController: UITextFieldDelegate {
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
