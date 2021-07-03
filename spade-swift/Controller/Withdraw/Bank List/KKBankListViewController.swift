//
//  KKBankListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKBankListViewController: KKBaseViewController {
    
    @IBOutlet weak var addContainer: UIView!
    @IBOutlet weak var lblAddBank: UILabel!
    @IBOutlet weak var addContainerHeight: NSLayoutConstraint!

    @IBOutlet weak var bankTableView: UITableView!

    var userBankList: [KKPageDataUserBankCards]! = []
    var companyBankList: [KKPageDataUserBankCards]! = []
    var bankListOptions: [PickerDetails]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        getBankListAPI()
    }
    
    func initialLayout(){
        addContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 50)
        addContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        addContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        addContainer.layer.cornerRadius = 8
        
        lblAddBank.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblAddBank.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank")
        lblAddBank.textColor = .spade_white_FFFFFF
            
        bankTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        bankTableView.register(UINib(nibName: "KKBankTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bankTVCIdentifier)
    }
    
    func changeAddBankView() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        
        let vc = KKAddBankViewController.init()
        vc.bankListOptions = bankListOptions

        vc.tableContentView = self.view
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(vc.view)
        self.addChild(vc)
    }
    
    func getBankListAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.depositPageData().execute { depositPageDataResponse in
            self.hideAnimatedLoader()
            self.userBankList = depositPageDataResponse.results?.userBankCards
            self.companyBankList = depositPageDataResponse.results?.companyBanks
            self.updateView()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
            self.updateView()
        }
    }
    
    func updateView() {
        if (self.companyBankList.count > 0) {
            for bank in self.companyBankList {
                var bankDetail = PickerDetails()
                bankDetail.id = String(bank.bankId ?? -1)
                bankDetail.name = bank.bankName ?? ""
                
                self.bankListOptions.append(bankDetail)
            }
            self.bankTableView.reloadData()
            self.bankTableView.isHidden = false
        } else {
            self.bankTableView.isHidden = true
        }
    }
    
    @IBAction func btnAddDidPressed() {
        if (userBankList.count >= 2) {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_bank_limit"))
            return
        }
        
        changeAddBankView()
    }
}

extension KKBankListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBankList.count //+ 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = KKUtil.languageSelectedStringForKey(key: "add_bank_all_bank_account")
        label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        label.textColor = .spade_white_FFFFFF
        label.backgroundColor = .clear
        label.frame = CGRect(x: 22, y: 0, width: addContainer.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 20))
        
        return label
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = KKUtil.languageSelectedStringForKey(key: "add_bank_prompt")
        label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        label.textColor = .spade_yellow_FFFF00
        label.backgroundColor = .clear
        label.frame = CGRect(x: 22, y: 10, width: addContainer.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 20))
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bankTVCIdentifier, for: indexPath) as? KKBankTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.imgSelected.isHidden = true

//        if (indexPath.row == 0) {
//            cell.containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
//            cell.lblBankName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
//
//            cell.lblBankName.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank")
//            cell.lblBankAccount.isHidden = true
//            cell.lblAccountName.isHidden = true
//            cell.lblAccountNameHeight.constant = 0
//            cell.imgBank.image = UIImage(named: "ic_add")
//        } else {
            cell.containerView.layer.borderWidth = 0
 
            if let bankAccNumber = userBankList[indexPath.row].bankAccountNumber {
                if bankAccNumber.isEmpty {
                    cell.lblBankAccount.text = ""
                } else {
                    cell.lblBankAccount.text = userBankList[indexPath.row].bankAccountNumber!.bankAccountMasked
                }
            }
            cell.imgBank.setUpImage(with: userBankList[indexPath.row].bankImg)
            cell.lblBankName.text = userBankList[indexPath.row].bankName
            cell.lblAccountName.text = userBankList[indexPath.row].bankAccountName
            cell.lblBankAccount.isHidden = false
            cell.lblAccountName.isHidden = false
            cell.lblAccountNameHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
//        }
        
        cell.selectionStyle = .none

        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (indexPath.row == 0) {
//            changeAddBankView()
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 60)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 30)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 20)
    }
}
